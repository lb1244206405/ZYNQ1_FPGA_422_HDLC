module RS422_top (
                  clk,
				  rstn,
				  stream_tvalid,
				  stream_tready,
				  stream_tlast,
				  stream_tdata,
				  s00_axi_awaddr,
				  s00_axi_awprot,
				  s00_axi_awvalid,
				  s00_axi_awready,
				  s00_axi_wdata,
				  s00_axi_wstrb,
				  s00_axi_wvalid,
				  s00_axi_wready,
				  s00_axi_bresp,
				  s00_axi_bvalid,
				  s00_axi_bready,
				  s00_axi_araddr,
				  s00_axi_arprot,
				  s00_axi_arvalid,
				  s00_axi_arready,
				  s00_axi_rdata,
				  s00_axi_rresp,
				  s00_axi_rvalid,
				  s00_axi_rready,
				  rs422_tx_clk,
				  rs422_tx_data,
				  rs422_rx_clk,
				  rs422_rx_data
				  );

input         clk;
input         rstn;
output        stream_tvalid;
input         stream_tready;
output        stream_tlast;
output  [7:0] stream_tdata;
input   [3:0] s00_axi_awaddr;
input   [2:0] s00_axi_awprot;
input         s00_axi_awvalid;
output        s00_axi_awready;
input  [31:0] s00_axi_wdata;
input   [3:0] s00_axi_wstrb;
input         s00_axi_wvalid;
output        s00_axi_wready;
output  [1:0] s00_axi_bresp;
output        s00_axi_bvalid;
input         s00_axi_bready;
input   [3:0] s00_axi_araddr;
input   [2:0] s00_axi_arprot;
input         s00_axi_arvalid;
output        s00_axi_arready;
output [31:0] s00_axi_rdata;
output  [1:0] s00_axi_rresp;
output        s00_axi_rvalid;
input         s00_axi_rready;
output        rs422_tx_clk;
output        rs422_tx_data;
input         rs422_rx_clk;
input         rs422_rx_data;

parameter integer C_S00_AXI_DATA_WIDTH	= 32;
parameter integer C_S00_AXI_ADDR_WIDTH	= 4;

wire HDLC_start;
wire selfcheck_start;
wire [31:0] command_word;

myip_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) myip_v1_0_S00_AXI_inst (
		.S_AXI_ACLK(clk),
		.S_AXI_ARESETN(rstn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready),
		.HDLC_start(HDLC_start),
		.selfcheck_start(selfcheck_start),
		.command_word(command_word)
	);

reg selfcheck_en;
wire selfcheck_finish;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    selfcheck_en <= 1'b0;
	 else if (selfcheck_start == 1'b1)
	    selfcheck_en <= 1'b1;
	 else if (selfcheck_finish == 1'b1)
	    selfcheck_en <= 1'b0;
end

wire selfcheck_tx_clk;
wire selfcheck_tx_data;
wire selfcheck_rx_clk;
wire selfcheck_rx_data;
wire selfcheck_tvalid;
wire selfcheck_tlast;
wire [7:0] selfcheck_tdata;

check422_tx check422_tx (
                         .clk(clk),
						 .rstn(selfcheck_en),
						 .clk_out(selfcheck_tx_clk),
						 .data_out(selfcheck_tx_data)
						);

check422_rx check422_rx (
                         .clk(clk),
						 .rstn(selfcheck_en),
						 .clk_in(selfcheck_rx_clk),
						 .data_in(selfcheck_rx_data),
						 .tvalid(selfcheck_tvalid),
						 .tlast(selfcheck_tlast),
						 .tdata(selfcheck_tdata),
						 .finish(selfcheck_finish)
						);

reg HDLC_en1,HDLC_en2;
wire HDLC_finish1,HDLC_finish2;

reg HDLC_start_dly;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
       HDLC_start_dly <= 1'b0;
     else
       HDLC_start_dly <= HDLC_start;
end

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    HDLC_en1 <= 1'b0;
	 else if (selfcheck_en == 1'b1)
	    HDLC_en1 <= 1'b0;
	 else if (HDLC_start == 1'b1)
	    HDLC_en1 <= 1'b0;
	 else if (HDLC_start_dly == 1'b1)
	    HDLC_en1 <= 1'b1;
	 else if (HDLC_finish1 == 1'b1)
	    HDLC_en1 <= 1'b0;
end

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    HDLC_en2 <= 1'b0;
	 else if (selfcheck_en == 1'b1)
	    HDLC_en2 <= 1'b0;
	 else if (HDLC_start == 1'b1)
	    HDLC_en2 <= 1'b0;
	 else if (HDLC_start_dly == 1'b1)
	    HDLC_en2 <= 1'b1;
	 else if (HDLC_finish2 == 1'b1)
	    HDLC_en2 <= 1'b0;
end

reg [31:0] command_data;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    command_data <= 32'd0;
	 else if (HDLC_start == 1'b1 && HDLC_en1 == 1'b0)
	    command_data <= command_word;
end

reg [1:0] clk_cnt;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    clk_cnt <= 2'd0;
	 else
	    clk_cnt <= clk_cnt + 1'b1;
end

reg clk_10M;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    clk_10M <= 3'd0;
	 else if (clk_cnt >= 2'd2)
	    clk_10M <= 1'b1;
	 else
	    clk_10M <= 1'b0;
end

wire hdlc_tx_clk;
wire hdlc_tx_data;
wire hdlc_rx_clk;
wire hdlc_rx_data;
wire hdlc_tvalid;
wire hdlc_tlast;
wire [7:0] hdlc_tdata;

assign hdlc_tx_clk = clk_10M;

HDLC_command_tx HDLC_command_tx (
                                 .clk(clk),
								 .rstn(HDLC_en1),
								 .clk_cnt(clk_cnt),
								 .command_data(command_data),
								 .data_out(hdlc_tx_data),
								 .finish(HDLC_finish1)
								 );

hdlc_rx hdlc_rx (
                 .clk(clk),
				 .rstn(HDLC_en2),
				 .clk_in(hdlc_rx_clk),
				 .data_in(hdlc_rx_data),
				 .tvalid(hdlc_tvalid),
				 .tlast(hdlc_tlast),
				 .tdata(hdlc_tdata),
				 .finish(HDLC_finish2)
				 );

wire stream_tvalid;
wire stream_tlast;
wire [7:0] stream_tdata;
wire rs422_tx_clk;
wire rs422_tx_data;
wire rs422_rx_clk;
wire rs422_rx_data;

assign stream_tvalid = (selfcheck_en == 1'b1)? selfcheck_tvalid : hdlc_tvalid;
assign stream_tlast  = (selfcheck_en == 1'b1)? selfcheck_tlast  : hdlc_tlast;
assign stream_tdata  = (selfcheck_en == 1'b1)? selfcheck_tdata  : hdlc_tdata;

assign rs422_tx_clk  = (selfcheck_en == 1'b1)? 1'b0  : hdlc_tx_clk;
assign rs422_tx_data = (selfcheck_en == 1'b1)? 1'b0  : hdlc_tx_data;

assign selfcheck_rx_clk  = (selfcheck_en == 1'b1)? selfcheck_tx_clk  : 1'b0;
assign selfcheck_rx_data = (selfcheck_en == 1'b1)? selfcheck_tx_data : 1'b0;

assign hdlc_rx_clk  = (HDLC_en2 == 1'b1)? rs422_tx_clk  : 1'b0;
assign hdlc_rx_data = (HDLC_en2 == 1'b1)? rs422_rx_data : 1'b0;


endmodule