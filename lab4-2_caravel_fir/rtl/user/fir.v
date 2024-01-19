`timescale 1ns / 1ps // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

module fir 
#(  parameter pADDR_WIDTH = 12,
    parameter pDATA_WIDTH = 32,
    parameter Tape_Num    = 11
)
(
    output  wire                     awready,
    output  wire                     wready,
    input   wire                     awvalid,
    input   wire [(pADDR_WIDTH-1):0] awaddr,
    input   wire                     wvalid,
    input   wire [(pDATA_WIDTH-1):0] wdata,
    output  wire                     arready,
    input   wire                     rready,
    input   wire                     arvalid,
    input   wire [(pADDR_WIDTH-1):0] araddr,
    output  wire                     rvalid,
    output  wire [(pDATA_WIDTH-1):0] rdata,    
    input   wire                     ss_tvalid, 
    input   wire [(pDATA_WIDTH-1):0] ss_tdata, 
    input   wire                     ss_tlast, 
    output  wire                     ss_tready, 
    input   wire                     sm_tready, 
    output  wire                     sm_tvalid, 
    output  wire [(pDATA_WIDTH-1):0] sm_tdata, 
    output  wire                     sm_tlast, 
    
    

    input   wire                     axis_clk,
    input   wire                     axis_rst_n
);
    // write your code here!

parameter tidl = 4'd0; // tap RAM block idle
parameter radr = 4'd1; // read address
parameter rapr = 4'd2; // read AP register
parameter rdlr = 4'd3; // read data length register
parameter rtrd = 4'd4; // read tap RAM data
parameter wadr = 4'd5; // write
parameter wapr = 4'd6;
parameter wdlr = 4'd7;
parameter wtrd = 4'd8;

parameter didl = 2'd0; // data RAM black idle
parameter dtin = 2'd1; // data in (Xn)
parameter calc = 2'd2; // calculation

// bram for tap RAM
wire [3:0]               tap_WE;
wire                     tap_EN;
wire [(pDATA_WIDTH-1):0] tap_Di;
wire [(pADDR_WIDTH-1):0] tap_A;
wire [(pDATA_WIDTH-1):0] tap_Do;

// bram for data RAM
wire [3:0]               data_WE;
wire                     data_EN;
wire [(pDATA_WIDTH-1):0] data_Di;
wire [(pADDR_WIDTH-1):0] data_A;
wire [(pDATA_WIDTH-1):0] data_Do;

wire clk, rst_n;
wire [(pADDR_WIDTH-1):0] w000, w010, w040;
reg [3:0] tcst; // axi-lite to tap ram bloack
reg [1:0] dcst; // axi-stream to data ram block
reg [2:0] rap;
reg [(pDATA_WIDTH-1):0] rdl, rdl2;
reg [3:0] r0, r1, r2;
reg rawredy, rwredy, rarredy, rrval, rtredy, rtval, rtlas;
reg [(pDATA_WIDTH-1):0] rtdi, rddi, rtdata;
reg [(pADDR_WIDTH-1):0] rta, rda;
reg [3:0] rtwe, rdwe;

assign clk = axis_clk;
assign rst_n = axis_rst_n;
assign w000 = 32'h0000_0000;
assign w010 = 32'h0000_0010;
assign w040 = 32'h0000_0040;
assign awready = rawredy;
assign wready = rwredy;
assign arready = rarredy;
assign rvalid = rrval;
assign rdata = (tcst == rapr)?({29'b110, rap}):((tcst == rdlr)?(rdl):(tap_Do));
assign ss_tready = rtredy;
assign sm_tvalid = rtval;
assign sm_tdata = rtdata;
assign sm_tlast = rtlas;
assign data_WE = rdwe;
assign data_EN = 1'b1;
assign data_Di = rddi;
assign data_A = rda;
assign tap_WE = rtwe;
assign tap_EN = 1'b1;
assign tap_Di = rtdi;
assign tap_A = rta;

bram11 tram(.clk(clk), .we(tap_WE), .re(tap_EN), .waddr(tap_A), .raddr(tap_A), .wdi(tap_Di), .rdo(tap_Do));
bram11 dram(.clk(clk), .we(data_WE), .re(data_EN), .waddr(data_A), .raddr(data_A), .wdi(data_Di), .rdo(data_Do));

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        tcst <= tidl;
        rawredy <= 1'b0;
        rwredy <= 1'b0;
        rta <= 0;
        rtdi <= 0;
        rtwe <= 4'b0;
        rarredy <= 0;
        rrval <= 1'b0;
        rap <= 3'b100;
        rdl <= 0;
    end
    else if(tcst == tidl) begin
        rap <= (rap[0])?(3'b000):((rtlas)?(3'b110):(rap));
        
        if(arvalid) begin
            rarredy <= (araddr == w000 || araddr == w010 || dcst == didl)?(1'b1):(rarredy);
            tcst <= (araddr == w000 || araddr == w010 || dcst == didl)?(radr):(tcst);
        end
        else if(awvalid) begin
            rawredy <= (awaddr == w000 || awaddr == w010 || dcst == didl)?(1'b1):(rawredy);
            tcst <= (awaddr == w000 || awaddr == w010 || dcst == didl)?(wadr):(tcst);
        end
        else begin
            tcst <= tcst;
        end
        rta <= r0;
        rtwe <= 4'b0;
    end
    else if(tcst == radr) begin
        rarredy <= 1'b0;
        rrval <= 1'b0;
        rta <= (dcst != didl)?(r0):((araddr - w040)>>2);
        rtwe <= 4'b0;
        tcst <= (araddr == w000)?(rapr):((araddr == w010)?(rdlr):(rtrd));
    end
    else if((tcst == rapr) || (tcst == rdlr) || (tcst == rtrd)) begin
        rrval <= (rrval)?(1'b0):((rready)?(1'b1):(rrval));
        rta <= r0;
        rtwe <= 4'b0;
        tcst <= (rrval)?(tidl):(tcst);
    end
    else if(tcst == wadr) begin
        rawredy <= 1'b0;
        rwredy <= 1'b1;
        rta <= (dcst != didl)?(r0):((awaddr - w040)>>2);
        rtwe <= 4'b0;
        tcst <= (awaddr == w000)?(wapr):((awaddr == w010)?(wdlr):(wtrd));
    end
    else if(tcst == wapr) begin
        rwredy <= (wvalid)?(1'b0):(rwredy);
        rap <= (wvalid)?((wdata[0])?(3'b001):({rap[2:1], wdata[0]})):(rap);
        rta <= r0;
        rtwe <= 4'b0;
        tcst <= (wvalid)?(tidl):(tcst);
    end
    else if(tcst == wdlr) begin
        rwredy <= (wvalid)?(1'b0):(rwredy);
        rdl <= (wvalid)?(wdata):(rdl);
        rta <= r0;
        rtwe <= 4'b0;
        tcst <= (wvalid)?(tidl):(tcst);
    end
    else if(tcst == wtrd) begin
        rwredy <= (wvalid)?(1'b0):(rwredy);
        rtdi <= (wvalid)?(wdata):(rtdi);
        rta <= (dcst != didl)?(r0):(rta);
        rtwe <= (wvalid)?(4'b1111):(4'b0);
        tcst <= (wvalid)?(tidl):(tcst);
    end
    else begin
        tcst <= tidl;
        rawredy <= 1'b0;
        rwredy <= 1'b0;
        rta <= 0;
        rtdi <= 0;
        rtwe <= 4'b0;
        rarredy <= 0;
        rrval <= 1'b0;
        rap <= 3'b100;
        rdl <= 0;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        dcst <= didl;
        rda <= 0;
        rddi <= 0;
        rdwe <= 4'b0;
        // rsslas <= 1'b0;
        rtredy <= 1'b0;
        rtdata <= 0;
        rtval <= 1'b0;
        rtlas <= 1'b0;
        r0 <= 4'd0;
        r1 <= 4'd10;
        r2 <= 4'd11;
        rdl2 <= 0;
    end
    else if(dcst == didl) begin
        rda <= 0;
        rddi <= 0;
        rdwe <= 4'b0;
        // rsslas <= 1'b0;
        rtredy <= 1'b0;
        rtdata <= 0;
        rtval <= 1'b0;
        rtlas <= 1'b0;
        r0 <= 4'd0;
        r1 <= 4'd10;
        r2 <= 4'd11;
        rdl2 <= rdl;
        dcst <= (rap[0])?(dtin):(dcst);
    end
    else if(dcst == dtin) begin
        rtdata <= 0;
        if(!rtredy) begin
            // rsslas <= (ss_tvalid)?(ss_tlast):(rsslas);
            rtredy <= (ss_tvalid)?(1'b1):(rtredy);
            rdwe <= (ss_tvalid)?(4'b1111):(rdwe);
            rddi <= (ss_tvalid)?(ss_tdata):(rddi);
            rda <= (ss_tvalid)?({8'b0, (r1 == 4'd10)?(4'b0):(r1 + 4'd1)}):(rda);
            // r0 <= (ss_tvalid)?(r0 + 4'd1):(r0);
            r1 <= (ss_tvalid)?((r1 == 4'd10)?(4'b0):(r1 + 4'd1)):(r1);
        end
        else begin
            rtredy <= 1'b0;
            rdwe <= 4'b0;
            r2 <= (r2 != 4'd0)?(r2 - 1):(r2);
            dcst <= calc;
            r0 <= r0 + 4'd1;
            rdl2 -= 1;
            // rda <= ((r0 > r1)?(r1 - r0 + Tape_Num):(r1 - r0))<<2;
        end
    end
    else if(dcst == calc) begin
        if(r0 == 4'd13) begin
            r0 <= (sm_tready)?(4'd0):(r0);
            rda <= (sm_tready)?({8'b0, (r1 == 4'd10)?(4'b0):(r1 + 4'd1)}):(rda);
            rtdata <= (sm_tready)?(0):(rtdata);
            rtval <= (sm_tready)?(1'b0):(rtval);
            rtlas <= (sm_tready)?(1'b0):(rtlas);
            // rsslas <= (sm_tready)?(1'b0):(rsslas);
            dcst <= (sm_tready)?((rdl2 == 0)?(didl):(dtin)):(dcst);
        end
        else begin
            r0 <= r0 + 4'd1;
            rda <= {8'b0, ((r0 > r1)?(r1 - r0 + Tape_Num):(r1 - r0))};
            rtdata <= (({1'b0, r0} + {1'b0, r2}) > 5'd12 || r0 == 1)?(rtdata):(rtdata + tap_Do * data_Do);
            rtval <= (r0 == 4'd12)?(1'b1):(rtval);
            rtlas <= (r0 == 4'd12 && rdl2 == 0)?(1'b1):(rtlas);
        end
    end
    else begin
        dcst <= didl;
        rda <= 0;
        rddi <= 0;
        rdwe <= 4'b0;
        // rsslas <= 1'b0;
        rtredy <= 1'b0;
        rtdata <= 0;
        rtval <= 1'b0;
        rtlas <= 1'b0;
        r0 <= 4'd0;
        r1 <= 4'd10;
        r2 <= 4'd11;
        rdl2 <= 0;
    end
end

endmodule // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!