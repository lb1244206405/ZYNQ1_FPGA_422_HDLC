//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
//Date        : Tue Dec 18 23:04:48 2018
//Host        : homepc running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (S_AXIS_tdata,
    S_AXIS_tkeep,
    S_AXIS_tlast,
    S_AXIS_tready,
    S_AXIS_tstrb,
    S_AXIS_tvalid,
    aclk,
    aresetn,
    rs422_clk,
    rs422_cs,
    rs422_data);
  input [31:0]S_AXIS_tdata;
  input [3:0]S_AXIS_tkeep;
  input S_AXIS_tlast;
  output S_AXIS_tready;
  input [3:0]S_AXIS_tstrb;
  input S_AXIS_tvalid;
  input aclk;
  input aresetn;
  output rs422_clk;
  output rs422_cs;
  output rs422_data;

  wire [31:0]S_AXIS_tdata;
  wire [3:0]S_AXIS_tkeep;
  wire S_AXIS_tlast;
  wire S_AXIS_tready;
  wire [3:0]S_AXIS_tstrb;
  wire S_AXIS_tvalid;
  wire aclk;
  wire aresetn;
  wire rs422_clk;
  wire rs422_cs;
  wire rs422_data;

  design_1 design_1_i
       (.S_AXIS_tdata(S_AXIS_tdata),
        .S_AXIS_tkeep(S_AXIS_tkeep),
        .S_AXIS_tlast(S_AXIS_tlast),
        .S_AXIS_tready(S_AXIS_tready),
        .S_AXIS_tstrb(S_AXIS_tstrb),
        .S_AXIS_tvalid(S_AXIS_tvalid),
        .aclk(aclk),
        .aresetn(aresetn),
        .rs422_clk(rs422_clk),
        .rs422_cs(rs422_cs),
        .rs422_data(rs422_data));
endmodule
