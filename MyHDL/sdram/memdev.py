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
from SDRAM_Controller.clkdiv import divclkby2 

@block
def memory_test(clk_i, reset_i, status_o, led_status,  host_intf ):

	#MAX_ADDRESS = 0x000FF
	#for simulation the is made smaller
	MAX_ADDRESS = 0xFFFFFF
	address = Signal(intbv(0)[len(host_intf.addr_i)+3:])
	wr_enable = Signal(bool(0))
	rd_enable = Signal(bool(0))
	rand_enable = Signal(bool(0))
	rand_load = Signal(bool(0))
	rand_seed = 42
	rand_val = Signal(intbv(0)[len(host_intf.data_i):])
 	error = Signal(bool(False))
	 
	 
	testState = enum('INIT', 'WRITE', 'VERIFY', 'SHOW_RESULT')
	test_state = Signal(testState.INIT)
	
	rand_gen = uniform_rand_gen(clk_i, rand_enable, rand_load, rand_seed, rand_val)

	@always_seq(clk_i.posedge, reset=None)
	def sdram_tester():
		if reset_i == True:
				error.next = False
 				test_state.next = testState.WRITE
				status_o.next = intbv(ord("1"),0,256)
  				led_status.next = intbv('0001')[4:0]
				address.next = 0
				rand_load.next = 1 
		elif test_state == testState.WRITE:
				rand_load.next = 0
				rand_enable.next = 0
				status_o.next = intbv(ord("2"),0,256)
 				led_status.next = intbv('0010')[4:0]
				if host_intf.done_o == False:
				    wr_enable.next = True
				else:
				    wr_enable.next = False
				    rand_enable.next = 1
				    address.next = address + 1
 				    if address == MAX_ADDRESS:
				        test_state.next = testState.VERIFY
				        address.next = 0
				        rand_load.next = 1
				        error.next = False
		elif test_state == testState.VERIFY:
				rand_load.next = 0
				rand_enable.next = 0
				status_o.next = intbv(ord("3"),0,256)
 				led_status.next = intbv('0100')[4:0]
				if host_intf.done_o == False:
				    rd_enable.next = True
				else:
				    rd_enable.next = False
				    rand_enable.next = 1						
				    address.next = address + 1
				    if rand_val != host_intf.data_o:
				        error.next = True
				    if address == MAX_ADDRESS:
				        test_state.next = testState.SHOW_RESULT
		else:
				rand_load.next = 0
				rand_enable.next = 0
				if error == True:
				    status_o.next = intbv(ord("F"),0,256)
 				else:
					status_o.next = intbv(ord("O"),0,256)
					led_status.next = intbv('1111')[4:0]
 
	@always_comb
	def host_connections():
		host_intf.rst_i.next = reset_i
		host_intf.wr_i.next = wr_enable and not host_intf.done_o
		host_intf.rd_i.next = rd_enable and not host_intf.done_o
		host_intf.data_i.next = rand_val
		host_intf.addr_i.next = address

	return instances()

@block
def memdev(master_clk_i, sdram_clk_o, sdram_clk_i, led_status, pb_i, sd_intf):
	
	
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
	host_intf_inst = host_intf()
	memory_test_inst = memory_test(clk, reset, test_status, led_status, host_intf_inst)
	
	sdramCntl_inst = SdramCntl(clk, host_intf_inst, sd_intf)
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
def memdev_tb():
	clk, sdram_clk, sdram_return_clk  = [Signal(bool(0)) for _ in range(3)]
 
	@always_comb
	def sdram_clk_loopback():
		sdram_return_clk.next = sdram_clk

	#drvrs = [TristateSignal(bool(0)) for _ in range(8)]
	led_status = Signal(intbv(0,0,16))
	pb = Signal(bool(1))
	sd_intf_inst = sd_intf()
	sdram_inst = sdram(sdram_clk, sd_intf_inst, show_command=False)
	dut = memdev(clk, sdram_clk, sdram_return_clk, led_status, pb, sd_intf_inst)

	@instance
	def clk_gen():
		
		yield delay(140)
		for _ in range(14000):
				clk.next = not clk
				yield delay(1)
		pb.next = 0
		for _ in range(100):
				clk.next = not clk
				yield delay(1)
		pb.next = 1

		for _ in range(26000):
				clk.next = not clk
				yield delay(1)
		raise StopSimulation

	return instances()

@block
def top(clk100MHz, sdram_clk, sdram_return_clk, led_status, pb, sd_intf_inst):
	clk50MHz = Signal(bool(0))
	reset = Signal(bool(False))
	divclkby2_0 = divclkby2(clk100MHz,clk50MHz)
	
 	test_status = Signal(intbv(0)[8:])
	host_intf_inst = host_intf()
 	memdev_inst = memdev(clk50MHz, sdram_clk, sdram_return_clk, led_status, pb, sd_intf_inst)
	#memdev_inst.convert()
	return instances()


if __name__ == '__main__':
 
 
	clk, sdram_clk, sdram_return_clk = [Signal(bool(0)) for _ in range(3)]
 
	led_status = Signal(intbv(0,0,16))
	pb = Signal(bool(1))
	clk50MHz = Signal(bool(0))
	clk100MHz = Signal(bool(0))

	 
	sd_intf_inst = sd_intf()
	top_inst = top(clk100MHz, sdram_clk, sdram_return_clk, led_status, pb, sd_intf_inst)
	top_inst.convert(hdl="Verilog", initial_values=False)
	"""
	memdev_inst = memdev(clk, sdram_clk, sdram_return_clk, led_status, pb, sd_intf_inst)
	memdev_inst.convert(hdl="Verilog", initial_values=False)
	
	tb = sdram_test_tb()
	tb.config_sim(trace=True)
	tb.run_sim()
	"""
	"""
	tb = memdev_tb()
	tb.config_sim(trace=True)
	tb.run_sim()
	"""
	
	
	
	
	
	
	
	
	

	
	

	
