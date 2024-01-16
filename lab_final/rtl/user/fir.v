
`default_nettype wire

module fir #(
    parameter size_t = 11,
    parameter size_x = 16
)(
    clk,
    rst,
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
input in_val;
input [31:0] in_dat;
input in_ouval;
output wire ou_val;
output wire [31:0] ou_adr;
output wire [31:0] ou_dat;
output wire ou_wrt;
output wire ou_fin;

parameter init = 3'd0;
parameter dtin = 3'd1;
parameter stal = 3'd2;
parameter calc = 3'd3;
parameter dtou = 3'd4;
parameter dead = 3'd7;

parameter adrt = 32'h3800_0000;
parameter adrx = 32'h3800_0040;
parameter adry = 32'h3800_0080;
parameter p0 = 4;
parameter p1 = 8;
`define P0 4 // bram address length - p1 = 12 - 8 = 4

reg [2:0] cst, nst;
reg [p1-1:0] r0, rr0;
reg [1:0] r1, rr1;
reg [p0-1:0] rtt; // turn of tap
reg [p1-1:0] rtx; // turn of x
reg [31:0] rd; // data

assign ou_val = ((cst == dtin) && (r1 != 2))||(cst == dtou);
assign ou_adr = (cst == dtin)?(((r1 == 1)?(adrx):(adrt)) + {26'b0, r0, 2'b0}):(adry + {26'b0, (rtx - 4'd1), 2'b0});
assign ou_dat = rd;
assign ou_wrt = (cst == dtou);
assign ou_fin = (cst == dead) && (r0 == 11);

bram11 #(.SIZE(size_t)) tram(.clk(clk), .we((cst == dtin) && in_val && (rr1 == 0)), .re(1'b1), .waddr({`P0'b0, rr0}), .raddr({`P0'b0, r0}), .wdi(in_dat), .rdo());
bram11 #(.SIZE(size_x)) dram(.clk(clk), .we((cst == dtin) && in_val && (rr1 == 1)), .re(1'b1), .waddr({`P0'b0, rr0}), .raddr({`P0'b0, rr0}), .wdi(in_dat), .rdo());

always @(posedge clk or posedge rst) begin
    if(rst) begin
        cst <= init;
    end
    else begin
        cst <= nst;
    end
end

always @(*) begin
    if(rst) begin
        nst <= init;
    end
    else begin
        case(cst)
        init:
        nst <= dtin;

        dtin:
        nst <= (rr1 == 2)?(stal):(dtin);

        stal:
        nst <= calc;

        calc:
        nst <= (r0 == (rtt + 1))?(dtou):(calc);

        dtou:
        nst <= (in_ouval)?((rtx == size_x[p1-1:0])?(dead):(calc)):(dtou);

        dead:
        nst <= dead;

        default:
        nst <= init;
        endcase
    end
end

always @(posedge clk or posedge rst) begin
    if(rst) begin
        r0 <= 0;
        r1 <= 0;
        rr0 <= 0;
        rr1 <= 0;
        rtt <= 0;
        rtx <= 0;
        rd <= 0;
    end
    else if(cst == dtin) begin
        if(r1 == 0) begin
            r0 <= (in_ouval)?((r0 == (size_t - 1))?(0):(r0 + 1)):(r0);
            r1 <= ((r0 == (size_t - 1)) && in_ouval)?(r1 + 1):(r1);
        end
        else if(r1 == 1) begin
            r0 <= (in_ouval)?((r0 == (size_x - 1))?(0):(r0 + 1)):(r0);
            r1 <= ((r0 == (size_x - 1)) && in_ouval)?(r1 + 1):(r1);
        end
        else begin
            r0 <= (rr1 == 2)?(0):(r0);
            r1 <= (rr1 == 2)?(0):(r1);
        end

        if(rr1 == 0) begin
            rr0 <= (in_val)?((rr0 == (size_t - 1))?(0):(rr0 + 1)):(rr0);
            rr1 <= ((rr0 == (size_t - 1)) && in_val)?(rr1 + 1):(rr1);
        end
        else if(rr1 == 1) begin
            rr0 <= (in_val)?((rr0 == (size_x - 1))?(0):(rr0 + 1)):(rr0);
            rr1 <= ((rr0 == (size_x - 1)) && in_val)?(rr1 + 1):(rr1);
        end
        else begin
            rr0 <= (rr1 == 2)?(0):(rr0);
        end
    end
    else if(cst == stal) begin
        r0 <= r0 + 1;
        rr0 <= rr0 - 1;
        rtt <= 0;
        rtx <= 0;
        rd <= 0;
    end
    else if(cst == calc) begin
        r0 <= (r0 == (rtt + 1))?(0):(r0 + 1);
        rr0 <= (r0 == (rtt + 1))?(rtx + 1):(rr0 - 1);
        rtt <= ((r0 == (rtt + 1)) && (rtt != (size_t - 1)))?(rtt + 1):(rtt);
        rtx <= (r0 == (rtt + 1))?(rtx + 1):(rtx);
        rd <= rd + (tram.rdo * dram.rdo);
    end
    else if(cst == dtou) begin
        r0 <= (in_ouval)?((rtx == size_x[p1-1:0])?(0):(r0 + 1)):(r0);
        rr0 <= (in_ouval)?(rr0 - 1):(rr0);
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