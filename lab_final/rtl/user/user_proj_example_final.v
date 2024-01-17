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

`default_nettype wire
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

module user_proj_example #(
    parameter BITS = 32,
    parameter DELAYS = 11
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
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

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

parameter idle = 4'd0; 
parameter busy = 4'd1;
parameter cpur = 4'd2;
parameter cpuw = 4'd3;
parameter firr = 4'd4;
parameter firw = 4'd5;
parameter mmr = 4'd6;
parameter mmw = 4'd7;
parameter qsr = 4'd8;
parameter qsw = 4'd9;

integer i0, i1;

wire clk;
wire rst;
wire valid;
wire decoded;
wire [127:0] la_data_out;
// wire [3:0] stt_fifo0, stt_fifo1, stt_fifo2, stt_fifo3, stt_fifo4, stt_fifo5, stt_fifo6, stt_fifo7, stt_fifo8, stt_fifo9, stt_fifo10;
reg [3:0] cst;
reg [31:0] wmmd, wmma;
reg [3:0] stt_fifo [DELAYS-1:0];
reg [3:0] rnff; // number of fifo

// assign stt_fifo0 = stt_fifo[0];
// assign stt_fifo1 = stt_fifo[1];
// assign stt_fifo2 = stt_fifo[2];
// assign stt_fifo3 = stt_fifo[3];
// assign stt_fifo4 = stt_fifo[4];
// assign stt_fifo5 = stt_fifo[5];
// assign stt_fifo6 = stt_fifo[6];
// assign stt_fifo7 = stt_fifo[7];
// assign stt_fifo8 = stt_fifo[8];
// assign stt_fifo9 = stt_fifo[9];
// assign stt_fifo10 = stt_fifo[10];
assign clk = wb_clk_i;
assign rst = wb_rst_i;
assign decoded = wbs_adr_i[31:20] == 12'h380 ? 1'b1 : 1'b0;
assign valid = wbs_cyc_i && wbs_stb_i && decoded; 
assign wbs_ack_o = (user_bram.ack && ((stt_fifo[rnff-1] == cpur) || (stt_fifo[rnff-1] == cpuw)));
assign wbs_dat_o = user_bram.dat_o;
assign la_data_out = {127'b0, (user_fir.ou_fin && user_mm.ou_fin && user_qs.ou_fin)};
assign io_out[32] = (user_fir.ou_fin && user_mm.ou_fin && user_qs.ou_fin);
assign io_oeb[32] = 1'b0;

always @(*) begin
    if(rst) begin
        cst <= idle;
    end
    else begin
        if((rnff == DELAYS) && !user_bram.ack) begin
            cst <= busy;
        end
        else if(valid && wbs_we_i) begin
            cst <= cpuw;
        end
        else if(valid) begin
            cst <= cpur;
        end
        else if(user_fir.ou_val && user_fir.ou_wrt) begin
            cst <= firw;
        end
        else if(user_fir.ou_val) begin
            cst <= firr;
        end
        else if(user_mm.ou_val && user_mm.ou_wrt) begin
            cst <= mmw;
        end
        else if(user_mm.ou_val) begin
            cst <= mmr;
        end
        else if(user_qs.ou_val && user_qs.ou_wrt) begin
            cst <= qsw;
        end
        else if(user_qs.ou_val) begin
            cst <= qsr;
        end
        else begin
            cst <= idle;
        end
    end
end

always @(posedge clk or posedge rst) begin
    if(rst) begin
        for (i0 = 0; i0 < DELAYS; i0 = i0 + 1) begin
            stt_fifo[i0] <= 4'b0;
        end
        rnff <= 4'b0;
    end
    else if((cst != idle) && (cst != busy)) begin
        stt_fifo[0] <= cst;
        for (i1 = 1; i1 < DELAYS; i1 = i1 + 1) begin
            stt_fifo[i1] <= (user_bram.ack && rnff < (i1 + 1))?(stt_fifo[i1]):(stt_fifo[i1 - 1]);
        end
        rnff <= (user_bram.ack)?(rnff):(rnff+1);
    end
    else if(user_bram.ack) begin
        rnff <= rnff - 1;
    end
    else begin
        rnff <= rnff;
    end
end

always @(*) begin
    if(rst) begin
        wmmd <= 32'b0;
        wmma <= 32'b0;
    end
    else begin
        if((cst == firr) || (cst == firw)) begin
            wmmd <= user_fir.ou_dat;
            wmma <= user_fir.ou_adr;
        end
        else if((cst == mmr) || (cst == mmw)) begin
            wmmd <= user_mm.ou_dat;
            wmma <= user_mm.ou_adr;
        end
        else if((cst == qsr) || (cst == qsw)) begin
            wmmd <= user_qs.ou_dat;
            wmma <= user_qs.ou_adr;
        end
        else begin
            wmmd <= wbs_dat_i;
            wmma <= wbs_adr_i;
        end
    end
end

exmem_pipeline user_bram (
    .clk(clk),
    .rst(rst),
    .stb((cst != idle) && (cst != busy)),
    .we((cst == cpuw) || (cst == firw) || (cst == mmw) || (cst == qsw)),
    .sel(((cst == cpur) || (cst == cpuw))?(wbs_sel_i):(4'b1111)),
    .dat_i(wmmd),
    .addr(wmma),
    .ack(),
    .dat_o()
);

fir #(.size_t(11), .size_x(16)) user_fir(
    .clk(clk),
    .rst(rst),
    .in_sta(io_in[31:16] == 16'hAB40),
    .in_val(user_bram.ack && (stt_fifo[rnff-1] == firr)),
    .in_dat(user_bram.dat_o),
    .in_ouval((cst == firr) || (cst == firw)),
    .ou_val(),
    .ou_adr(),
    .ou_dat(),
    .ou_wrt(),
    .ou_fin()
);
mm #(.size(16)) user_mm(
    .clk(clk),
    .rst(rst),
    .in_sta(io_in[31:16] == 16'hAB40),
    .in_val(user_bram.ack && (stt_fifo[rnff-1] == mmr)),
    .in_dat(user_bram.dat_o),
    .in_ouval((cst == mmr) || (cst == mmw)),
    .ou_val(),
    .ou_adr(),
    .ou_dat(),
    .ou_wrt(),
    .ou_fin()
);
qs #(.size(16)) user_qs(
    .clk(clk),
    .rst(rst),
    .in_sta(io_in[31:16] == 16'hAB40),
    .in_val(user_bram.ack && (stt_fifo[rnff-1] == qsr)),
    .in_dat(user_bram.dat_o),
    .in_ouval((cst == qsr) || (cst == qsw)),
    .ou_val(),
    .ou_adr(),
    .ou_dat(),
    .ou_wrt(),
    .ou_fin()
);

endmodule

`default_nettype wire
