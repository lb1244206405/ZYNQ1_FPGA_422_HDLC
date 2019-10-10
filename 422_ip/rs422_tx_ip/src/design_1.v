//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
//Date        : Tue Dec 18 23:04:48 2018
//Host        : homepc running 64-bit major release  (build 9200)
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=2,numReposBlks=2,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
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
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS, CLK_DOMAIN design_1_aclk, FREQ_HZ 10000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 1, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TKEEP" *) input [3:0]S_AXIS_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TLAST" *) input S_AXIS_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TREADY" *) output S_AXIS_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TSTRB" *) input [3:0]S_AXIS_tstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TVALID" *) input S_AXIS_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ACLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ACLK, ASSOCIATED_BUSIF S_AXIS, ASSOCIATED_RESET aresetn, CLK_DOMAIN design_1_aclk, FREQ_HZ 10000000, PHASE 0.000" *) input aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.ARESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.ARESETN, POLARITY ACTIVE_LOW" *) input aresetn;
  output rs422_clk;
  output rs422_cs;
  output rs422_data;

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
  wire axistreamtors422_0_rs422_clk;
  wire axistreamtors422_0_rs422_cs;
  wire axistreamtors422_0_rs422_data;

  assign S_AXIS_1_TDATA = S_AXIS_tdata[31:0];
  assign S_AXIS_1_TKEEP = S_AXIS_tkeep[3:0];
  assign S_AXIS_1_TLAST = S_AXIS_tlast;
  assign S_AXIS_1_TSTRB = S_AXIS_tstrb[3:0];
  assign S_AXIS_1_TVALID = S_AXIS_tvalid;
  assign S_AXIS_tready = S_AXIS_1_TREADY;
  assign aclk_1 = aclk;
  assign aresetn_1 = aresetn;
  assign rs422_clk = axistreamtors422_0_rs422_clk;
  assign rs422_cs = axistreamtors422_0_rs422_cs;
  assign rs422_data = axistreamtors422_0_rs422_data;
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
  design_1_axistreamtors422_0_0 axistreamtors422_0
       (.clk(aclk_1),
        .rs422_clk(axistreamtors422_0_rs422_clk),
        .rs422_cs(axistreamtors422_0_rs422_cs),
        .rs422_data(axistreamtors422_0_rs422_data),
        .rstn(aresetn_1),
        .tdata(axis_dwidth_converter_0_M_AXIS_TDATA),
        .tlast(axis_dwidth_converter_0_M_AXIS_TLAST),
        .tready(axis_dwidth_converter_0_M_AXIS_TREADY),
        .tvalid(axis_dwidth_converter_0_M_AXIS_TVALID));
endmodule
