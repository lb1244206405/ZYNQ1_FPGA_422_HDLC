module HDLC_command_rx (
                        clk,
						rstn,
						clk_in,
						data_in,
						tvalid,
						tlast,
						tdata
						);

input         clk;
input         rstn;
input         clk_in;
input         data_in;
output        tvalid;
output        tlast;
output  [7:0] tdata;

reg [1:0] clk_cnt;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    clk_cnt <= 2'd0;
	 else if (clk_in == 1'b1)
	    clk_cnt <= clk_cnt + 1'b1;
	 else
	    clk_cnt <= 1'b0;
end

reg [1:0] clk_cnt_dly1;
reg [1:0] clk_cnt_dly2;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    begin
		clk_cnt_dly1 <= 2'd0;
		clk_cnt_dly2 <= 2'd0;
		end
	 else
	    begin
		clk_cnt_dly1 <= clk_cnt;
		clk_cnt_dly2 <= clk_cnt_dly1;
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
end

reg bit_cnt_en;
reg bit_cnt_en_dly;
reg [5:0] bit_cnt;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    bit_cnt_en <= 1'b0;
	 else if (data_reg == 8'h55)
	    bit_cnt_en <= 1'b1;
	 else if (bit_cnt == 6'd40)
	    bit_cnt_en <= 1'b0;
end

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    bit_cnt_en_dly <= 1'b0;
	 else
	    bit_cnt_en_dly <= bit_cnt_en;
end

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    bit_cnt <= 5'd0;
	 else if (bit_cnt_en == 1'b1)
	    begin
		if (clk_cnt_dly1 == 2'd1)
		bit_cnt <= bit_cnt + 1'b1;
		end
	 else
	    bit_cnt <= 5'd0;
end

reg tvalid;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    tvalid <= 1'b0;
	 else if (bit_cnt_en == 1'b1 && bit_cnt_en_dly == 1'b0)
	    tvalid <= 1'b1;
	 else if (bit_cnt_en == 1'b1 && clk_cnt_dly2 == 2'd1)
	    begin
		case (bit_cnt)
		6'd8:tvalid <= 1'b1;
		6'd16:tvalid <= 1'b1;
		6'd24:tvalid <= 1'b1;
		6'd32:tvalid <= 1'b1;
		6'd40:tvalid <= 1'b1;
		default:tvalid <= 1'b0;
		endcase
		end
	 else
	    tvalid <= 1'b0;
end

reg [7:0] tdata;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    tdata <= 8'd0;
	 else if (bit_cnt_en == 1'b1 && bit_cnt_en_dly == 1'b0)
	    tdata <= data_reg;
	 else if (bit_cnt_en == 1'b1 && clk_cnt_dly2 == 2'd1)
	    begin
		case (bit_cnt)
		6'd8:tdata <= data_reg;
		6'd16:tdata <= data_reg;
		6'd24:tdata <= data_reg;
		6'd32:tdata <= data_reg;
		6'd40:tdata <= data_reg;
		default:tdata <= 8'd0;
		endcase
		end
	 else
	    tdata <= 8'd0;
end

reg tlast_forward;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    tlast_forward <= 1'b0;
	 else if (bit_cnt >= 6'd32 && bit_cnt <= 6'd40)
	    tlast_forward <= 1'b1;
	 else
	    tlast_forward <= 1'b0;
end

reg tlast;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    tlast <= 1'b0;
	 else if (bit_cnt_en == 1'b1)
	    tlast <= tlast_forward;
	 else
	    tlast <= 1'b0;
end

endmodule