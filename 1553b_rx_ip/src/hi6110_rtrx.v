module hi6110_rtrx (
                    clk,
					rstn,
					reg_addr,
					reg_data,
					cs,
					rw,
					str,
					data_rd
					);

input         clk;
input         rstn;
output  [3:0] reg_addr;
inout  [15:0] reg_data;
output        cs;
output        rw;
output        str;
output [15:0] data_rd;

parameter  [3:0] received_data_fifo_addr = 4'b0100;

reg [4:0] ctrl_cnt;
reg [3:0] reg_cnt;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    ctrl_cnt <= 4'd0;
	 else if (reg_cnt < 4'd3)
	    ctrl_cnt <= ctrl_cnt + 1'b1;
	 else
	    ctrl_cnt <= 4'd0;
end

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    reg_cnt <= 2'd0;
	 else if (ctrl_cnt == 5'd31)
	    reg_cnt <= reg_cnt + 1'b1;
end

reg cs;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    cs <= 1'b1;
	 else if (ctrl_cnt >= 5'd5 && ctrl_cnt <= 5'd29)
	    cs <= 1'b0;
	 else
	    cs <= 1'b1;
end

reg rw;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    rw <= 1'b0;
	 else// if (ctrl_cnt >= 5'd5 && ctrl_cnt <= 5'd29)
	    rw <= 1'b1;
	 //else
	    //rw <= 1'b0;
end

reg str;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    str <= 1'b1;
	 else if (ctrl_cnt >= 5'd10 && ctrl_cnt <= 5'd25)
	    str <= 1'b0;
	 else
	    str <= 1'b1;
end

reg [3:0] reg_addr;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    reg_addr <= 4'd0;
	 else
	    case (reg_cnt)
		4'd0:
		reg_addr <= received_data_fifo_addr;
		4'd1:
		reg_addr <= received_data_fifo_addr;
		4'd2:
		reg_addr <= received_data_fifo_addr;
/* 		4'd3:
		reg_addr <= received_data_fifo_addr;
		4'd4:
		reg_addr <= status_register_addr;
		4'd5:
		reg_addr <= error_register_addr;
		4'd6:
		reg_addr <= busA_word_addr;
		4'd7:
		reg_addr <= busB_word_addr; */
		default:
		reg_addr <= 4'd0;
		endcase
end

reg [15:0] data_rd;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    data_rd <= 16'd0;
	 else
	    data_rd <= reg_data;
end

endmodule