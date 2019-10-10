module RS422_top (
                  clk,
				  rstn,
				  stream_out_tvalid,
				  stream_out_tready,
				  stream_out_tlast,
				  stream_out_tdata,
				  stream_in_tvalid,
				  stream_in_tready,
				  stream_in_tlast,
				  stream_in_tdata,
				  rs422_tx_clk,
				  rs422_tx_data,
				  rs422_rx_clk,
				  rs422_rx_data
				  );

input         clk;
input         rstn;
output        stream_out_tvalid;
input         stream_out_tready;
output        stream_out_tlast;
output  [7:0] stream_out_tdata;
input         stream_in_tvalid;
output        stream_in_tready;
input         stream_in_tlast;
input   [7:0] stream_in_tdata;
output        rs422_tx_clk;
output        rs422_tx_data;
input         rs422_rx_clk;
input         rs422_rx_data;

HDLC_command_rx HDLC_command_rx (
                                 .clk(clk),
								 .rstn(rstn),
								 .clk_in(rs422_rx_clk),
								 .data_in(rs422_rx_data),
								 .tvalid(stream_out_tvalid),
								 .tlast(stream_out_tlast),
								 .tdata(stream_out_tdata)
								 );

hdlc_tx hdlc_tx (
                 .clk(clk),
				 .rstn(rstn),
				 .tvalid(stream_in_tvalid),
				 .tready(stream_in_tready),
				 .tlast(stream_in_tlast),
				 .tdata(stream_in_tdata),
				 .clk_in(rs422_rx_clk),
				 .clk_out(rs422_tx_clk),
				 .data_out(rs422_tx_data),
				 .data_finish()
				 );

endmodule