# MIT license
# 
# Copyright (C) 2016 by XESS Corporation.
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

from myhdl import *

from SDRAM_Controller.SdramCntl import *
from SDRAM_Controller.sdram import *
from SDRAM_Controller.host_intf import *
from SDRAM_Controller.sd_intf import *
from rand_gen import uniform_rand_gen
from data_del import data_delay
from SDRAM_Controller.clkdiv import divclkby2 
 
@block
def sdramdevfsm(clk_i, reset_i,sd_intf, host_intf, i_wb_cyc, i_wb_stb, i_wb_we, \
	i_wb_addr, i_wb_data, o_wb_ack, o_wb_stall, o_wb_data, i_wb_sel ):
 
	address = Signal(intbv(0)[len(host_intf.addr_i)+3:])
	wr_enable = Signal(bool(0))
	rd_enable = Signal(bool(0))
	rand_enable = Signal(bool(0))
	rand_load = Signal(bool(0))
	rand_seed = 42
	rand_val = Signal(intbv(0)[len(host_intf.data_i):])
 	error = Signal(bool(False))
	 
	 
	testState = enum('INIT', 'WRITE', 'SHOW_RESULT')
	test_state = Signal(testState.INIT)
	
	#rand_gen = uniform_rand_gen(clk_i, rand_enable, rand_load, rand_seed, rand_val)
	data_delay_inst = data_delay(clk_i, rand_enable, rand_load, i_wb_data, rand_val)

	@always_seq(clk_i.posedge, reset=None)
	def sdram_fsm():
		if reset_i == True:
			error.next = False
 			test_state.next = testState.WRITE

		
		elif test_state == testState.WRITE:
			
			rand_load.next = 1
			"""
			Load the data_i into tmpdata
			"""
			"""
			this is the write & read req using wb
			i_wb_stb & i_wb_we is 1 is a write
			i_wb_stb & i_wb_we is 0 is a read
			"""
			if ((i_wb_cyc == 1)and(i_wb_sel==15)):
				o_wb_stall.next = 1
				o_wb_ack.next = 0

				"""
				this is the write req from wb
				i_wb_we is 1
				"""
				if(i_wb_we == 1):
					rand_load.next = 0
					address.next = i_wb_addr
					rand_enable.next = 1
					"""
					copy the the tmpdata which 
					is the data_i to tmpdata1
					"""
				else:
					"""
					this is the read req from wb
					"""
					address.next = i_wb_addr					
					"""				
					wait for read to be done
					"""
					if host_intf.done_o == 0:
						rd_enable.next = 1
					else:
						o_wb_stall.next = 0
						o_wb_ack.next = 1
						rd_enable.next = 0
						test_state.next = testState.SHOW_RESULT
				"""
				wait for write to be done
				"""
				if host_intf.done_o == 0:
					wr_enable.next = 1
					o_wb_stall.next = 1									
				else:
					o_wb_stall.next = 0
					o_wb_ack.next = 1
					wr_enable.next = 0
					rd_enable.next = 0
					rand_enable.next = 0
					rand_load.next = 1
					test_state.next = testState.SHOW_RESULT
			
						
					
					
 		else:
				rand_load.next = 1
				rand_enable.next = 0
				o_wb_ack.next = 0
				error.next = False
				if( i_wb_stb == 1):
					test_state.next = testState.WRITE

 
	@always_comb
	def host_connections():
		"""
		In this section data is transferred to host_intf
		"""
		host_intf.rst_i.next = reset_i
		host_intf.wr_i.next = wr_enable and not host_intf.done_o
		host_intf.rd_i.next = rd_enable and not host_intf.done_o
		host_intf.data_i.next = rand_val
		host_intf.addr_i.next = address
		o_wb_data.next = host_intf.data_o.next 

	return instances()


@block
def topsdcntl(master_clk_i, sdram_clk_o, sdram_clk_i, pb_i, \
sd_intf, host_intf_inst, i_wb_cyc, i_wb_stb, i_wb_we, i_wb_addr, i_wb_data, o_wb_ack, \
o_wb_stall, o_wb_data, i_wb_sel):	
	clk = Signal(bool(0))
 	
	@always_comb
	def clock_routing():
		sdram_clk_o.next = master_clk_i
		clk.next = sdram_clk_i
	
	initialized = Signal(bool(False))

	@always_seq(clk.posedge, reset=None)
	def internal_reset():
		if initialized == False:
				initialized.next = not initialized
				 

	# Get an internal version of the pushbutton signal and debounce it.
	pb, pb_prev, pb_debounced = [Signal(bool(0)) for _ in range(3)]
	#pb_inst = input_pin(pb_i, pb, pullup=True)
	#pb_debouncer = debouncer(clk, pb, pb_debounced, dbnc_window_g=0.01)
	DEBOUNCE_INTERVAL = int(49)
	debounce_cntr = Signal(intbv(DEBOUNCE_INTERVAL - 1, 0, DEBOUNCE_INTERVAL))

	@always_seq(clk.posedge, reset=None)
	def debounce_pb():
		if pb_i != pb_prev:
				debounce_cntr.next = DEBOUNCE_INTERVAL - 1
		else:
				if debounce_cntr == 0:
				    pb_debounced.next = pb_i
				    debounce_cntr.next = 1
				else:
				    debounce_cntr.next = debounce_cntr - 1
		pb_prev.next = pb_i

	reset = Signal(bool(False))

	@always_comb
	def reset_logic():
		# Reset if not initialized upon startup or if pushbutton is pressed (low).
		reset.next = not initialized or not pb_debounced

	test_status = Signal(intbv(0)[8:])
 	sdramdevfsm_inst = sdramdevfsm(clk, reset, sd_intf_inst, host_intf_inst, \
	i_wb_cyc, i_wb_stb, i_wb_we, i_wb_addr, i_wb_data, o_wb_ack, \
	o_wb_stall, o_wb_data , i_wb_sel)
 
	sdramCntl_inst = SdramCntl(clk, host_intf_inst, sd_intf)
	#sdramCntl_inst.convert()
 
	"""
	50MHz 20 nsec
	during a read
	5 clks to read
	6 clks in between address chg
	120 nsec

	during a write
	4 clks in between address chg
	4 clks in between data chg
	80 nsec	
	""" 	
	return instances()

@block    
def topsdcntl_tb():
	clk, sdram_clk, sdram_return_clk  = [Signal(bool(0)) for _ in range(3)]
	i_wb_cyc, i_wb_stb, i_wb_we,o_wb_ack, o_wb_stall = [Signal(bool(0)) for _ in range(5)]
	i_wb_data = Signal(intbv(0)[16:])
	o_wb_data = Signal(intbv(0)[16:])
	i_wb_addr = Signal(intbv(0)[32:])
	i_wb_sel = Signal(intbv(0)[4:])
	@always_comb
	def sdram_clk_loopback():
		sdram_return_clk.next = sdram_clk

	#drvrs = [TristateSignal(bool(0)) for _ in range(8)]
	#led_status = Signal(intbv(0,0,16))
	pb = Signal(bool(1))
	host_intf_inst = host_intf()
	sd_intf_inst = sd_intf()
	sdram_inst = sdram(sdram_clk, sd_intf_inst, show_command=False)
 	dut = topsdcntl(clk, sdram_clk, sdram_return_clk,  \
 	pb, sd_intf_inst,host_intf_inst,i_wb_cyc, i_wb_stb, i_wb_we, i_wb_addr, \
 	i_wb_data, o_wb_ack, o_wb_stall, o_wb_data, i_wb_sel)

	@instance
	def clk_gen():
		
		yield delay(140)
		
		for _ in range(2342):
			clk.next = not clk
			yield delay(1)
 
		i_wb_addr.next = 3000					
		i_wb_data.next = 1500
		i_wb_cyc.next = 1
		i_wb_sel.next = 15
		i_wb_stb.next = 1
		i_wb_we.next = 1
		for _ in range(2):
			clk.next = not clk
			yield delay(1)
		i_wb_stb.next = 0
 
		for _ in range(14):
			clk.next = not clk
			yield delay(1)
 
		i_wb_we.next = 0
		i_wb_cyc.next = 0
		i_wb_sel.next = 0
		"""
		for _ in range(100):
			clk.next = not clk
			yield delay(1)	
		i_wb_cyc.next = 1
		i_wb_sel.next = 15	
		i_wb_addr.next = 16777215
		i_wb_data.next = 65535
		for _ in range(20):
			clk.next = not clk
			yield delay(1)

		i_wb_stb.next = 1
		i_wb_we.next = 1
		for _ in range(16):
			clk.next = not clk
			yield delay(1)
		i_wb_stb.next = 0
		i_wb_we.next = 0
		i_wb_cyc.next = 0
		i_wb_sel.next = 0
		"""
		for _ in range(100):
			clk.next = not clk
			yield delay(1)	 

		i_wb_cyc.next = 1
		i_wb_sel.next = 15
		i_wb_addr.next = 3000		 
		for _ in range(20):
			clk.next = not clk
			yield delay(1)

		i_wb_stb.next = 1
		"""
		i_wb_stb needs to remain hi
		longer for reads to turn off
		the rd_enable
		""" 
		for _ in range(26):
			clk.next = not clk
			yield delay(1)
		i_wb_stb.next = 0
		i_wb_cyc.next = 0
		i_wb_sel.next = 0
		for _ in range(1000):
			clk.next = not clk
			yield delay(1)											
 
		raise StopSimulation

	return instances()

@block
def top(clk100MHz, sdram_clk, sdram_return_clk,  pb, sd_intf_inst):
#def top(clk100MHz, sdram_clk, sdram_return_clk,  pb, sd_intf_inst,host_int_inst):
	clk50MHz = Signal(bool(0))
	reset = Signal(bool(False))
	divclkby2_0 = divclkby2(clk100MHz,clk50MHz)
	
 	test_status = Signal(intbv(0)[8:])
	host_intf_inst = host_intf()
	i_wb_cyc, i_wb_stb, i_wb_we,o_wb_ack, o_wb_stall = [Signal(bool(0)) for _ in range(5)]
	i_wb_data = Signal(intbv(0)[16:])
	o_wb_data = Signal(intbv(0)[16:])
	i_wb_addr = Signal(intbv(0)[32:])
	i_wb_sel = Signal(intbv(0)[4:])
	
  	topsdcntl_inst = topsdcntl(clk50MHz, sdram_clk, sdram_return_clk, pb, \
 	sd_intf_inst, host_intf_inst, i_wb_cyc, i_wb_stb, i_wb_we, i_wb_addr, i_wb_data, \
 	o_wb_ack, o_wb_stall, o_wb_data, i_wb_sel)

 	"""
 	Only one topsdcntl_inst.convert() or sdramCntl_inst.convert()
 	can be uncommented at the same time
 	not both or the following error will occur
 	Signal has multiple drivers: host_intf_rst_i
 	"""
	topsdcntl_inst.convert()
	
	return instances()


if __name__ == '__main__':
 
 
	clk, sdram_clk, sdram_return_clk = [Signal(bool(0)) for _ in range(3)]
 
	 
	pb = Signal(bool(1))
	clk50MHz = Signal(bool(0))
	clk100MHz = Signal(bool(0))

	 
	sd_intf_inst = sd_intf()
	top_inst = top(clk100MHz, sdram_clk, sdram_return_clk, pb, sd_intf_inst)
	 
	top_inst.convert(hdl="Verilog", initial_values=False)
	
	"""
	The following three lines if uncommented with run the simulation and 
	create the vcd file
	"""
	
	"""
	tb = topsdcntl_tb()
	tb.config_sim(trace=True)
	tb.run_sim()
	"""
	
	
	
	
	
	
	
	
	
	
	

	
	

	