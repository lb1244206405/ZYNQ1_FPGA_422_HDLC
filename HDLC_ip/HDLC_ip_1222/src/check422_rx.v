module check422_rx (
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

parameter [7:0] word = 8'h3c;

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
reg [1:0] clk_cnt_dly3;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    begin
		clk_cnt_dly1 <= 2'b0;
		clk_cnt_dly2 <= 2'b0;
		clk_cnt_dly3 <= 2'b0;
		end
	 else
	    begin
		clk_cnt_dly1 <= clk_cnt;
		clk_cnt_dly2 <= clk_cnt_dly1;
		clk_cnt_dly3 <= clk_cnt_dly2;
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

reg [7:0] data_reg;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    data_reg <= 8'd0;
	 else if (clk_cnt_dly1 == 2'd1)
	    data_reg <= {data_reg[6:0],data_sample};
	 else if (finish == 1'b1)
	    data_reg <= 8'd0;
end

reg [4:0] word_cnt;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    word_cnt <= 5'd0;
	 else if (clk_cnt_dly2 == 2'd1 && data_reg == word)
	    word_cnt <= word_cnt + 1'b1;
end

reg [10:0] finish_cnt;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    finish_cnt <= 11'd0;
	 else
	    finish_cnt  <= finish_cnt + 1'b1;
end

reg finish;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    finish <= 1'b0;
	 else if (finish_cnt == 11'd1100)
	    finish <= 1'b1;
	 else
	    finish <= 1'b0;
end

reg [3:0] bit_cnt;
reg [4:0] byte_cnt;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    bit_cnt <= 4'd0;
	 else if (bit_cnt == 4'd8)
	    bit_cnt <= 4'd0;
	 else if (clk_cnt_dly1 == 1'b1 && word_cnt != 5'd0 && byte_cnt < 5'd31)
	    bit_cnt <= bit_cnt + 1'b1;
	 else if (byte_cnt == 5'd31)
	    bit_cnt <= 4'd0;
end

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    byte_cnt <= 5'd0;
	 else if (bit_cnt == 4'd8)
	    byte_cnt <= byte_cnt + 1'b1;
end

reg tvalid;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    tvalid <= 1'b0;
	 else if (word_cnt == 5'd0 && data_reg == word)
	    tvalid <= 1'b1;
	 else if (bit_cnt == 4'd8 && byte_cnt <= 5'd30)
	    tvalid <= 1'b1;
	 else
	    tvalid <= 1'b0;
end

reg [7:0] tdata;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    tdata <= 32'd0;
	 else if (word_cnt == 5'd0 && data_reg == word)
	    tdata <= data_reg;
	 else if (bit_cnt == 4'd8 && byte_cnt < 5'd30)
	    tdata <= data_reg;
	 else if (bit_cnt == 4'd8 && byte_cnt == 5'd30)
	    begin
		if (word_cnt >= 5'd25)
		tdata <= 8'hff;
		else
		tdata <= 8'h00;
		end
	 else
	    tdata <= 8'd0;
end

reg tlast;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    tlast <= 1'b0;
	 else if (byte_cnt == 5'd30)
	    tlast <= 1'b1;
	 else
	    tlast <= 1'b0;
end

endmodule