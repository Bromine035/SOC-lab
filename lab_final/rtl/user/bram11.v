module bram11 #(
    parameter ADDR_WIDTH = 12,
    parameter SIZE = 11,
    parameter BIT_WIDTH = 32
)(clk, we, re, waddr, raddr, wdi, rdo);
    
    input                          clk;
    input                          we, re;
    input [ADDR_WIDTH-1:0]         waddr, raddr;
    input [BIT_WIDTH-1:0]          wdi;
    output reg [BIT_WIDTH-1:0]     rdo;
    (* ram_style = "block" *) reg [BIT_WIDTH-1:0] RAM [SIZE-1:0];
    
    always @(posedge clk)begin
        if(re) rdo <= RAM[raddr];
    end
    
    always @(posedge clk)begin
        if(we) RAM[waddr] <= wdi;
    end
    
endmodule
