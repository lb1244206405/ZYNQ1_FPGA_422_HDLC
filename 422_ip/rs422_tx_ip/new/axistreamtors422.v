module axistreamtors422 (
                         clk,
						 rstn,
						 tvalid,
						 tready,
						 tlast,
						 tdata,
						 rs422_clk,
						 rs422_cs,
						 rs422_data
						 );

input         clk;
input         rstn;
input         tvalid;
output        tready;
input         tlast;
input   [7:0] tdata;
output        rs422_clk;
output        rs422_cs;
output        rs422_data;

parameter [15:0] rs422_en_delay_time = 16'd50000;

//////////片选与数据时延//////////
reg tvalid_dly;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    tvalid_dly <= 1'b0;
	 else
	    tvalid_dly <= tvalid;
end

reg wait_cnt_1_en;
reg [15:0] wait_cnt_1;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    wait_cnt_1_en <= 1'b0;
	 else if (tvalid == 1'b1 && tvalid_dly == 1'b0)
	    wait_cnt_1_en <= 1'b1;
	 else if (wait_cnt_1 == rs422_en_delay_time)
	    wait_cnt_1_en <= 1'b0;
end

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    wait_cnt_1 <= 16'd0;
	 else if (wait_cnt_1_en == 1'b1)
	    wait_cnt_1 <= wait_cnt_1 + 1'b1;
	 else
	    wait_cnt_1 <= 16'd0;
end

//////////数据发送开始与终止//////////
reg tlast_dly;
reg tlast_dly2;
reg [1:0] clk_cnt;
reg bit_cnt_en;
reg [2:0] bit_cnt;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    tlast_dly <= 1'b0;
	 else if (tlast == 1'b1 && tready == 1'b1)
	    tlast_dly <= 1'b1;
	 else if (bit_cnt_en == 1'b0)
	    tlast_dly <= 1'b0;
end

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    tlast_dly2 <= 1'b0;
	 else
	    tlast_dly2 <= tlast_dly;
end

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    clk_cnt <= 2'd0;
	 else if (bit_cnt_en == 1'b1)
	    clk_cnt <= clk_cnt + 1'b1;
	 else
	    clk_cnt <= 2'd0;
end

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    bit_cnt_en <= 1'b0;
	 else if (wait_cnt_1 == rs422_en_delay_time)
	    bit_cnt_en <= 1'b1;
	 else if (tlast_dly2 == 1'b1 && bit_cnt == 3'd1 && clk_cnt == 2'd0)
	    bit_cnt_en <= 1'b0;
end

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    bit_cnt <= 5'd0;
	 else if (bit_cnt_en == 1'b1)
	    begin
		if (clk_cnt == 2'd2)
		bit_cnt <= bit_cnt + 1'b1;
		end
	 else
	    bit_cnt <= 5'd0;
end

reg bit_cnt_en_dly1;
reg bit_cnt_en_dly2;
reg bit_cnt_en_dly3;
reg bit_cnt_en_dly4;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    begin
		bit_cnt_en_dly1 <= 1'b0;
		bit_cnt_en_dly2 <= 1'b0;
		bit_cnt_en_dly3 <= 1'b0;
		bit_cnt_en_dly4 <= 1'b0;
		end
	 else
	    begin
		bit_cnt_en_dly1 <= bit_cnt_en;
		bit_cnt_en_dly2 <= bit_cnt_en_dly1;
		bit_cnt_en_dly3 <= bit_cnt_en_dly2;
		bit_cnt_en_dly4 <= bit_cnt_en_dly3;
		end
end

//////////从stream—fifo读取数据//////////
reg tready;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    tready <= 1'b0;
	 else if (tvalid == 1'b1)
	    begin
		if (bit_cnt == 3'd1 && clk_cnt == 2'd0)
		tready <= 1'b1;
		else
		tready <= 1'b0;
		end
	 else
	    tready <= 1'b0;
end

reg [7:0] tdata_reg;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    tdata_reg <= 8'd0;
	 else if (tready == 1'b1)
	    tdata_reg <= tdata;
	 else if (clk_cnt == 2'd1)
	    tdata_reg <= {tdata_reg[6:0],1'b0};
	 else if (bit_cnt_en == 1'b0)
	    tdata_reg <= 8'd0;
end

//////////片选与数据时延//////////
reg wait_cnt_2_en;
reg [15:0] wait_cnt_2;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    wait_cnt_2_en <= 1'b0;
	 else if (tlast_dly == 1'b1)
	    wait_cnt_2_en <= 1'b1;
	 else if (wait_cnt_2 == rs422_en_delay_time)
	    wait_cnt_2_en <= 1'b0;
end

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    wait_cnt_2 <= 16'd0;
	 else if (wait_cnt_2_en == 1'b1)
	    wait_cnt_2 <= wait_cnt_2 + 1'b1;
	 else
	    wait_cnt_2 <= 16'd0;
end

//////////spi接口实现//////////
reg rs422_clk;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    rs422_clk <= 1'b1;
	 else if (bit_cnt_en_dly4 == 1'b1 && bit_cnt_en == 1'b1 && (clk_cnt == 2'd1 || clk_cnt == 2'd2))
	    rs422_clk <= 1'b0;
	 else
	    rs422_clk <= 1'b1;
end

reg rs422_en;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    rs422_en <= 1'b0;
	 else if (wait_cnt_1 == 12'd1)
	    rs422_en <= 1'b1;
	 else if (wait_cnt_2 == rs422_en_delay_time)
	    rs422_en <= 1'b0;
end

reg rs422_data;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    rs422_data <= 1'b0;
	 else if (bit_cnt_en == 1'b1)
	    rs422_data <= tdata_reg[7];
	 else
	    rs422_data <= 1'b0;
end

assign rs422_cs = !rs422_en; //| rs422_en_dly;

endmodule