// Chip-level wrapper for ibex_top with I/O pads
// Pads instantiated INSIDE, ports are actual chip I/O

module ibex_wrap (
  // LEFT SIDE - Actual chip I/O pins
  input  wire clk,
  input  wire rst_n,
  input  wire scan_rst_n,
  input  wire test_en,
  input  wire debug_req,
  input  wire fetch_enable_0,
  output wire instr_req,
  input  wire instr_gnt,
  input  wire instr_rvalid,
  input  wire instr_err,
  output wire core_sleep,
  output wire alert_minor,
  
  // BOTTOM SIDE - Instruction address/data
  output wire instr_addr_0,
  output wire instr_addr_1,
  output wire instr_addr_2,
  output wire instr_addr_3,
  output wire instr_addr_4,
  output wire instr_addr_5,
  input  wire instr_rdata_0,
  input  wire instr_rdata_1,
  input  wire instr_rdata_2,
  input  wire instr_rdata_3,
  input  wire instr_rdata_4,
  input  wire instr_rdata_5,
  
  // RIGHT SIDE - Data memory interface
  output wire data_req,
  input  wire data_gnt,
  input  wire data_rvalid,
  output wire data_we,
  input  wire data_err,
  output wire data_addr_0,
  output wire data_addr_1,
  output wire data_addr_2,
  output wire data_addr_3,
  output wire data_addr_4,
  output wire data_addr_5,
  output wire data_addr_6,
  
  // TOP SIDE - Data read/write + interrupts
  input  wire data_rdata_0,
  input  wire data_rdata_1,
  input  wire data_rdata_2,
  input  wire data_rdata_3,
  output wire data_wdata_0,
  output wire data_wdata_1,
  output wire data_wdata_2,
  output wire data_wdata_3,
  input  wire irq_software,
  input  wire irq_timer,
  input  wire irq_external,
  input  wire irq_nm
);

//============================================================================
// Internal signals (chip side of pads)
//============================================================================
(* keep = "true" *) logic clk_i;
(* keep = "true" *) logic rst_ni;
(* keep = "true" *) logic scan_rst_ni;
(* keep = "true" *) logic test_en_i;
(* keep = "true" *) logic debug_req_i;
(* keep = "true" *) logic fetch_enable_i_0;

logic instr_req_o;
logic instr_gnt_i;
logic instr_rvalid_i;
logic instr_err_i;
logic [5:0] instr_addr_o_low;
logic [5:0] instr_rdata_i_low;

logic data_req_o;
logic data_gnt_i;
logic data_rvalid_i;
logic data_we_o;
logic data_err_i;
logic [6:0] data_addr_o_low;
logic [3:0] data_rdata_i_low;
logic [3:0] data_wdata_o_low;

(* keep = "true" *) logic irq_software_i;
(* keep = "true" *) logic irq_timer_i;
(* keep = "true" *) logic irq_external_i;
(* keep = "true" *) logic irq_nm_i;

logic core_sleep_o;
logic alert_minor_o;

  //============================================================================
  // I/O PAD INSTANTIATIONS - LEFT SIDE
  //============================================================================
  
  sg13g2_IOPadIn pad_clk_inst (
    .pad(clk),
    .p2c(clk_i)
  );
  
  sg13g2_IOPadIn pad_rst_ni_inst (
    .pad(rst_n),
    .p2c(rst_ni)
  );
  
  sg13g2_IOPadIn pad_scan_rst_ni_inst (
    .pad(scan_rst_n),
    .p2c(scan_rst_ni)
  );
  
  sg13g2_IOPadIn pad_test_en_i_inst (
    .pad(test_en),
    .p2c(test_en_i)
  );
  
  sg13g2_IOPadIn pad_debug_req_i_inst (
    .pad(debug_req),
    .p2c(debug_req_i)
  );
  
  sg13g2_IOPadIn pad_fetch_enable_i_0_inst (
    .pad(fetch_enable_0),
    .p2c(fetch_enable_i_0)
  );
  
  sg13g2_IOPadOut4mA pad_instr_req_o_inst (
    .pad(instr_req),
    .c2p(instr_req_o)
  );
  
  sg13g2_IOPadIn pad_instr_gnt_i_inst (
    .pad(instr_gnt),
    .p2c(instr_gnt_i)
  );
  
  sg13g2_IOPadIn pad_instr_rvalid_i_inst (
    .pad(instr_rvalid),
    .p2c(instr_rvalid_i)
  );
  
  sg13g2_IOPadIn pad_instr_err_i_inst (
    .pad(instr_err),
    .p2c(instr_err_i)
  );
  
  sg13g2_IOPadOut4mA pad_core_sleep_o_inst (
    .pad(core_sleep),
    .c2p(core_sleep_o)
  );
  
  sg13g2_IOPadOut4mA pad_alert_minor_o_inst (
    .pad(alert_minor),
    .c2p(alert_minor_o)
  );

  //============================================================================
  // BOTTOM SIDE PADS - Instruction address/data
  //============================================================================
  
  sg13g2_IOPadOut4mA pad_instr_addr_o_0_inst (
    .pad(instr_addr_0),
    .c2p(instr_addr_o_low[0])
  );
  
  sg13g2_IOPadOut4mA pad_instr_addr_o_1_inst (
    .pad(instr_addr_1),
    .c2p(instr_addr_o_low[1])
  );
  
  sg13g2_IOPadOut4mA pad_instr_addr_o_2_inst (
    .pad(instr_addr_2),
    .c2p(instr_addr_o_low[2])
  );
  
  sg13g2_IOPadOut4mA pad_instr_addr_o_3_inst (
    .pad(instr_addr_3),
    .c2p(instr_addr_o_low[3])
  );
  
  sg13g2_IOPadOut4mA pad_instr_addr_o_4_inst (
    .pad(instr_addr_4),
    .c2p(instr_addr_o_low[4])
  );
  
  sg13g2_IOPadOut4mA pad_instr_addr_o_5_inst (
    .pad(instr_addr_5),
    .c2p(instr_addr_o_low[5])
  );
  
  sg13g2_IOPadIn pad_instr_rdata_i_0_inst (
    .pad(instr_rdata_0),
    .p2c(instr_rdata_i_low[0])
  );
  
  sg13g2_IOPadIn pad_instr_rdata_i_1_inst (
    .pad(instr_rdata_1),
    .p2c(instr_rdata_i_low[1])
  );
  
  sg13g2_IOPadIn pad_instr_rdata_i_2_inst (
    .pad(instr_rdata_2),
    .p2c(instr_rdata_i_low[2])
  );
  
  sg13g2_IOPadIn pad_instr_rdata_i_3_inst (
    .pad(instr_rdata_3),
    .p2c(instr_rdata_i_low[3])
  );
  
  sg13g2_IOPadIn pad_instr_rdata_i_4_inst (
    .pad(instr_rdata_4),
    .p2c(instr_rdata_i_low[4])
  );
  
  sg13g2_IOPadIn pad_instr_rdata_i_5_inst (
    .pad(instr_rdata_5),
    .p2c(instr_rdata_i_low[5])
  );

  //============================================================================
  // RIGHT SIDE PADS - Data memory interface
  //============================================================================
  
  sg13g2_IOPadOut4mA pad_data_req_o_inst (
    .pad(data_req),
    .c2p(data_req_o)
  );
  
  sg13g2_IOPadIn pad_data_gnt_i_inst (
    .pad(data_gnt),
    .p2c(data_gnt_i)
  );
  
  sg13g2_IOPadIn pad_data_rvalid_i_inst (
    .pad(data_rvalid),
    .p2c(data_rvalid_i)
  );
  
  sg13g2_IOPadOut4mA pad_data_we_o_inst (
    .pad(data_we),
    .c2p(data_we_o)
  );
  
  sg13g2_IOPadIn pad_data_err_i_inst (
    .pad(data_err),
    .p2c(data_err_i)
  );
  
  sg13g2_IOPadOut4mA pad_data_addr_o_0_inst (
    .pad(data_addr_0),
    .c2p(data_addr_o_low[0])
  );
  
  sg13g2_IOPadOut4mA pad_data_addr_o_1_inst (
    .pad(data_addr_1),
    .c2p(data_addr_o_low[1])
  );
  
  sg13g2_IOPadOut4mA pad_data_addr_o_2_inst (
    .pad(data_addr_2),
    .c2p(data_addr_o_low[2])
  );
  
  sg13g2_IOPadOut4mA pad_data_addr_o_3_inst (
    .pad(data_addr_3),
    .c2p(data_addr_o_low[3])
  );
  
  sg13g2_IOPadOut4mA pad_data_addr_o_4_inst (
    .pad(data_addr_4),
    .c2p(data_addr_o_low[4])
  );
  
  sg13g2_IOPadOut4mA pad_data_addr_o_5_inst (
    .pad(data_addr_5),
    .c2p(data_addr_o_low[5])
  );
  
  sg13g2_IOPadOut4mA pad_data_addr_o_6_inst (
    .pad(data_addr_6),
    .c2p(data_addr_o_low[6])
  );

  //============================================================================
  // TOP SIDE PADS - Data read/write + interrupts
  //============================================================================
  
  sg13g2_IOPadIn pad_data_rdata_i_0_inst (
    .pad(data_rdata_0),
    .p2c(data_rdata_i_low[0])
  );
  
  sg13g2_IOPadIn pad_data_rdata_i_1_inst (
    .pad(data_rdata_1),
    .p2c(data_rdata_i_low[1])
  );
  
  sg13g2_IOPadIn pad_data_rdata_i_2_inst (
    .pad(data_rdata_2),
    .p2c(data_rdata_i_low[2])
  );
  
  sg13g2_IOPadIn pad_data_rdata_i_3_inst (
    .pad(data_rdata_3),
    .p2c(data_rdata_i_low[3])
  );
  
  sg13g2_IOPadOut4mA pad_data_wdata_o_0_inst (
    .pad(data_wdata_0),
    .c2p(data_wdata_o_low[0])
  );
  
  sg13g2_IOPadOut4mA pad_data_wdata_o_1_inst (
    .pad(data_wdata_1),
    .c2p(data_wdata_o_low[1])
  );
  
  sg13g2_IOPadOut4mA pad_data_wdata_o_2_inst (
    .pad(data_wdata_2),
    .c2p(data_wdata_o_low[2])
  );
  
  sg13g2_IOPadOut4mA pad_data_wdata_o_3_inst (
    .pad(data_wdata_3),
    .c2p(data_wdata_o_low[3])
  );
  
  sg13g2_IOPadIn pad_irq_software_i_inst (
    .pad(irq_software),
    .p2c(irq_software_i)
  );
  
  sg13g2_IOPadIn pad_irq_timer_i_inst (
    .pad(irq_timer),
    .p2c(irq_timer_i)
  );
  
  sg13g2_IOPadIn pad_irq_external_i_inst (
    .pad(irq_external),
    .p2c(irq_external_i)
  );
  
  sg13g2_IOPadIn pad_irq_nm_i_inst (
    .pad(irq_nm),
    .p2c(irq_nm_i)
  );

  //============================================================================
  // POWER PADS (no ports, just instantiated)
  //============================================================================
  
  (* keep = "true" *) sg13g2_IOPadVdd pad_vdd0();
  (* keep = "true" *) sg13g2_IOPadVdd pad_vdd1();
  (* keep = "true" *) sg13g2_IOPadVdd pad_vdd2();
  (* keep = "true" *) sg13g2_IOPadVdd pad_vdd3();
  (* keep = "true" *) sg13g2_IOPadVss pad_vss0();
  (* keep = "true" *) sg13g2_IOPadVss pad_vss1();
  (* keep = "true" *) sg13g2_IOPadVss pad_vss2();
  (* keep = "true" *) sg13g2_IOPadVss pad_vss3();
  (* keep = "true" *) sg13g2_IOPadIOVdd pad_vddio0();
  (* keep = "true" *) sg13g2_IOPadIOVdd pad_vddio1();
  (* keep = "true" *) sg13g2_IOPadIOVdd pad_vddio2();
  (* keep = "true" *) sg13g2_IOPadIOVdd pad_vddio3();
  (* keep = "true" *) sg13g2_IOPadIOVss pad_vssio0();
  (* keep = "true" *) sg13g2_IOPadIOVss pad_vssio1();
  (* keep = "true" *) sg13g2_IOPadIOVss pad_vssio2();
  (* keep = "true" *) sg13g2_IOPadIOVss pad_vssio3();

  //============================================================================
  // IBEX CORE INSTANTIATION
  //============================================================================
  
  // Tie-off unused ports
  logic [31:0] hart_id_tied = 32'h0;
  logic [31:0] boot_addr_tied = 32'h0000_0000;
  logic [31:0] instr_addr_full;
  logic [31:0] instr_rdata_full;
  logic [31:0] data_addr_full;
  logic [31:0] data_rdata_full;
  logic [31:0] data_wdata_full;
  
  // Extend low bits to full width
  assign instr_addr_full = {26'b0, instr_addr_o_low};
  assign instr_rdata_full = {26'b0, instr_rdata_i_low};
  assign data_addr_full = {25'b0, data_addr_o_low};
  assign data_rdata_full = {28'b0, data_rdata_i_low};
  assign data_wdata_o_low = data_wdata_full[3:0];
  
  ibex_top #(
    .PMPEnable(1'b0),
    .PMPGranularity(0),
    .PMPNumRegions(4),
    .MHPMCounterNum(0),
    .MHPMCounterWidth(40),
    .RV32E(1'b0),
    .RV32M(ibex_pkg::RV32MSingleCycle),
    .RV32B(ibex_pkg::RV32BNone),
    .RegFile(ibex_pkg::RegFileFF),
    .BranchTargetALU(1'b0),
    .WritebackStage(1'b0),
    .ICache(1'b0),
    .ICacheECC(1'b0),
    .BranchPredictor(1'b0),
    .DbgTriggerEn(1'b0),
    .DbgHwBreakNum(1),
    .SecureIbex(1'b0)
  ) u_ibex_top (
    .clk_i(clk_i),
    .rst_ni(rst_ni),
    .test_en_i(test_en_i),
    .scan_rst_ni(scan_rst_ni),
    .ram_cfg_i('0),
    
    .hart_id_i(hart_id_tied),
    .boot_addr_i(boot_addr_tied),
    
    // Instruction memory interface
    .instr_req_o(instr_req_o),
    .instr_gnt_i(instr_gnt_i),
    .instr_rvalid_i(instr_rvalid_i),
    .instr_addr_o(instr_addr_full),
    .instr_rdata_i(instr_rdata_full),
    .instr_rdata_intg_i(7'b0),
    .instr_err_i(instr_err_i),
    
    // Data memory interface
    .data_req_o(data_req_o),
    .data_gnt_i(data_gnt_i),
    .data_rvalid_i(data_rvalid_i),
    .data_we_o(data_we_o),
    .data_be_o(),
    .data_addr_o(data_addr_full),
    .data_wdata_o(data_wdata_full),
    .data_wdata_intg_o(),
    .data_rdata_i(data_rdata_full),
    .data_rdata_intg_i(7'b0),
    .data_err_i(data_err_i),
    
    // Interrupts
    .irq_software_i(irq_software_i),
    .irq_timer_i(irq_timer_i),
    .irq_external_i(irq_external_i),
    .irq_fast_i(15'b0),
    .irq_nm_i(irq_nm_i),
    
    // Scrambling (tied off)
    .scramble_key_valid_i(1'b0),
    .scramble_key_i('0),
    .scramble_nonce_i('0),
    .scramble_req_o(),
    
    // Debug
    .debug_req_i(debug_req_i),
    .crash_dump_o(),
    .double_fault_seen_o(),
    
    // CPU Control
    .fetch_enable_i({3'b0, fetch_enable_i_0}),
    .alert_minor_o(alert_minor_o),
    .alert_major_internal_o(),
    .alert_major_bus_o(),
    .core_sleep_o(core_sleep_o)
  );

endmodule
