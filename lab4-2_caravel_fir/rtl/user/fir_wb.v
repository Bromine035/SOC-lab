module fir_wb (
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
    output reg [31:0] wbs_dat_o
);
    //=====================================================================
    //   REG AND WIRE DECLARATION
    //=====================================================================
    wire clk;
    wire rst;
    //---------- AXI-lite slave Interface ----------
    // Address write channel
    wire awready;
    wire awvalid;
    // Write channel
    wire wready;
    wire wvalid;
    // Address read channel
    wire arready;
    wire arvalid;
    // Read channel
    wire rvalid;
    wire [31:0] rdata;
    wire rready;
    //---------- AXI-stream Interface ----------
    // Slave
    wire ss_tvalid;
    wire ss_tready;
    // Master
    wire sm_tready;
    wire sm_tvalid;
    wire [31:0] sm_tdata;
    wire sm_tlast;

    wire valid, sel;
    wire axi_w, axi_r, stream_w, stream_r;
    reg awhs, whs, arhs, rhs;

    //=====================================================================
    //   DATA PATH & CONTROL
    //=====================================================================
    assign clk = wb_clk_i;
    assign rst = wb_rst_i;

    assign valid = wbs_stb_i & wbs_cyc_i;
    assign sel = wbs_adr_i[7];  // 0->axi-lite, 1->axi-stream
    assign axi_w = ~sel & wbs_we_i;
    assign axi_r = ~sel & ~wbs_we_i;
    assign stream_w = sel & wbs_we_i;
    assign stream_r = sel & ~wbs_we_i;
    
    //========== AXI-lite =========
    // Address write channel
    always @(posedge clk) begin
        if (rst) begin
            awhs <= 1'b0;
        end
        else begin
            if (awvalid & awready & wvalid & wready)    // simutinous handshake
                awhs <= 1'b0;
            else if (awvalid & awready & whs)           // write channel handshake first
                awhs <= 1'b0;
            else if (wvalid & wready & awhs)            // address write channel handshake first
                awhs <= 1'b0;
            else if (awvalid & awready & ~whs)
                awhs <= 1'b1;
        end
    end
    assign awvalid = valid & axi_w & ~awhs;
    // Write channel
    always @(posedge clk) begin
        if (rst) begin
            whs <= 1'b0;
        end
        else begin
            if (awvalid & awready & wvalid & wready)    // simutinous handshake
                whs <= 1'b0;
            else if (awvalid & awready & whs)           // write channel handshake first
                whs <= 1'b0;
            else if (wvalid & wready & awhs)            // address write channel handshake first
                whs <= 1'b0;
            else if (wvalid & wready & ~awhs)
                whs <= 1'b1;
        end
    end
    assign wvalid = valid & axi_w & ~whs;
    // Address read channel
    always @(posedge clk) begin
        if (rst) begin
            arhs <= 1'b0;
        end
        else begin
            if (rvalid & rready)                // read channel handshake
                arhs <= 1'b0;
            else if (arvalid & arready)         // address read channel handshake 
                arhs <= 1'b1;
        end
    end
    assign arvalid = valid & axi_r & ~arhs;
    // Read channel
    assign rready = valid & axi_r;

    //========== AXI-stream ==========
    // Write streamn
    assign ss_tvalid = valid & stream_w;
    // Read stream
    assign sm_tready = valid & stream_r;

    //========== Wishbone Output ==========
    // Ack
    always @(*) begin
        case ({stream_r, stream_w, axi_r, axi_w})
            'b0001: wbs_ack_o = wvalid & wready;
            'b0010: wbs_ack_o = rvalid;
            'b0100: wbs_ack_o = ss_tready;
            'b1000: wbs_ack_o = sm_tvalid;
            default: wbs_ack_o = 1'b0;
        endcase
    end
    // Data
    always @(*) begin
        case ({stream_r, axi_r})
            'b01: wbs_dat_o = rdata;
            'b10: wbs_dat_o = sm_tdata;
            default: wbs_dat_o = 32'b0;
        endcase
    end

    //========== FIR instance ==========
    fir user_fir (
        //---------- AXI-lite slave Interface ----------
        // Address write channel
        .awready    (awready),
        .awvalid    (awvalid),
        .awaddr     (wbs_adr_i[11:0]),
        // Write channel
        .wready     (wready),
        .wvalid     (wvalid),
        .wdata      (wbs_dat_i),
        // Address read channel
        .arready    (arready),
        .arvalid    (arvalid),
        .araddr     (wbs_adr_i[11:0]),
        // Read channel
        .rvalid     (rvalid),
        .rdata      (rdata),
        .rready     (rready),
        //---------- AXI-stream Interface ----------
        // Slave
        .ss_tvalid  (ss_tvalid),
        .ss_tdata   (wbs_dat_i),
        .ss_tlast   (1'b0),
        .ss_tready  (ss_tready),
        // Master
        .sm_tready  (sm_tready),
        .sm_tvalid  (sm_tvalid),
        .sm_tdata   (sm_tdata),
        .sm_tlast   (sm_tlast),

        .axis_clk   (clk),
        .axis_rst_n (~rst)
    );

endmodule