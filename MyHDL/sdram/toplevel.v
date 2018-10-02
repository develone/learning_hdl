////////////////////////////////////////////////////////////////////////////////
//
// Filename:	./toplevel.v
//
// Project:	ICO Zip, iCE40 ZipCPU demonstration project
//
// DO NOT EDIT THIS FILE!
// Computer Generated: This file is computer generated by AUTOFPGA. DO NOT EDIT.
// DO NOT EDIT THIS FILE!
//
// CmdLine:	autofpga autofpga -o . global.txt bkram.txt buserr.txt clock50.txt pic.txt pwrcount.txt version.txt hbconsole.txt gpio.txt dlyarbiter.txt zipbones.txt sdramdev.txt
//
// Creator:	Dan Gisselquist, Ph.D.
//		Gisselquist Technology, LLC
//
////////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2017, Gisselquist Technology, LLC
//
// This program is free software (firmware): you can redistribute it and/or
// modify it under the terms of  the GNU General Public License as published
// by the Free Software Foundation, either version 3 of the License, or (at
// your option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTIBILITY or
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
// for more details.
//
// You should have received a copy of the GNU General Public License along
// with this program.  (It's in the $(ROOT)/doc directory.  Run make with no
// target there if the PDF file isn't present.)  If not, see
// <http://www.gnu.org/licenses/> for a copy.
//
// License:	GPL, v3, as defined and found on www.gnu.org,
//		http://www.gnu.org/licenses/gpl.html
//
//
////////////////////////////////////////////////////////////////////////////////
//
//
`default_nettype	none


//
// Here we declare our toplevel.v (toplevel) design module.
// All design logic must take place beneath this top level.
//
// The port declarations just copy data from the @TOP.PORTLIST
// key, or equivalently from the @MAIN.PORTLIST key if
// @TOP.PORTLIST is absent.  For those peripherals that don't need
// any top level logic, the @MAIN.PORTLIST should be sufficent,
// so the @TOP.PORTLIST key may be left undefined.
//
module	toplevel(i_clk,
    sdram_clk,
    sdram_return_clk,
    sd_intf_cke,
    sd_intf_we,
    sd_intf_addr,
    sd_intf_dqml,
    sd_intf_cas,
    sd_intf_dqmh,
    sd_intf_ras,
    sd_intf_bs,
    sd_intf_cs,
    sd_intf_dq,
		// GPIO wires
		o_ledg, o_ledr, i_btn,
		// Parallel port to wishbone / console interface
		i_pp_dir, i_pp_clk, io_pp_data, o_pp_clkfb,
		o_dbgwires);
	//
	// Declaring our input and output ports.  We listed these above,
	// now we are declaring them here.
	//
	// These declarations just copy data from the @TOP.IODECLS key,
	// or from the @MAIN.IODECL key if @TOP.IODECL is absent.  For
	// those peripherals that don't do anything at the top level,
	// the @MAIN.IODECL key should be sufficient, so the @TOP.IODECL
	// key may be left undefined.
	//
	input	wire		i_clk;
output sdram_clk;
wire sdram_clk;
input sdram_return_clk;
output sd_intf_cke;
reg sd_intf_cke;
output sd_intf_we;
reg sd_intf_we;
output [12:0] sd_intf_addr;
reg [12:0] sd_intf_addr;
output sd_intf_dqml;
reg sd_intf_dqml;
output sd_intf_cas;
reg sd_intf_cas;
output sd_intf_dqmh;
reg sd_intf_dqmh;
output sd_intf_ras;
reg sd_intf_ras;
output [1:0] sd_intf_bs;
reg [1:0] sd_intf_bs;
output sd_intf_cs;
reg sd_intf_cs;
inout [15:0] sd_intf_dq;
wire [15:0] sd_intf_dq;
 
wire i_wb_we;
wire i_wb_stb;
wire pb;
wire i_wb_cyc;
wire [3:0] i_wb_sel;
reg o_wb_ack;
reg o_wb_stall;
wire [15:0] o_wb_data;
wire [15:0] i_wb_data;
reg maincat0_pb_prev;
reg maincat0_pb_debounced;
reg maincat0_initialized;
reg [5:0] maincat0_debounce_cntr;
wire maincat0_clk;
wire maincat0_reset;
wire maincat0_wbfsm_host_intf_done_o;
reg maincat0_wbfsm_rand_load;
reg maincat0_wbfsm_rand_enable;
wire maincat0_wbfsm_host_intf_wr_i;
reg maincat0_wbfsm_rd_enable;
wire [15:0] maincat0_wbfsm_rand_val;
wire [15:0] maincat0_wbfsm_host_intf_data_i;
wire [15:0] maincat0_wbfsm_host_intf_data_o;
reg [1:0] maincat0_wbfsm_test_state;
reg [26:0] maincat0_wbfsm_address;
wire maincat0_wbfsm_host_intf_rst_i;
wire maincat0_wbfsm_host_intf_rd_i;
reg maincat0_wbfsm_wr_enable;
reg maincat0_wbfsm_error;
wire [23:0] maincat0_wbfsm_host_intf_addr_i;
reg [15:0] maincat0_wbfsm_data_delay0_0_tmpdata1;
reg [15:0] maincat0_wbfsm_data_delay0_0_tmpdata;
reg [2:0] maincat0_SdramCntl0_cmd_r;
reg [12:0] maincat0_SdramCntl0_sAddr_x;
reg [2:0] maincat0_SdramCntl0_cmd_x;
reg [1:0] maincat0_SdramCntl0_activeBank_r;
reg [12:0] maincat0_SdramCntl0_sAddr_r;
reg [15:0] maincat0_SdramCntl0_sdramData_x;
reg maincat0_SdramCntl0_activateInProgress_s;
reg maincat0_SdramCntl0_sDataDir_x;
reg maincat0_SdramCntl0_sDataDir_r;
wire [1:0] maincat0_SdramCntl0_ba_x;
reg [4:0] maincat0_SdramCntl0_rdPipeline_r;
wire [12:0] maincat0_SdramCntl0_row_s;
reg [13:0] maincat0_SdramCntl0_rfshCntr_x;
reg [1:0] maincat0_SdramCntl0_ba_r;
reg [4:0] maincat0_SdramCntl0_rdPipeline_x;
reg [13:0] maincat0_SdramCntl0_rfshCntr_r;
reg [15:0] maincat0_SdramCntl0_sDriver;
reg [1:0] maincat0_SdramCntl0_activeBank_x;
reg maincat0_SdramCntl0_doActivate_s;
wire [1:0] maincat0_SdramCntl0_bank_s;
reg [8:0] maincat0_SdramCntl0_refTimer_r;
reg maincat0_SdramCntl0_rdInProgress_s;
reg [8:0] maincat0_SdramCntl0_refTimer_x;
reg maincat0_SdramCntl0_writeInProgress_s;
reg [2:0] maincat0_SdramCntl0_state_x;
reg [15:0] maincat0_SdramCntl0_sData_r;
wire [8:0] maincat0_SdramCntl0_col_s;
reg [2:0] maincat0_SdramCntl0_state_r;
wire [15:0] maincat0_SdramCntl0_sData_x;
reg [9:0] maincat0_SdramCntl0_timer_x;
reg [4:0] maincat0_SdramCntl0_wrPipeline_x;
reg [1:0] maincat0_SdramCntl0_wrTimer_x;
reg [4:0] maincat0_SdramCntl0_wrPipeline_r;
reg [15:0] maincat0_SdramCntl0_sdramData_r;
reg [1:0] maincat0_SdramCntl0_wrTimer_r;
reg [9:0] maincat0_SdramCntl0_timer_r;
reg [1:0] maincat0_SdramCntl0_rasTimer_x;
reg [1:0] maincat0_SdramCntl0_rasTimer_r;
reg [12:0] maincat0_SdramCntl0_activeRow_x [0:4-1];
reg [12:0] maincat0_SdramCntl0_activeRow_r [0:4-1];
reg maincat0_SdramCntl0_activeFlag_x [0:4-1];
reg maincat0_SdramCntl0_activeFlag_r [0:4-1];
	// GPIO wires
	output	wire	[1:0]	o_ledg;
	output	wire		o_ledr;
	input	wire	[1:0]	i_btn;
	// Parallel port to wishbone / console interface
	input	wire		i_pp_dir, i_pp_clk;
	inout	wire	[7:0]	io_pp_data;
	output	wire		o_pp_clkfb;
	output	wire	[7:0]	o_dbgwires;


	//
	// Declaring component data, internal wires and registers
	//
	// These declarations just copy data from the @TOP.DEFNS key
	// within the component data files.
	//
	// GPIO declarations.  The two wire busses are just virtual lists of
	// input (or output) ports.
	wire	[2 -1:0]	i_gpio;
	wire	[11-1:0]	o_gpio;
	wire		s_clk, s_reset;
	//
	//
	// Parallel port interface
	//
	//
	wire	[7:0]	i_pp_data, w_pp_data;
	wire		w_pp_dbg;



	//
	// Time to call the main module within main.v.  Remember, the purpose
	// of the main.v module is to contain all of our portable logic.
	// Things that are Xilinx (or even Altera) specific, or for that
	// matter anything that requires something other than on-off logic,
	// such as the high impedence states required by many wires, is
	// kept in this (toplevel.v) module.  Everything else goes in
	// main.v.
	//
	// We automatically place s_clk, and s_reset here.  You may need
	// to define those above.  (You did, didn't you?)  Other
	// component descriptions come from the keys @TOP.MAIN (if it
	// exists), or @MAIN.PORTLIST if it does not.
	//

	main	thedesign(s_clk, s_reset,
		// GPIO wires
		i_gpio, o_gpio,
		// External USB-UART bus control
		i_pp_clk, i_pp_dir, i_pp_data, w_pp_data, o_pp_clkfb, w_pp_dbg);


	//
	// Our final section to the toplevel is used to provide all of
	// that special logic that couldnt fit in main.  This logic is
	// given by the @TOP.INSERT tag in our data files.
	//


	assign	i_gpio = { i_btn };
	assign	o_ledr = o_gpio[0];
	assign	o_ledg = o_gpio[2:1];

	assign	s_reset = 1'b0; // This design requires local, not global resets

`ifdef	VERILATOR
	assign	s_clk = i_clk;
`else
	reg	clk_50mhz;

	initial	clk_50mhz = 1'b0;
	always @(posedge i_clk)
		clk_50mhz <= !clk_50mhz;
	SB_GB global_buffer(clk_50mhz, s_clk);
`endif


	//
	// Parallel port I/O pin control
	ppio	hbi_io(i_pp_dir, io_pp_data, w_pp_data, i_pp_data);

	assign	o_dbgwires = { i_pp_dir, i_pp_clk, o_pp_clkfb,
				w_pp_dbg, i_pp_data[3:0] };




endmodule // end of toplevel.v module definition
