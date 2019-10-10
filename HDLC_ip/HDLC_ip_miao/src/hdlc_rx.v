module hdlc_rx (
                clk,
				rstn,
				clk_in,
				data_in,
				tvalid,
				tlast,
				tdata,
				finish
				);

input         clk;
input         rstn;
input         clk_in;
input         data_in;
output        tvalid;
output        tlast;
output  [7:0] tdata;
output        finish;

parameter head = 8'h7e;

reg [1:0] clk_cnt;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    clk_cnt <= 2'b0;
	 else if (clk_in == 1'b1)
	    clk_cnt <= clk_cnt + 1'b1;
	 else
	    clk_cnt <= 2'b0;
end

reg [1:0] clk_cnt_dly1;
reg [1:0] clk_cnt_dly2;
//reg [1:0] clk_cnt_dly3;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    begin
		clk_cnt_dly1 <= 2'b0;
		clk_cnt_dly2 <= 2'b0;
		//clk_cnt_dly3 <= 2'b0;
		end
	 else
	    begin
		clk_cnt_dly1 <= clk_cnt;
		clk_cnt_dly2 <= clk_cnt_dly1;
		//clk_cnt_dly3 <= clk_cnt_dly2;
		end
end

reg data_sample;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    data_sample <= 1'b0;
	 else if (clk_cnt == 2'd1)
	    data_sample <= data_in;
	 else
	    data_sample <= 1'b0;
end

reg [7:0] head_reg;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    head_reg <= 8'd0;
	 else if (clk_cnt_dly1 == 2'd1)
	    head_reg <= {head_reg[6:0],data_sample};
end

reg [2:0] head_cnt;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    head_cnt <= 3'd0;
	 else if (head_reg == head && clk_cnt_dly2 == 2'd1)
	    head_cnt <= head_cnt + 1'b1;
	 else if (tvalid == 1'b1 && tlast == 1'b1)
        head_cnt <= 3'd5;
	 else if (finish == 1'b1)
	    head_cnt <= 3'd0;
end

reg wait_cnt_en1;
reg [6:0] wait_cnt1;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    wait_cnt_en1 <=1'b0;
	 else if (head_cnt == 3'd5)
	    wait_cnt_en1 <= 1'b1;
	 else if (wait_cnt1 == 7'd127)
	    wait_cnt_en1 <= 1'b0;
end

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    wait_cnt1 <= 7'd0;
	 else if (wait_cnt_en1 == 1'b1)
	    wait_cnt1 <= wait_cnt1 + 1'b1;
	 else
	    wait_cnt1 <= 7'd0;
end

reg wait_cnt_en2;
reg [12:0] wait_cnt2;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    wait_cnt_en2 <=1'b0;
	 else if (wait_cnt2 < 13'h1fff)
	    wait_cnt_en2 <= 1'b1;
	 else
	    wait_cnt_en2 <= 1'b0;
end

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    wait_cnt2 <= 13'd0;
	 else if (wait_cnt_en2 == 1'b1)
	    wait_cnt2 <= wait_cnt2 + 1'b1;
	 else
	    wait_cnt2 <= 13'd0;
end

reg finish;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    finish <= 1'b0;
	 else if (wait_cnt1 == 7'd127||wait_cnt2 == 13'h1fff)
	    finish <= 1'b1;
	 else
	    finish <= 1'b0;
end

reg [2:0] ones_cnt;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    ones_cnt <= 3'd0;
	 else if (head_cnt == 3'd4 && clk_cnt_dly1 == 2'd1)
	    begin
		if (data_sample == 1'b1)
		ones_cnt <= ones_cnt + 1'b1;
		else
		ones_cnt <= 3'd0;
		end
	 else if (head_cnt == 3'd5)
	    ones_cnt <= 3'd0;
end

reg [7:0] data_reg;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    data_reg <= 8'd0;
	 else if (clk_cnt_dly1 == 2'd1)
	    begin
		if (ones_cnt != 3'd5)
		data_reg <= {data_reg[6:0],data_sample};
		end
	 else if (finish == 1'b1)
	    data_reg <= 8'd0;
end

reg [3:0] bit_cnt;

always @ (posedge clk or negedge rstn)
begin
     if (!rstn)
	    bit_cnt <= 4'd0;
	 else if (bit_cnt == 4'd8 && ones_cnt != 3'd5)
	    bit_cnt <= 4'd0;
	 else if (head_cnt == 3'd4)
	    begin
		if (ones_cnt != 3'd5 && clk_cnt_dly1 == 1'b1)
		bit_cnt <= bit_cnt + 1'b1;
		end
	 else
	    bit_cnt <= 4'd0;
end

reg [15:0] byte_cnt;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    byte_cnt <= 16'd0;
	 else if (tvalid == 1'b1)
	    byte_cnt <= byte_cnt + 1'b1;
	 else if (head_cnt == 3'd5)
	    byte_cnt <= 16'd0;
end

reg [15:0] byte_length;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    byte_length <= 16'd0;
	 //else if (tvalid == 1'b1 && byte_cnt == 16'd1)
	    //byte_length <= {tdata,8'd0};
	 else if (tvalid == 1'b1 && byte_cnt == 16'd2)
	    byte_length <= {8'd0,tdata};
	 else if (head_cnt == 3'd5)
	    byte_length <= 16'd0;
end

reg tvalid;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    tvalid <= 1'b0;
	 else if (bit_cnt == 4'd8 && clk_cnt_dly2 == 2'd1 && ones_cnt != 3'd5)
	    tvalid <= 1'b1;
	 else
	    tvalid <= 1'b0;
end

reg [7:0] tdata;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    tdata <= 32'd0;
	 else if (bit_cnt == 4'd8 && clk_cnt_dly2 == 1'b1 && ones_cnt != 3'd5)
	    tdata <= data_reg;
	 else
	    tdata <= 8'd0;
end

wire tlast;

//assign tlast = ((byte_cnt == (byte_length + 16'd2) && byte_length != 16'd0)|| finish == 1'b1)?1'b1:1'b0;
assign tlast = (byte_cnt == (byte_length + 16'd2) && byte_length != 16'd0)?1'b1:1'b0;
/* always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    tlast <= 1'b0;
	 else if (byte_cnt == (byte_length + 16'd2) && byte_length != 16'd0)
	    tlast <= 1'b1;
	 else
	    tlast <= 1'b0;
end */

endmodule