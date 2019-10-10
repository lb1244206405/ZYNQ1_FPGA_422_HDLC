//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
//Date        : Mon Dec 24 13:23:38 2018
//Host        : homepc running 64-bit major release  (build 9200)
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=3,numReposBlks=3,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
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
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS, CLK_DOMAIN design_1_aclk, FREQ_HZ 10000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 1, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) output [31:0]M_AXIS_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TKEEP" *) output [3:0]M_AXIS_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TLAST" *) output M_AXIS_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TREADY" *) input M_AXIS_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TSTRB" *) output [3:0]M_AXIS_tstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TVALID" *) output M_AXIS_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS, CLK_DOMAIN design_1_aclk, FREQ_HZ 10000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 1, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TKEEP" *) input [3:0]S_AXIS_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TLAST" *) input S_AXIS_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TREADY" *) output S_AXIS_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TSTRB" *) input [3:0]S_AXIS_tstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TVALID" *) input S_AXIS_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ACLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ACLK, ASSOCIATED_BUSIF S_AXIS:M_AXIS, ASSOCIATED_RESET aresetn, CLK_DOMAIN design_1_aclk, FREQ_HZ 10000000, PHASE 0.000" *) input aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.ARESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.ARESETN, POLARITY ACTIVE_LOW" *) input aresetn;
  input rs422_rx_clk;
  input rs422_rx_data;
  output rs422_tx_clk;
  output rs422_tx_data;

  wire RS422_top_0_rs422_tx_clk;
  wire RS422_top_0_rs422_tx_data;
  wire [7:0]RS422_top_0_stream_out_TDATA;
  wire RS422_top_0_stream_out_TLAST;
  wire RS422_top_0_stream_out_TREADY;
  wire RS422_top_0_stream_out_TVALID;
  wire [31:0]S_AXIS_1_TDATA;
  wire [3:0]S_AXIS_1_TKEEP;
  wire S_AXIS_1_TLAST;
  wire S_AXIS_1_TREADY;
  wire [3:0]S_AXIS_1_TSTRB;
  wire S_AXIS_1_TVALID;
  wire aclk_1;
  wire aresetn_1;
  wire [7:0]axis_dwidth_converter_0_M_AXIS_TDATA;
  wire axis_dwidth_converter_0_M_AXIS_TLAST;
  wire axis_dwidth_converter_0_M_AXIS_TREADY;
  wire axis_dwidth_converter_0_M_AXIS_TVALID;
  wire [31:0]axis_dwidth_converter_1_M_AXIS_TDATA;
  wire [3:0]axis_dwidth_converter_1_M_AXIS_TKEEP;
  wire axis_dwidth_converter_1_M_AXIS_TLAST;
  wire axis_dwidth_converter_1_M_AXIS_TREADY;
  wire [3:0]axis_dwidth_converter_1_M_AXIS_TSTRB;
  wire axis_dwidth_converter_1_M_AXIS_TVALID;
  wire rs422_rx_clk_1;
  wire rs422_rx_data_1;

  assign M_AXIS_tdata[31:0] = axis_dwidth_converter_1_M_AXIS_TDATA;
  assign M_AXIS_tkeep[3:0] = axis_dwidth_converter_1_M_AXIS_TKEEP;
  assign M_AXIS_tlast = axis_dwidth_converter_1_M_AXIS_TLAST;
  assign M_AXIS_tstrb[3:0] = axis_dwidth_converter_1_M_AXIS_TSTRB;
  assign M_AXIS_tvalid = axis_dwidth_converter_1_M_AXIS_TVALID;
  assign S_AXIS_1_TDATA = S_AXIS_tdata[31:0];
  assign S_AXIS_1_TKEEP = S_AXIS_tkeep[3:0];
  assign S_AXIS_1_TLAST = S_AXIS_tlast;
  assign S_AXIS_1_TSTRB = S_AXIS_tstrb[3:0];
  assign S_AXIS_1_TVALID = S_AXIS_tvalid;
  assign S_AXIS_tready = S_AXIS_1_TREADY;
  assign aclk_1 = aclk;
  assign aresetn_1 = aresetn;
  assign axis_dwidth_converter_1_M_AXIS_TREADY = M_AXIS_tready;
  assign rs422_rx_clk_1 = rs422_rx_clk;
  assign rs422_rx_data_1 = rs422_rx_data;
  assign rs422_tx_clk = RS422_top_0_rs422_tx_clk;
  assign rs422_tx_data = RS422_top_0_rs422_tx_data;
  design_1_RS422_top_0_0 RS422_top_0
       (.clk(aclk_1),
        .rs422_rx_clk(rs422_rx_clk_1),
        .rs422_rx_data(rs422_rx_data_1),
        .rs422_tx_clk(RS422_top_0_rs422_tx_clk),
        .rs422_tx_data(RS422_top_0_rs422_tx_data),
        .rstn(aresetn_1),
        .stream_in_tdata(axis_dwidth_converter_0_M_AXIS_TDATA),
        .stream_in_tlast(axis_dwidth_converter_0_M_AXIS_TLAST),
        .stream_in_tready(axis_dwidth_converter_0_M_AXIS_TREADY),
        .stream_in_tvalid(axis_dwidth_converter_0_M_AXIS_TVALID),
        .stream_out_tdata(RS422_top_0_stream_out_TDATA),
        .stream_out_tlast(RS422_top_0_stream_out_TLAST),
        .stream_out_tready(RS422_top_0_stream_out_TREADY),
        .stream_out_tvalid(RS422_top_0_stream_out_TVALID));
  design_1_axis_dwidth_converter_0_0 axis_dwidth_converter_0
       (.aclk(aclk_1),
        .aresetn(aresetn_1),
        .m_axis_tdata(axis_dwidth_converter_0_M_AXIS_TDATA),
        .m_axis_tlast(axis_dwidth_converter_0_M_AXIS_TLAST),
        .m_axis_tready(axis_dwidth_converter_0_M_AXIS_TREADY),
        .m_axis_tvalid(axis_dwidth_converter_0_M_AXIS_TVALID),
        .s_axis_tdata(S_AXIS_1_TDATA),
        .s_axis_tkeep(S_AXIS_1_TKEEP),
        .s_axis_tlast(S_AXIS_1_TLAST),
        .s_axis_tready(S_AXIS_1_TREADY),
        .s_axis_tstrb(S_AXIS_1_TSTRB),
        .s_axis_tvalid(S_AXIS_1_TVALID));
  design_1_axis_dwidth_converter_1_0 axis_dwidth_converter_1
       (.aclk(aclk_1),
        .aresetn(aresetn_1),
        .m_axis_tdata(axis_dwidth_converter_1_M_AXIS_TDATA),
        .m_axis_tkeep(axis_dwidth_converter_1_M_AXIS_TKEEP),
        .m_axis_tlast(axis_dwidth_converter_1_M_AXIS_TLAST),
        .m_axis_tready(axis_dwidth_converter_1_M_AXIS_TREADY),
        .m_axis_tstrb(axis_dwidth_converter_1_M_AXIS_TSTRB),
        .m_axis_tvalid(axis_dwidth_converter_1_M_AXIS_TVALID),
        .s_axis_tdata(RS422_top_0_stream_out_TDATA),
        .s_axis_tkeep(1'b1),
        .s_axis_tlast(RS422_top_0_stream_out_TLAST),
        .s_axis_tready(RS422_top_0_stream_out_TREADY),
        .s_axis_tstrb(1'b1),
        .s_axis_tvalid(RS422_top_0_stream_out_TVALID));
endmodule
