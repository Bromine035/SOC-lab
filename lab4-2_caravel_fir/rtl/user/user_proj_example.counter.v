// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_proj_example
 *
 * This is an example of a (trivially simple) user project,
 * showing how the user project can connect to the logic
 * analyzer, the wishbone bus, and the I/O pads.
 *
 * This project generates an integer count, which is output
 * on the user area GPIO pads (digital output only).  The
 * wishbone connection allows the project to be controlled
 * (start and stop) from the management SoC program.
 *
 * See the testbenches in directory "mprj_counter" for the
 * example programs that drive this user project.  The three
 * testbenches are "io_ports", "la_test1", and "la_test2".
 *
 *-------------------------------------------------------------
 */

`define FIR_ADDR 'h3000_0000;
`define RAM_ADDR 'h3800_0000;

module user_proj_example #(
    parameter BITS = 32,
    parameter DELAYS=10
)(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output reg wbs_ack_o,
    output reg [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // IRQ
    output [2:0] irq
);
    //=====================================================================
    //   REG AND WIRE DECLARATION
    //=====================================================================
    wire clk;
    wire rst;

    wire [`MPRJ_IO_PADS-1:0] io_in;
    wire [`MPRJ_IO_PADS-1:0] io_out;
    wire [`MPRJ_IO_PADS-1:0] io_oeb;
    //========== WB Decoder ==========
    reg [1:0] sel;
    // RAM
    wire ram_wbs_cyc_i;
    wire ram_wbs_ack_o;
    wire [31:0] ram_wbs_dat_o;
    // FIR
    wire fir_wbs_cyc_i;
    wire fir_wbs_ack_o;
    wire [31:0] fir_wbs_dat_o;

    //=====================================================================
    //   DATA PATH & CONTROL
    //=====================================================================
    assign clk = wb_clk_i;
    assign rst = wb_rst_i;

    always @(*) begin
        sel[0] = (wbs_adr_i[31:24] == 'h30);    // FIR
        sel[1] = (wbs_adr_i[31:24] == 'h38);    // RAM
    end

    assign ram_wbs_cyc_i = wbs_cyc_i & sel[1];
    assign fir_wbs_cyc_i = wbs_cyc_i & sel[0];

    always @(*) begin
        case (sel)
            'b01: wbs_dat_o = fir_wbs_dat_o;
            'b10: wbs_dat_o = ram_wbs_dat_o;
            default: wbs_dat_o = 32'b0;
        endcase
    end

    always @(*) begin
        case (sel)
            'b01: wbs_ack_o = fir_wbs_ack_o;
            'b10: wbs_ack_o = ram_wbs_ack_o;
            default: wbs_ack_o = 1'b0;
        endcase
    end

    //========== Exmem-FIR ==========
    bram_wb user_bram (
        .wb_clk_i   (clk),
        .wb_rst_i   (rst),
        .wbs_stb_i  (wbs_stb_i),
        .wbs_cyc_i  (ram_wbs_cyc_i),
        .wbs_we_i   (wbs_we_i),
        .wbs_sel_i  (wbs_sel_i),
        .wbs_dat_i  (wbs_dat_i),
        .wbs_adr_i  (wbs_adr_i),
        .wbs_ack_o  (ram_wbs_ack_o),
        .wbs_dat_o  (ram_wbs_dat_o)
    );

    //========== Verilog-FIR ==========
    fir_wb user_fir (
        .wb_clk_i   (clk),
        .wb_rst_i   (rst),
        .wbs_stb_i  (wbs_stb_i),
        .wbs_cyc_i  (fir_wbs_cyc_i),
        .wbs_we_i   (wbs_we_i),
        .wbs_sel_i  (wbs_sel_i),
        .wbs_dat_i  (wbs_dat_i),
        .wbs_adr_i  (wbs_adr_i),
        .wbs_ack_o  (fir_wbs_ack_o),
        .wbs_dat_o  (fir_wbs_dat_o)
    );

endmodule



`default_nettype wire
