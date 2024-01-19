module bram_wb #(
    parameter DELAYS=10
)(
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
    output [31:0] wbs_dat_o
);
    wire clk;
    wire rst;
    reg [3:0] cnt;

    assign clk = wb_clk_i;
    assign rst = wb_rst_i;
    assign wbs_ack_o = (cnt == DELAYS+1);
    
    always @(posedge clk) begin
        if (rst) begin
            cnt <= 'd0;
        end
        else begin
            if (wbs_ack_o)
                cnt <= 'd0;
            else if (wbs_stb_i & wbs_cyc_i)
                cnt <= cnt + 1'b1;
        end
    end

    bram user_bram (
        .CLK(clk),
        .WE0(wbs_sel_i & {4{wbs_we_i}}),
        .EN0((cnt==DELAYS) & wbs_stb_i & wbs_cyc_i),
        .Di0(wbs_dat_i),
        .Do0(wbs_dat_o),
        .A0(wbs_adr_i >> 2)
    );

endmodule