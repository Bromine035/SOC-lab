
`default_nettype wire

module qs #(
    parameter size = 10
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
parameter pivo = 3'd3;
parameter calc = 3'd4;
parameter dtou = 3'd5;
parameter dead = 3'd7;

parameter adra = 32'h3800_0180;
parameter adro = 32'h3800_01c0;
parameter p0 = 4;
integer i0;
// `define P0 4
`define P1 16

reg [2:0] cst, nst;
reg [p0-1:0] r0, rr0;
reg r1;
reg signed [31:0] rp; // pivot
reg [size-1:0] rc; // check table
reg [p0-1:0] rs [size-1:0]; // index sequence
wire signed [31:0] wrdo; // RAM data output
wire [p0-1:0] wr0s1; // r0 - 1;

assign ou_val = ((cst == dtin) && !r1)||((cst == dtou) && r1);
assign ou_adr = (cst == dtin)?(adra + {26'b0, r0, 2'b0}):(adro + {26'b0, r0, 2'b0});
assign ou_dat = wrdo;
assign ou_wrt = ((cst == dtou) && r1);
assign ou_fin = (cst == dead) && (rr0 == 11);
assign wr0s1 = r0 - 1;

fzo16 fzo0(.rc(rc), .n0());
fzo16 fzo1(.rc(rc | (`P1'd1 << rr0)), .n0());
bram11 #(.SIZE(size)) aram(.clk(clk), .we((cst == dtin) && in_val), .re(1'b1), .waddr({8'b0, rr0}), .raddr({8'b0, rs[r0]}), .wdi(in_dat), .rdo(wrdo));

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
        nst <= ((rr0 == (size - 1)) && in_val)?(stal):(dtin);

        stal:
        nst <= pivo;

        pivo:
        nst <= (rc == `P1'hffff_ffff)?(dtou):(calc);

        calc:
        nst <= (wr0s1 == fzo0.n0)?(stal):(calc);

        dtou:
        nst <= ((r0 == (size - 1)) && in_ouval)?(dead):(dtou);

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
        rr0 <= 0;
        r1 <= 0;
        rp <= 0;
        for(i0 = 0; i0 < size; i0 = i0 + 1) begin
            rc[i0] <= 0;
            rs[i0] <= i0;
        end
    end
    else if(cst == dtin) begin
        r0 <=  ((rr0 == (size - 1)) && in_val)?(size - 1):((in_ouval)?(r0 + 1):(r0));
        r1 <= ((r0 == (size - 1)) && in_ouval)?(1):(r1);
        rr0 <= (in_val)?((rr0 == (size - 1))?(0):(rr0 + 1)):(rr0);
    end
    else if(cst == stal) begin
        r0 <= 0;
        rr0 <= 0;
    end
    else if(cst == pivo) begin
        r0 <= (nst == dtou)?(r0):(r0 + 1);
        rp <= wrdo;
    end
    else if(cst == calc) begin
        if(wr0s1 == fzo0.n0) begin // arrive pivot
            if(wr0s1 != rr0) begin
                rs[wr0s1] <= rs[rr0];
                rs[rr0] <= rs[wr0s1];
            end
            rc[rr0] <= 1;
            r0 <= fzo1.n0; // new pivot
        end
        else if(rc[wr0s1]) begin // solid
            r0 <= r0 + 1;
            rr0 <= rr0 + 1;
        end
        else begin
            if(wrdo < rp) begin
                if(wr0s1 != rr0) begin
                    rs[wr0s1] <= rs[rr0];
                    rs[rr0] <= rs[wr0s1];
                end
                rr0 <= rr0 + 1;
            end
            r0 <= r0 + 1;
        end
    end
    else if(cst == dtou) begin
        if(!r1) begin
            r1 <= 1'b1;
        end
        else if(in_ouval) begin
            r1 <= 1'b0;
            r0 <= r0 + 1;
            rr0 <= (nst == dead)?(0):(rr0 + 1);
        end
        else begin
            r1 <= r1;
        end
    end
    else if(cst == dead) begin
        rr0 <= (rr0 == 11)?(rr0):(rr0 + 1);
    end
    else begin
        r0 <= 0;
    end
end

endmodule

module fzo10(rc, n0);
input wire [9:0] rc;
output reg [3:0] n0;

always @(*) begin
    if((!rc[0]) && rc[1]) n0 <= 4'b0;
    else if((!rc[1]) && rc[2]) n0 <= 4'd1;
    else if((!rc[2]) && rc[3]) n0 <= 4'd2;
    else if((!rc[3]) && rc[4]) n0 <= 4'd3;
    else if((!rc[4]) && rc[5]) n0 <= 4'd4;
    else if((!rc[5]) && rc[6]) n0 <= 4'd5;
    else if((!rc[6]) && rc[7]) n0 <= 4'd6;
    else if((!rc[7]) && rc[8]) n0 <= 4'd7;
    else if((!rc[8]) && rc[9]) n0 <= 4'd8;
    else if(!rc[9]) n0 <= 4'd9;
    else n0 <= 4'd15;
end
endmodule

module fzo16(rc, n0);
input wire [15:0] rc;
output reg [3:0] n0;

always @(*) begin
    if((!rc[0]) && rc[1]) n0 <= 4'b0;
    else if((!rc[1]) && rc[2]) n0 <= 4'd1;
    else if((!rc[2]) && rc[3]) n0 <= 4'd2;
    else if((!rc[3]) && rc[4]) n0 <= 4'd3;
    else if((!rc[4]) && rc[5]) n0 <= 4'd4;
    else if((!rc[5]) && rc[6]) n0 <= 4'd5;
    else if((!rc[6]) && rc[7]) n0 <= 4'd6;
    else if((!rc[7]) && rc[8]) n0 <= 4'd7;
    else if((!rc[8]) && rc[9]) n0 <= 4'd8;
    else if((!rc[9]) && rc[10]) n0 <= 4'd9;
    else if((!rc[10]) && rc[11]) n0 <= 4'd10;
    else if((!rc[11]) && rc[12]) n0 <= 4'd11;
    else if((!rc[12]) && rc[13]) n0 <= 4'd12;
    else if((!rc[13]) && rc[14]) n0 <= 4'd13;
    else if((!rc[14]) && rc[15]) n0 <= 4'd14;
    else if(!rc[15]) n0 <= 4'd15;
    else n0 <= 4'd15;
end
endmodule
