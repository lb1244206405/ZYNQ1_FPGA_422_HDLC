module rs422toaxistream (
                         clk,
						 rstn,
						 tvalid,
						 tready,
						 tlast,
						 tdata,
						 rs422_clk,
						 rs422_en,
						 rs422_data
						 );

input         clk;
input         rstn;
output        tvalid;
input         tready;
output        tlast;
output  [7:0] tdata;
input         rs422_clk;
input         rs422_en;
input         rs422_data;

reg rs422_clk_dly;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    rs422_clk_dly <= 1'b1;
	 else if (rs422_en == 1'b0)
	    rs422_clk_dly <= rs422_clk;
	 else
	    rs422_clk_dly <= 1'b1;
end

reg [1:0] ctrl_cnt;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    ctrl_cnt <= 2'd0;
	 else if (rs422_clk == 1'b1 && rs422_clk_dly == 1'b0)
	    ctrl_cnt <= ctrl_cnt + 1'b1;
	 else
	    ctrl_cnt <= 2'd0;
end

reg [1:0] ctrl_cnt_dly;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    ctrl_cnt_dly <= 2'd0;
	 else if (rs422_en == 1'b0)
	    ctrl_cnt_dly <= ctrl_cnt;
	 else
	    ctrl_cnt_dly <= 2'd0;
end

reg [1:0] ctrl_cnt_dly2;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    ctrl_cnt_dly2 <= 2'd0;
	 else if (rs422_en == 1'b0)
	    ctrl_cnt_dly2 <= ctrl_cnt_dly;
	 else
	    ctrl_cnt_dly2 <= 2'd0;
end

reg rs422_data_in;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    rs422_data_in <= 1'b0;
	 else if (ctrl_cnt == 2'd1)
	    rs422_data_in <= rs422_data;
	 else
	    rs422_data_in <= 1'b0;
end

reg [7:0] rs422_data_reg;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    rs422_data_reg <= 8'd0;
	 else if (ctrl_cnt_dly == 2'd1)
	    rs422_data_reg <= {rs422_data_reg[6:0],rs422_data_in};
end

reg [3:0] bit_cnt;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    bit_cnt <= 4'd0;
	 else if (bit_cnt == 4'd8)
	    bit_cnt <= 4'd0;
	 else if (ctrl_cnt_dly == 1'b1)
	    bit_cnt <= bit_cnt + 1'b1;
end

reg tvalid;
reg [7:0] tdata;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    begin
		tvalid <= 1'b0;
		tdata <= 8'd0;
		end
	 else if (ctrl_cnt_dly2 == 2'd1 && bit_cnt == 4'd8)
	    begin
		tvalid <= 1'b1;
		tdata <= rs422_data_reg;
		end
	 else
	    begin
		tvalid <= 1'b0;
		tdata <= 8'd0;
		end
end

reg [15:0] byte_cnt;
reg [15:0] byte_length;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    byte_cnt <= 8'd0;
	 else if (tvalid == 1'b1)
	    byte_cnt <= byte_cnt + 1'b1;
	 else if (byte_length == byte_cnt - 16'd7 && byte_length != 1'b0)
	    byte_cnt <= 8'd0;
end

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    byte_length <= 8'd0;
	 else if (byte_cnt == 8'd5)
	    byte_length <= {tdata,8'd0};
	 else if (byte_cnt == 8'd6)
	    byte_length <= {byte_length[15:8],tdata};
	 else if (byte_length == byte_cnt - 16'd7 && byte_length != 1'b0)
	    byte_length <= 8'd0;
end

wire tlast;

assign tlast = (byte_length == byte_cnt - 16'd6 && byte_length != 1'b0)? 1'b1 : 1'b0;

/* always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    tlast <= 1'b1;
	 else if (byte_length == byte_cnt - 16'd6 && byte_length != 1'b0)
	    tlast <= 1'b1;
	 else
	    tlast <= 1'b0;
end */


/* wire fifo_rd_en;
wire [7:0] fifo_rd_data;

assign fifo_rd_en = (tvalid == 1'b1 && tlast != 1'b1)? tready:1'b0;
assign tdata = fifo_rd_data;

reg [15:0] byte_cnt;
reg [15:0] byte_length;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    byte_cnt <= 8'd0;
	 else if (fifo_rd_en == 1'b1)
	    byte_cnt <= byte_cnt + 1'b1;
	 else if (byte_length == byte_cnt - 16'd7 && byte_length != 1'b0)
	    byte_cnt <= 8'd0;
end

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    byte_length <= 8'd0;
	 else if (byte_cnt == 8'd6)
	    byte_length <= {fifo_rd_data,8'd0};
	 else if (byte_cnt == 8'd7)
	    byte_length <= {byte_length[15:8],fifo_rd_data};
	 else if (byte_length == byte_cnt - 16'd7 && byte_length != 1'b0)
	    byte_length <= 8'd0;
end

wire [9:0] fifo_data_cnt;

reg tvalid;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    tvalid <= 1'b0;
	 else if (fifo_data_cnt >= 9'd25)//change
	    tvalid <= 1'b1;
	 else if (byte_length == byte_cnt - 16'd7 && byte_length != 1'b0)
	    tvalid <= 1'b0;
end

reg tlast;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    tlast <= 1'b0;
	 else if (byte_length == byte_cnt - 16'd6 && byte_length != 1'b0)
	    tlast <= 1'b1;
	 else
	    tlast <= 1'b0;
end

ahead_buffer ab(
		.rst(!rstn),
		.wr_clk(clk),
		.rd_clk(clk),
		.din(fifo_wr_data),
		.wr_en(fifo_wr_en),
		.rd_en(fifo_rd_en),
		.dout(fifo_rd_data),
		.full(),
		.empty(),
		.rd_data_count(fifo_data_cnt),
		.wr_data_count()
	); */

endmodule