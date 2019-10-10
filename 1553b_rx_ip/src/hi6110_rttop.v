module hi6110_rttop (
                     clk,
					 reg_addr,
					 reg_data,
					 cs,
					 rw,
					 str,
					 mr,
					 bcmode,
					 rtmode,
					 txinha,
					 txinhb,
					 bcstart,
					 rt_addr,
					 rtap,
					 error,
					 valmess,
					 ffempty,
					 rflag,
					 rf0,
					 rf1,
					 rcva,
					 rcvb,
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
					 s00_axi_rready
					 );
input         clk;
output  [3:0] reg_addr;
inout  [15:0] reg_data;
output        cs;
output        rw;
output        str;
output        mr;
output        bcmode;
output        rtmode;
output        txinha;
output        txinhb;
output        bcstart;
output  [4:0] rt_addr;
output        rtap;
input         error;
input         valmess;
input         ffempty;
input         rflag;
input         rf0;
input         rf1;
input         rcva;
input         rcvb;
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

assign        bcmode = 1'b0;
assign        rtmode = 1'b1;
assign        txinha = 1'b0;
assign        txinhb = 1'b0;
assign        bcstart = 1'b0;
assign        rt_addr = 5'b10101;
assign        rtap = 1'b0;

reg [15:0] rst_cnt;
reg rstn;

always @(posedge clk)
begin
     if (rst_cnt < 16'hffff)
	    rst_cnt <= rst_cnt + 1'b1;
end

always @(posedge clk)
begin
     if (rst_cnt < 16'hffff)
	    rstn <= 1'b0;
	 else
	    rstn <= 1'b1;
end

reg mr;

always @(posedge clk)
begin
     if (rst_cnt < 16'h1000)
	    mr <= 1'b0;
	 else if (rst_cnt >= 16'h1000 && rst_cnt <= 16'h10ff)
	    mr <= 1'b1;
	 else
	    mr <= 1'b0;
end

reg [19:0] wait_cnt;
reg [2:0] ctrl_cnt;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    ctrl_cnt <= 3'd0;
	 else if (wait_cnt == 20'hfffff)
	    ctrl_cnt <= ctrl_cnt + 1'b1;
	 else if (ctrl_cnt == 3'd5)
	    ctrl_cnt <= 3'd5;
end

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    wait_cnt <= 16'd0;
	 else if (ctrl_cnt < 3'd5)
	    wait_cnt <= wait_cnt + 1'b1;
	 else
	    wait_cnt <= 16'd0;
end

reg wr_rdy;
reg rd_rdy;
reg tx_rdy;
reg rx_rdy;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    begin
		wr_rdy <= 1'b0;
		rd_rdy <= 1'b0;
		tx_rdy <= 1'b0;
		rx_rdy <= 1'b0;
		end
	 else
	    begin
		case (ctrl_cnt)
		3'd1:
		begin
		wr_rdy <= 1'b1;
		rd_rdy <= 1'b0;
		tx_rdy <= 1'b0;
		rx_rdy <= 1'b0;
		end
		3'd2:
		begin
		wr_rdy <= 1'b0;
		rd_rdy <= 1'b1;
		tx_rdy <= 1'b0;
		rx_rdy <= 1'b0;
		end
		3'd3:
		begin
		wr_rdy <= 1'b0;
		rd_rdy <= 1'b0;
		tx_rdy <= 1'b1;
		rx_rdy <= 1'b0;
		end
		3'd4:
		begin
		wr_rdy <= 1'b0;
		rd_rdy <= 1'b0;
		tx_rdy <= 1'b0;
		rx_rdy <= 1'b0;
		end
		default:
		begin
		wr_rdy <= 1'b0;
		rd_rdy <= 1'b0;
		tx_rdy <= 1'b0;
		rx_rdy <= 1'b0;
		end
		endcase
		end
end

reg  [3:0] reg_addr;
wire [3:0] wr_reg_addr;
wire [3:0] rd_reg_addr;
wire [3:0] tx_reg_addr;
wire [3:0] rx_reg_addr;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    reg_addr <= 4'd0;
	 else if (wr_rdy == 1'b1)
	    reg_addr <= wr_reg_addr;
	 else if (rd_rdy == 1'b1)
	    reg_addr <= rd_reg_addr;
	 else if (tx_rdy == 1'b1)
	    reg_addr <= tx_reg_addr;
	 else if (rx_rdy == 1'b1)
	    reg_addr <= rx_reg_addr;
	 else
	    reg_addr <= 4'd0;
end

reg cs;
wire wr_cs;
wire rd_cs;
wire tx_cs;
wire rx_cs;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    cs <= 1'b1;
	 else if (wr_rdy == 1'b1)
	    cs <= wr_cs;
	 else if (rd_rdy == 1'b1)
	    cs <= rd_cs;
	 else if (tx_rdy == 1'b1)
	    cs <= tx_cs;
	 else if (rx_rdy == 1'b1)
	    cs <= rx_cs;
	 else
	    cs <= 1'b1;
end

reg rw;
wire wr_rw;
wire rd_rw;
wire tx_rw;
wire rx_rw;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    rw <= 1'b1;
	 else if (wr_rdy == 1'b1)
	    rw <= wr_rw;
	 else if (rd_rdy == 1'b1)
	    rw <= rd_rw;
	 else if (tx_rdy == 1'b1)
	    rw <= tx_rw;
	 else if (rx_rdy == 1'b1)
	    rw <= rx_rw;
	 else
	    rw <= 1'b1;
end

reg str;
wire wr_str;
wire rd_str;
wire tx_str;
wire rx_str;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    str <= 1'b1;
	 else if (wr_rdy == 1'b1)
	    str <= wr_str;
	 else if (rd_rdy == 1'b1)
	    str <= rd_str;
	 else if (tx_rdy == 1'b1)
	    str <= tx_str;
	 else if (rx_rdy == 1'b1)
	    str <= rx_str;
	 else
	    str <= 1'b1;
end

parameter integer C_S00_AXI_DATA_WIDTH	= 32;
parameter integer C_S00_AXI_ADDR_WIDTH	= 4;


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
		.S_AXI_RREADY(s00_axi_rready)
	);

hi6110_rtwr hi6110_rtwr (
                         .clk(clk),
						 .rstn(wr_rdy),
						 .reg_addr(wr_reg_addr),
						 .reg_data(reg_data),
						 .cs(wr_cs),
						 .rw(wr_rw),
						 .str(wr_str)
						 );

hi6110_rtrd hi6110_rtrd (
                         .clk(clk),
						 .rstn(rd_rdy),
						 .reg_addr(rd_reg_addr),
						 .reg_data(reg_data),
						 .cs(rd_cs),
						 .rw(rd_rw),
						 .str(rd_str),
						 .data_rd()
						 );

hi6110_rttx hi6110_rttx (
                         .clk(clk),
						 .rstn(tx_rdy),
						 .reg_addr(tx_reg_addr),
						 .reg_data(reg_data),
						 .cs(tx_cs),
						 .rw(tx_rw),
						 .str(tx_str)
						 );

hi6110_rtrx hi6110_rtrx (
                         .clk(clk),
						 .rstn(rx_rdy),
						 .reg_addr(rx_reg_addr),
						 .reg_data(reg_data),
						 .cs(rx_cs),
						 .rw(rx_rw),
						 .str(rx_str),
						 .data_rd()
						 );

endmodule
