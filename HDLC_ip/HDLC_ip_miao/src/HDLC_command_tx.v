module HDLC_command_tx (
                        clk,
						rstn,
						clk_cnt,
						command_data,
						data_out,
						finish
						);

input         clk;
input         rstn;
input   [1:0] clk_cnt;
input  [31:0] command_data;
output        data_out;
output        finish;

reg rstn_dly;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    rstn_dly <= 1'b0;
	 else
	    rstn_dly <= rstn;
end

reg ctrl_cnt_en;
reg [5:0] ctrl_cnt;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    ctrl_cnt_en <= 1'b0;
	 else if (rstn == 1'b1 && rstn_dly == 1'b0)
	    ctrl_cnt_en <= 1'b1;
	 else if (ctrl_cnt == 6'd52)
	    ctrl_cnt_en <= 1'b0;
end

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    ctrl_cnt <= 6'd0;
	 else if (ctrl_cnt_en == 1'b1)
	    begin
		if (clk_cnt == 2'd1)
		   ctrl_cnt <= ctrl_cnt + 1'b1;
		end
	 else
	    ctrl_cnt <= 6'd0;
end

reg [47:0] command_data_reg;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    command_data_reg <= 48'd0;
	 else if (ctrl_cnt == 6'd1)
	    command_data_reg <= {16'h55aa,command_data};
	 else if (ctrl_cnt >= 6'd2 && ctrl_cnt <= 6'd49)
	    begin
		if (clk_cnt == 2'd1)
		command_data_reg <= {command_data_reg[46:0],1'b0};
		end
	 else
	    command_data_reg <= 48'd0;
end

reg data_out;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    data_out <= 1'b0;
	 else if (ctrl_cnt_en == 1'b1)
	    data_out <= command_data_reg[47];
	 else
	    data_out <= 1'b0;
end

reg ctrl_cnt_en_dly;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    ctrl_cnt_en_dly <= 1'b0;
	 else
	    ctrl_cnt_en_dly <= ctrl_cnt_en;
end

reg finish;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    finish <= 1'b0;
	 else if (ctrl_cnt_en == 1'b0 && ctrl_cnt_en_dly == 1'b1)
	    finish <= 1'b1;
	 else
	    finish <= 1'b0;
end

endmodule