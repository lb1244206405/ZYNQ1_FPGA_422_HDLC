module hi6110_rtwr (
                    clk,
					rstn,
					reg_addr,
					reg_data,
					cs,
					rw,
					str
					);

input         clk;
input         rstn;
output  [3:0] reg_addr;
inout  [15:0] reg_data;
output        cs;
output        rw;
output        str;

parameter  [3:0] control_register_addr = 4'b0100,
                 transmit_status_word_addr = 4'b0000;

parameter [15:0] control_register_data = 16'b0001_0000_0010_1000,
                 transmit_status_word_data = 16'b10101_0_00000_00000;

reg [4:0] ctrl_cnt;
reg [2:0] reg_cnt;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    ctrl_cnt <= 4'd0;
	 else if (reg_cnt < 3'd3)
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
	 else if (ctrl_cnt >= 5'd5 && ctrl_cnt <= 5'd25)
	    cs <= 1'b0;
	 else
	    cs <= 1'b1;
end

reg rw;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    rw <= 1'b1;
	 else// if (ctrl_cnt >= 5'd5 && ctrl_cnt <= 5'd25)
	    rw <= 1'b0;
	 //else
	    //rw <= 1'b1;
end

reg str;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    str <= 1'b1;
	 else if (ctrl_cnt >= 5'd10 && ctrl_cnt <= 5'd18)
	    str <= 1'b0;
	 else
	    str <= 1'b1;
end

reg [3:0] reg_addr;
reg [15:0] reg_data_buff;

always @(posedge clk or negedge rstn)
begin
     if (!rstn)
	    begin
		reg_addr <= 4'd0;
		reg_data_buff <= 16'd0;
		end
	 else
	    case (reg_cnt)
		3'd0:
		begin
		reg_addr <= control_register_addr;
		reg_data_buff <= control_register_data;
		end
		3'd1:
		begin
		reg_addr <= control_register_addr;
		reg_data_buff <= control_register_data;
		end
		3'd2:
		begin
		reg_addr <= control_register_addr;
		reg_data_buff <= control_register_data;
		end
		3'd3:
		begin
		reg_addr <= control_register_addr;
		reg_data_buff <= control_register_data;
		end
		3'd4:
		begin
		reg_addr <= control_register_addr;
		reg_data_buff <= control_register_data;
		end
		default:
		begin
		reg_addr <= 4'd0;
		reg_data_buff <= 16'd0;
		end
		endcase
end

assign reg_data = (rstn == 1)? reg_data_buff : 16'hzzzz;

endmodule