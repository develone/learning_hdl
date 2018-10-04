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
	sdramdev_SdramCntl0_sd_intf_cke,
	sdramdev_SdramCntl0_sd_intf_we,
	sdramdev_SdramCntl0_sd_intf_addr,
	sdramdev_SdramCntl0_sd_intf_dqml,
	sdramdev_SdramCntl0_sd_intf_cas,
	sdramdev_SdramCntl0_sd_intf_dqmh,
	sdramdev_SdramCntl0_sd_intf_ras,
	sdramdev_SdramCntl0_sd_intf_bs,
	sdramdev_SdramCntl0_sd_intf_cs,
	sdramdev_SdramCntl0_sd_intf_dq,
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
	output sdramdev_SdramCntl0_sd_intf_cke;
	reg sdramdev_SdramCntl0_sd_intf_cke;
	output sdramdev_SdramCntl0_sd_intf_we;
	reg sdramdev_SdramCntl0_sd_intf_we;
	output [12:0] sdramdev_SdramCntl0_sd_intf_addr;
	reg [12:0] sdramdev_SdramCntl0_sd_intf_addr;
	output sdramdev_SdramCntl0_sd_intf_dqml;
	reg sdramdev_SdramCntl0_sd_intf_dqml;
	output sdramdev_SdramCntl0_sd_intf_cas;
	reg sdramdev_SdramCntl0_sd_intf_cas;
	output sdramdev_SdramCntl0_sd_intf_dqmh;
	reg sdramdev_SdramCntl0_sd_intf_dqmh;
	output sdramdev_SdramCntl0_sd_intf_ras;
	reg sdramdev_SdramCntl0_sd_intf_ras;
	output [1:0] sdramdev_SdramCntl0_sd_intf_bs;
	reg [1:0] sdramdev_SdramCntl0_sd_intf_bs;
	output sdramdev_SdramCntl0_sd_intf_cs;
	reg sdramdev_SdramCntl0_sd_intf_cs;
	inout [15:0] sdramdev_SdramCntl0_sd_intf_dq;
	wire [15:0] sdramdev_SdramCntl0_sd_intf_dq;

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
,
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
