import myhdl
from myhdl import block, always, instance, Signal, ResetSignal, intbv, delay,StopSimulation
from uart_tx import uart_tx, t_state_tx
from uart_rx import uart_rx, t_state_rx
from forceHi import forceHi

ACTIVE_LOW = 0
@block
def testbench():
	i_uart_rx = Signal(bool(0))
	o_uart_tx = Signal(bool(0))
	i_TX_DV = Signal(bool(0))
	o_TX_Done = Signal(bool(0))
	"""
	o_TX_Serial = Signal(bool(0))
	w_TX_Serial = Signal(bool(0))
	o_TX_Active = Signal(bool(0))
	w_TX_Active = Signal(bool(0))
	i_Clk  = Signal(bool(0))
	i_Clock  = Signal(bool(0))
	"""	
	
	w_TX_Serial = Signal(bool(0))
	w_TX_Active = Signal(bool(0))
	 
	"""
	o_TX_Serial = Signal(bool(0))
	o_TX_Active = Signal(bool(0))
	"""	
	i_Clk  = Signal(bool(0))
	i_TX_Byte = Signal(intbv(0)[8:])
	"""
	This wire is used when the data from the 
	recv is valid to echo the character
	"""
	w_RX_DV = Signal(bool(0))
	w_RX_Byte = Signal(intbv(0)[8:])
	state_tx = Signal(t_state_tx.TX_IDLE)
	state_rx = Signal(t_state_rx.TX_IDLE) 
	msg = ['h','e','l','l','o','w','o','l','d']
	uart_rx(i_Clk,i_uart_rx,w_RX_DV,w_RX_Byte,state_rx,CLKS_PER_BIT=868)
	uart_tx_0 = uart_tx(i_Clk,w_RX_DV,w_RX_Byte,w_TX_Active,w_TX_Serial,o_TX_Done,state_tx,CLKS_PER_BIT=868)
	
	forceHi_0 = forceHi(w_TX_Serial,w_TX_Active,o_uart_tx)
	@always(delay(10))
	def clkgen():
		i_Clk.next = not i_Clk
	@instance
	def stimulus():
		for j in range(8):
			for i in range(100):
				yield i_Clk.posedge 
			
			w_RX_Byte.next = ord(msg[j])
			"""
			i_TX_DV.next = 1
			"""	
			w_RX_DV.next = 1
			for i in range(1):
				yield i_Clk.posedge
			"""
			i_TX_DV.next = 0
			"""	
			w_RX_DV.next = 0	
			for i in range(1):
				yield i_Clk.posedge
			for i in range(9080):
				yield i_Clk.posedge
			for i in range(100):
				yield i_Clk.posedge 				
 		raise StopSimulation()
	return uart_tx_0, forceHi_0, clkgen, stimulus
tb = testbench()
tb.config_sim(trace=True)
tb.run_sim()
