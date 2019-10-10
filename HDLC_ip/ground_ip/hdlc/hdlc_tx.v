module hdlc_tx (
                clk,
				rstn,
				tvalid,
				tready,
				tlast,
				tdata,
				clk_in,
				clk_out,
				data_out,
				data_finish
				);

input         clk;
input         rstn;
input         tvalid;
output        tready;
input         tlast;
input   [7:0] tdata;
input         clk_in;
output        clk_out;
output        data_out;
output        data_finish;

reg clk_in_dly;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    clk_in_dly <= 1'b0;
	 else
	    clk_in_dly <= clk_in;
end

reg [1:0] clk_cnt;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    clk_cnt <= 2'd0;
	 else if (clk_in == 1'b1 && clk_in_dly == 1'b0)
	    clk_cnt <= 2'd0;
	 else
	    clk_cnt <= clk_cnt + 1'b1;
end

reg tlast_dly;
reg tlast_dly2;
reg bit_cnt_en;
reg [2:0] bit_cnt;
reg ones_cnt_en;
reg [2:0] ones_cnt;//记录连1的数量

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
	    bit_cnt_en <= 1'b0;
	 else if (tvalid == 1'b1)
	    bit_cnt_en <= 1'b1;
	 else if (tlast_dly2 == 1'b1 && bit_cnt == 3'd1 && clk_cnt == 2'd1)
	    bit_cnt_en <= 1'b0;
end

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    bit_cnt <= 5'd0;
	 else if (bit_cnt_en == 1'b1)
	    begin
		if (clk_cnt == 2'd2 && ones_cnt != 3'd5)
		bit_cnt <= bit_cnt + 1'b1;
		end
	 else
	    bit_cnt <= 5'd0;
end

reg tready;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    tready <= 1'b0;
	 else if (tvalid == 1'b1 && ones_cnt != 3'd5)
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
	    tdata_reg <= 32'd0;
	 else if (tready == 1'b1)
	    tdata_reg <= tdata;
	 else if (clk_cnt == 2'd1 && ones_cnt != 3'd5)
	    tdata_reg <= {tdata_reg[6:0],1'b0};
	 else if (bit_cnt_en == 1'b0)
	    tdata_reg <= 32'd0;
end

reg [15:0] byte_cnt;

always @ (posedge clk or negedge rstn)
begin
     if (!rstn)
	    byte_cnt <= 16'd0;
	 else if (tready == 1'b1)
	    byte_cnt <= byte_cnt + 1'b1;
	 else if (data_finish == 1'b1)
	    byte_cnt <= 16'd0;
end

reg [15:0] byte_length;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    byte_length <= 16'd0;
	 else if (byte_cnt == 3'd5 && tready == 1'b1)
	    byte_length <= {tdata,8'd0};
	 else if (byte_cnt == 3'd6 && tready == 1'b1)
	    byte_length <= {byte_length[15:8],tdata};
	 else if (data_finish == 1'b1)
	    byte_length <= 16'd0;
end

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    ones_cnt_en <= 1'b0;
	 else if (byte_cnt >= 3'd5 && byte_cnt <= (byte_length + 3'd7))
	    ones_cnt_en <= 1'b1;
	 else
	    ones_cnt_en <= 1'b0;
end

always @(posedge clk or negedge rstn)
begin
    if (!rstn)
	   ones_cnt <= 1'b0;
	else if (ones_cnt_en == 1'b1 && clk_cnt == 2'd1)
	   begin
	   if (ones_cnt <= 3'd5 && data_out == 1'b1)
	   ones_cnt <= ones_cnt + 1'b1;
	   else
	   ones_cnt <= 3'd0;
	   end
	else if (ones_cnt_en == 1'b0)
	   ones_cnt <= 3'd0;
end

reg clk_out;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    clk_out <= 1'b0;
	 else if (clk_cnt >= 2'd2)
	    clk_out <= 1'b1;
	 else
	    clk_out <= 1'b0;
end

reg data_out;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    data_out <= 1'b0;
	 else if (bit_cnt_en == 1'b1)
	    if (ones_cnt != 3'd5)
		data_out <= tdata_reg[7];
		else
		data_out <= 1'b0;
	 else
	    data_out <= 1'b0;
end

reg data_finish;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    data_finish <= 1'b0;
	 else if (tlast_dly == 1'b0 && tlast_dly2 == 1'b1)
	    data_finish <= 1'b1;
	 else
	    data_finish <= 1'b0;
end

endmodule