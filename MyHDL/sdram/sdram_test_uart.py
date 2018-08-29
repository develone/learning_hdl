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
#from led_digits_display import *
#from simple_modules import *
#from ice40_primitives import *
from SDRAM_Controller.SdramCntl import *
from SDRAM_Controller.sdram import *
from SDRAM_Controller.host_intf import *
from SDRAM_Controller.sd_intf import *
from rand_gen import uniform_rand_gen

#from SDRAM_Controller.uart_rx import uart_rx, t_state_rx

from SDRAM_Controller.uart_tx import uart_tx, t_state_tx
from SDRAM_Controller.forceHi import forceHi
 

@block
def memory_test(clk_i, reset_i, status_o, led_status, host_intf, w_TX_Byte, w_TX_DV,w_TX_Active):

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
	data2sd = Signal(intbv(0)[len(host_intf.data_i):])
	error = Signal(bool(False))
	endoftest = Signal(bool(False))
	addrset = Signal(bool(False))
	testState = enum('INIT', 'WRITE', 'VERIFY', 'SHOW_RESULT')
	test_state = Signal(testState.INIT)

	rand_gen = uniform_rand_gen(clk_i, rand_enable, rand_load, rand_seed, rand_val)

	@always_seq(clk_i.posedge, reset=None)
	def sdram_tester():
		if reset_i == True:
				error.next = False
				endoftest.next = False
				addrset.next = False
				test_state.next = testState.WRITE
				status_o.next = intbv(ord("1"),0,256)
				w_TX_Byte.next = 49
				if (w_TX_Active == 0):
				    w_TX_DV.next = 1
				else:
				    w_TX_DV.next = 0
				led_status.next = intbv('0001')[4:0]
				address.next = 0
				rand_load.next = 1
		elif test_state == testState.WRITE:
				rand_load.next = 0
				rand_enable.next = 0
				status_o.next = intbv(ord("2"),0,256)
				w_TX_Byte.next = 50
				if (w_TX_Active == 0):
				    w_TX_DV.next = 1
				else:
				    w_TX_DV.next = 0

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
				w_TX_Byte.next = 51
				if (w_TX_Active == 0):
				    w_TX_DV.next = 1
				else:
				    w_TX_DV.next = 0
				
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
				    w_TX_Byte.next = 70
				    if (w_TX_Active == 0):
				        w_TX_DV.next = 1
				    else:
				        w_TX_DV.next = 0
				    led_status.next = intbv('1000')[4:0]
				else:
					status_o.next = intbv(ord("O"),0,256)
					led_status.next = intbv('1111')[4:0]
					if endoftest == False:
						w_TX_Byte.next = 79
						if (w_TX_Active == 0):
							w_TX_DV.next = 1
							
						else:
							w_TX_DV.next = 0
							#endoftest.next = True
					"""
					if endoftest == True:
				
						address.next = 50
						addrset.next = 1
						if addrset == 1:
							data2sd.next = 21930
							
						if host_intf.done_o == False:
							rd_enable.next = True
					"""
						 
						
				            
		  
				        
				        

	@always_comb
	def host_connections():
		host_intf.rst_i.next = reset_i
		host_intf.wr_i.next = wr_enable and not host_intf.done_o
		host_intf.rd_i.next = rd_enable and not host_intf.done_o
		host_intf.data_i.next = rand_val
		host_intf.addr_i.next = address

	return instances()

@block
def sdram_test(master_clk_i, sdram_clk_o, sdram_clk_i,led_status, i_uart_rx, o_uart_tx, pb_i, sd_intf):
	clk50MHz = Signal(bool(0))
	w_TX_Serial = Signal(bool(0))
	w_TX_Active = Signal(bool(0))
	
	w_TX_DV = Signal(bool(0))
	w_TX_Byte = Signal(intbv(0)[8:])
	
	o_TX_Done = Signal(bool(0))
	state_tx = Signal(t_state_tx.TX_IDLE)
	#state_rx = Signal(t_state_rx.RX_IDLE)
 
	clk = Signal(bool(0))
 
				     
 
	
	@always(master_clk_i.posedge)
	def div2():
		clk50MHz.next = not clk50MHz
	


	
	@always_comb
	def clock_routing():
		sdram_clk_o.next = clk50MHz
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
	memory_test_inst = memory_test(clk, reset, test_status, led_status, host_intf_inst, w_TX_Byte, w_TX_DV, w_TX_Active)
	
	sdramCntl_inst = SdramCntl(clk, host_intf_inst, sd_intf)
	"""
	during a read
	5 clks to read
	6 clks in between address chg

	during a write
	4 clks in between address chg
	4 clks in between data chg
	50MHz 1M 1e-06 per bit 10 e-6 per char
	
	"""
	#uart_rx_inst = uart_rx(sdram_clk_o,i_uart_rx,w_RX_DV,w_RX_Byte,state_rx,CLKS_PER_BIT=434)
	uart_tx_inst = uart_tx(sdram_clk_o,w_TX_DV,w_TX_Byte,w_TX_Active,w_TX_Serial,o_TX_Done,state_tx,CLKS_PER_BIT=50)
	forceHi_inst = forceHi(w_TX_Serial,w_TX_Active,o_uart_tx)
	
	return instances()


@block    
def sdram_test_tb():
	clk, sdram_clk, sdram_return_clk, i_uart_rx,o_uart_tx = [Signal(bool(0)) for _ in range(5)]
 
	@always_comb
	def sdram_clk_loopback():
		sdram_return_clk.next = sdram_clk

	#drvrs = [TristateSignal(bool(0)) for _ in range(8)]
	led_status = Signal(intbv(0,0,16))
	pb = Signal(bool(1))
	sd_intf_inst = sd_intf()
	sdram_inst = sdram(sdram_clk, sd_intf_inst, show_command=False)
	dut = sdram_test(clk, sdram_clk, sdram_return_clk, led_status, i_uart_rx, o_uart_tx, pb, sd_intf_inst)

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

		for _ in range(6000):
				clk.next = not clk
				yield delay(1)
		raise StopSimulation

	return instances()


if __name__ == '__main__':
 
 
	clk, sdram_clk, sdram_return_clk = [Signal(bool(0)) for _ in range(3)]
 
	led_status = Signal(intbv(0,0,16))
	pb = Signal(bool(1))
	i_uart_rx = Signal(bool(0))
	o_uart_tx = Signal(bool(0))
	sd_intf_inst = sd_intf()
	
	sdram_test_inst = sdram_test(clk, sdram_clk, sdram_return_clk, led_status, i_uart_rx, o_uart_tx, pb, sd_intf_inst)
	sdram_test_inst.convert(hdl="Verilog", initial_values=False)
	"""
	tb = sdram_test_tb()
	tb.config_sim(trace=True)
	tb.run_sim()
	"""
	
	

	
	

	
