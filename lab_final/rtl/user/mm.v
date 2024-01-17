
`default_nettype wire

module mm #(
    parameter size = 16
)(
    clk,
    rst,
    in_sta,
    in_val,
    in_dat,
    in_ouval,
    ou_val,
    ou_adr,
    ou_dat,
    ou_wrt,
    ou_fin
);

input clk;
input rst;
input in_sta;
input in_val;
input [31:0] in_dat;
input in_ouval;
output wire ou_val;
output wire [31:0] ou_adr;
output wire [31:0] ou_dat;
output wire ou_wrt;
output wire ou_fin;

parameter idle = 3'd0;
parameter dtin = 3'd1;
parameter stal = 3'd2;
parameter calc = 3'd3;
parameter dtou = 3'd4;
parameter dead = 3'd7;

parameter adra = 32'h3800_00c0; // A
parameter adrb = 32'h3800_0100; // B
parameter adro = 32'h3800_0140; // out

reg [2:0] cst, nst;
reg [3:0] r0, rr0; // r0: index, rr0: 4 steps of mult
reg [1:0] r1, rr1;
reg [31:0] rd; // data

assign ou_val = ((cst == dtin) && (r1 != 2))||(cst == dtou);
assign ou_adr = (cst == dtin)?(((r1 == 1)?(adrb):(adra)) + {26'b0, r0, 2'b0}):(adro + {26'b0, (r0 - 4'd1), 2'b0});
assign ou_dat = rd;
assign ou_wrt = (cst == dtou);
assign ou_fin = (cst == dead) && (r0 == 11);

bram11 #(.SIZE(size)) rama(.clk(clk), .we((cst == dtin) && in_val && (rr1 == 0)), .re(1'b1), .waddr({8'b0, rr0}), .raddr({8'b0, {r0[3:2], rr0[1:0]}}), .wdi(in_dat), .rdo());
bram11 #(.SIZE(size)) ramb(.clk(clk), .we((cst == dtin) && in_val && (rr1 == 1)), .re(1'b1), .waddr({8'b0, rr0}), .raddr({8'b0, {rr0[1:0], r0[1:0]}}), .wdi(in_dat), .rdo());

always @(posedge clk or posedge rst) begin
    if(rst) begin
        cst <= idle;
    end
    else begin
        cst <= nst;
    end
end

always @(*) begin
    if(rst) begin
        nst <= idle;
    end
    else begin
        case(cst)
        idle:
        nst <= (in_sta)?(dtin):(idle);

        dtin:
        nst <= (rr1 == 2)?(stal):(dtin);

        stal:
        nst <= calc;

        calc:
        nst <= (rr0 == 4)?(dtou):(calc);

        dtou:
        nst <= (in_ouval)?((rr0 == 5)?(dead):(calc)):(dtou);

        dead:
        nst <= (!in_sta)?(idle):(dead);

        default:
        nst <= idle;
        endcase
    end
end

always @(posedge clk or posedge rst) begin
    if(rst) begin
        r0 <= 0;
        r1 <= 0;
        rr0 <= 0;
        rr1 <= 0;
        rd <= 0;
    end
    else if(cst == dtin) begin
        r0 <= (rr1 == 2)?(0):((in_ouval)?((r0 == (size - 1))?(0):(r0 + 1)):(r0));
        r1 <= (rr1 == 2)?(0):(((r0 == (size - 1)) && in_ouval)?(r1 + 1):(r1));
        rr0 <= (rr1 == 2)?(0):((in_val)?((rr0 == (size - 1))?(0):(rr0 + 1)):(rr0));
        rr1 <= ((rr0 == (size - 1)) && in_val)?(rr1 + 1):(rr1);
    end
    else if(cst == stal) begin
        rr0 <= rr0 + 1;
        rd <= 0;
    end
    else if(cst == calc) begin
        r0 <= (rr0 == 4)?(r0 + 1):(r0);
        rr0 <= (rr0 == 4 && r0 != 15)?(0):(rr0 + 1);
        rd = rd + (rama.rdo * ramb.rdo);
    end
    else if(cst == dtou) begin
        r0 <= (in_ouval)?((rr0 == 5)?(0):(r0)):(r0);
        rr0 <= (in_ouval)?(rr0 + 1):(rr0);
        rd <= (in_ouval)?(0):(rd);
    end
    else if(cst == dead) begin
        r0 <= (r0 == 11)?(r0):(r0 + 1);
    end
    else begin
        r0 <= 0;
    end
end

endmodule