//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
//Date        : Mon Dec 24 13:23:38 2018
//Host        : homepc running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (M_AXIS_tdata,
    M_AXIS_tkeep,
    M_AXIS_tlast,
    M_AXIS_tready,
    M_AXIS_tstrb,
    M_AXIS_tvalid,
    S_AXIS_tdata,
    S_AXIS_tkeep,
    S_AXIS_tlast,
    S_AXIS_tready,
    S_AXIS_tstrb,
    S_AXIS_tvalid,
    aclk,
    aresetn,
    rs422_rx_clk,
    rs422_rx_data,
    rs422_tx_clk,
    rs422_tx_data);
  output [31:0]M_AXIS_tdata;
  output [3:0]M_AXIS_tkeep;
  output M_AXIS_tlast;
  input M_AXIS_tready;
  output [3:0]M_AXIS_tstrb;
  output M_AXIS_tvalid;
  input [31:0]S_AXIS_tdata;
  input [3:0]S_AXIS_tkeep;
  input S_AXIS_tlast;
  output S_AXIS_tready;
  input [3:0]S_AXIS_tstrb;
  input S_AXIS_tvalid;
  input aclk;
  input aresetn;
  input rs422_rx_clk;
  input rs422_rx_data;
  output rs422_tx_clk;
  output rs422_tx_data;

  wire [31:0]M_AXIS_tdata;
  wire [3:0]M_AXIS_tkeep;
  wire M_AXIS_tlast;
  wire M_AXIS_tready;
  wire [3:0]M_AXIS_tstrb;
  wire M_AXIS_tvalid;
  wire [31:0]S_AXIS_tdata;
  wire [3:0]S_AXIS_tkeep;
  wire S_AXIS_tlast;
  wire S_AXIS_tready;
  wire [3:0]S_AXIS_tstrb;
  wire S_AXIS_tvalid;
  wire aclk;
  wire aresetn;
  wire rs422_rx_clk;
  wire rs422_rx_data;
  wire rs422_tx_clk;
  wire rs422_tx_data;

  design_1 design_1_i
       (.M_AXIS_tdata(M_AXIS_tdata),
        .M_AXIS_tkeep(M_AXIS_tkeep),
        .M_AXIS_tlast(M_AXIS_tlast),
        .M_AXIS_tready(M_AXIS_tready),
        .M_AXIS_tstrb(M_AXIS_tstrb),
        .M_AXIS_tvalid(M_AXIS_tvalid),
        .S_AXIS_tdata(S_AXIS_tdata),
        .S_AXIS_tkeep(S_AXIS_tkeep),
        .S_AXIS_tlast(S_AXIS_tlast),
        .S_AXIS_tready(S_AXIS_tready),
        .S_AXIS_tstrb(S_AXIS_tstrb),
        .S_AXIS_tvalid(S_AXIS_tvalid),
        .aclk(aclk),
        .aresetn(aresetn),
        .rs422_rx_clk(rs422_rx_clk),
        .rs422_rx_data(rs422_rx_data),
        .rs422_tx_clk(rs422_tx_clk),
        .rs422_tx_data(rs422_tx_data));
endmodule
