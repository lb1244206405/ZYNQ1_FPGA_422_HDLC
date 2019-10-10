//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
//Date        : Tue Dec 18 23:12:29 2018
//Host        : homepc running 64-bit major release  (build 9200)
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=2,numReposBlks=2,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (M_AXIS_tdata,
    M_AXIS_tkeep,
    M_AXIS_tlast,
    M_AXIS_tready,
    M_AXIS_tstrb,
    M_AXIS_tvalid,
    aclk,
    aresetn,
    rs422_clk,
    rs422_data,
    rs422_en);
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS, CLK_DOMAIN design_1_aclk, FREQ_HZ 10000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 1, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) output [31:0]M_AXIS_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TKEEP" *) output [3:0]M_AXIS_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TLAST" *) output M_AXIS_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TREADY" *) input M_AXIS_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TSTRB" *) output [3:0]M_AXIS_tstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TVALID" *) output M_AXIS_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ACLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ACLK, ASSOCIATED_BUSIF M_AXIS, ASSOCIATED_RESET aresetn, CLK_DOMAIN design_1_aclk, FREQ_HZ 10000000, PHASE 0.000" *) input aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.ARESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.ARESETN, POLARITY ACTIVE_LOW" *) input aresetn;
  input rs422_clk;
  input rs422_data;
  input rs422_en;

  wire aclk_1;
  wire aresetn_1;
  wire [31:0]axis_dwidth_converter_0_M_AXIS_TDATA;
  wire [3:0]axis_dwidth_converter_0_M_AXIS_TKEEP;
  wire axis_dwidth_converter_0_M_AXIS_TLAST;
  wire axis_dwidth_converter_0_M_AXIS_TREADY;
  wire [3:0]axis_dwidth_converter_0_M_AXIS_TSTRB;
  wire axis_dwidth_converter_0_M_AXIS_TVALID;
  wire rs422_clk_1;
  wire rs422_data_1;
  wire rs422_en_1;
  wire [7:0]rs422toaxistream_0_interface_axis_TDATA;
  wire rs422toaxistream_0_interface_axis_TLAST;
  wire rs422toaxistream_0_interface_axis_TREADY;
  wire rs422toaxistream_0_interface_axis_TVALID;

  assign M_AXIS_tdata[31:0] = axis_dwidth_converter_0_M_AXIS_TDATA;
  assign M_AXIS_tkeep[3:0] = axis_dwidth_converter_0_M_AXIS_TKEEP;
  assign M_AXIS_tlast = axis_dwidth_converter_0_M_AXIS_TLAST;
  assign M_AXIS_tstrb[3:0] = axis_dwidth_converter_0_M_AXIS_TSTRB;
  assign M_AXIS_tvalid = axis_dwidth_converter_0_M_AXIS_TVALID;
  assign aclk_1 = aclk;
  assign aresetn_1 = aresetn;
  assign axis_dwidth_converter_0_M_AXIS_TREADY = M_AXIS_tready;
  assign rs422_clk_1 = rs422_clk;
  assign rs422_data_1 = rs422_data;
  assign rs422_en_1 = rs422_en;
  design_1_axis_dwidth_converter_0_0 axis_dwidth_converter_0
       (.aclk(aclk_1),
        .aresetn(aresetn_1),
        .m_axis_tdata(axis_dwidth_converter_0_M_AXIS_TDATA),
        .m_axis_tkeep(axis_dwidth_converter_0_M_AXIS_TKEEP),
        .m_axis_tlast(axis_dwidth_converter_0_M_AXIS_TLAST),
        .m_axis_tready(axis_dwidth_converter_0_M_AXIS_TREADY),
        .m_axis_tstrb(axis_dwidth_converter_0_M_AXIS_TSTRB),
        .m_axis_tvalid(axis_dwidth_converter_0_M_AXIS_TVALID),
        .s_axis_tdata(rs422toaxistream_0_interface_axis_TDATA),
        .s_axis_tkeep(1'b1),
        .s_axis_tlast(rs422toaxistream_0_interface_axis_TLAST),
        .s_axis_tready(rs422toaxistream_0_interface_axis_TREADY),
        .s_axis_tstrb(1'b1),
        .s_axis_tvalid(rs422toaxistream_0_interface_axis_TVALID));
  design_1_rs422toaxistream_0_0 rs422toaxistream_0
       (.clk(aclk_1),
        .rs422_clk(rs422_clk_1),
        .rs422_data(rs422_data_1),
        .rs422_en(rs422_en_1),
        .rstn(aresetn_1),
        .tdata(rs422toaxistream_0_interface_axis_TDATA),
        .tlast(rs422toaxistream_0_interface_axis_TLAST),
        .tready(rs422toaxistream_0_interface_axis_TREADY),
        .tvalid(rs422toaxistream_0_interface_axis_TVALID));
endmodule
