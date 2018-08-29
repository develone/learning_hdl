import myhdl
from myhdl import block, always, instance, Signal, ResetSignal, intbv, delay,StopSimulation
from SDRAM_Controller.uart_rx import uart_rx, t_state_rx
from SDRAM_Controller.uart_tx import uart_tx, t_state_tx
from SDRAM_Controller.forceHi import forceHi

ACTIVE_LOW = 0
@block
def testbench():
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
	"""
	w_TX_Serial = Signal(bool(0))
	w_TX_Active = Signal(bool(0))
	"""
	w_TX_Active = Signal(bool(0))
	w_TX_Serial = Signal(intbv(0)[1:])
	i_uart_rx = Signal(bool(0))
	o_uart_tx = Signal(bool(0)) 
	
	#o_TX_Serial = Signal(bool(0))
	w_TX_Serial = Signal(bool(0))
	o_TX_Active = Signal(bool(0))
		
	i_Clk  = Signal(bool(0))
	w_RX_Byte = Signal(intbv(0)[8:])
	w_TX_Byte = Signal(intbv(0)[8:])
	i_TX_Byte = Signal(intbv(0)[8:])
	
	
	w_RX_DV = Signal(bool(0))
	w_TX_DV = Signal(bool(0))
	#i_RX_Serial = Signal(bool(0))
	#i_uart_rx = Signal(bool(0))
	o_RX_Byte = Signal(intbv(0)[8:])
	w_RX_Byte = Signal(intbv(0)[8:])
	state_tx = Signal(t_state_tx.TX_IDLE)
	state_rx = Signal(t_state_rx.RX_IDLE)
	uart_rx_inst = uart_rx(i_Clk,i_uart_rx,w_RX_DV,w_RX_Byte,state_rx,CLKS_PER_BIT=434)
	uart_tx_inst = uart_tx(i_Clk,w_RX_DV,w_TX_Byte,w_TX_Active,w_TX_Serial,o_TX_Done,state_tx,CLKS_PER_BIT=434)

	forceHi_0 = forceHi(w_TX_Serial,w_TX_Active,o_uart_tx)
	
	 
	 
	msg = ['h','e','l','l','o','w','o','l','d']
	#msg = ['5','6','7','8','5','5','a','a','10','13']
 
	@always(delay(10))
	def clkgen():
		i_Clk.next = not i_Clk
		
	
	@instance
	def stimulus():
		for j in range(8):
 
			
			w_TX_Byte.next = ord(msg[j])
			w_TX_DV.next = 1	
			for i in range(1):
				yield i_Clk.posedge
			w_TX_DV.next = 0	
			for i in range(1):
				yield i_Clk.posedge
			for i in range(11080):
				yield i_Clk.posedge
		"""	
		w_TX_Byte.next = int(msg[8])
		print(msg[8])
		w_TX_DV.next = 1
		for i in range(1):
			yield i_Clk.posedge
		w_TX_DV.next = 0
		for i in range(1):
			yield i_Clk.posedge
		for i in range(2080):
			yield i_Clk.posedge	
		"""
			
		raise StopSimulation()
	return uart_tx_inst, uart_rx_inst, clkgen, stimulus,  forceHi_0
tb = testbench()
tb.config_sim(trace=True)
tb.run_sim()
