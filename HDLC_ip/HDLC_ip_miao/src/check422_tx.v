module check422_tx (
                    clk,
					rstn,
					clk_out,
					data_out
					);

input         clk;
input         rstn;
output        clk_out;
output        data_out;

parameter [7:0] word = 8'h3c;

reg [1:0] clk_cnt;
reg clk_10M;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    clk_cnt <= 2'b0;
	 else
	    clk_cnt <= clk_cnt + 1'b1;
end

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    clk_10M <= 1'b0;
	 else if (clk_cnt >= 2'd2)
	    clk_10M <= 1'b1;
	 else
	    clk_10M <= 1'b0;
end

reg [7:0] ctrl_cnt;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    ctrl_cnt <= 8'd0;
	 else if (ctrl_cnt <= 8'd250 && clk_cnt == 2'd1)
	    ctrl_cnt  <= ctrl_cnt + 1'b1;
end

reg [2:0] shift_cnt;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    shift_cnt <= 3'd0;
	 else if (ctrl_cnt > 8'd0 && ctrl_cnt <= 8'd248)
	    begin
		if (clk_cnt == 2'd1)
		shift_cnt <= shift_cnt + 1'b1;
		end
	 else
	    shift_cnt <= 3'd0;
end

reg data_out;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    data_out <= 1'b0;
	 else if (ctrl_cnt > 8'd0 && ctrl_cnt <= 8'd248)
	    case(shift_cnt)
		3'd1: data_out <= word[7];
		3'd2: data_out <= word[6];
		3'd3: data_out <= word[5];
		3'd4: data_out <= word[4];
		3'd5: data_out <= word[3];
		3'd6: data_out <= word[2];
		3'd7: data_out <= word[1];
		3'd0: data_out <= word[0];
		endcase
	 else
	    data_out <= 1'b0;
end

assign clk_out = clk_10M;

endmodule