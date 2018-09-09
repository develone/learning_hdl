import myhdl
from myhdl import block, always, instance, Signal, ResetSignal, intbv, delay,StopSimulation
from SDRAM_Controller.uart_rx import uart_rx, t_state_rx
from SDRAM_Controller.uart_tx import uart_tx, t_state_tx
from SDRAM_Controller.forceHi import forceHi
from SDRAM_Controller.clkdiv import divclkby2

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
		
	master_clk_i  = Signal(bool(0))
	clk50MHz  = Signal(bool(0))
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
	divclkby2_0 = divclkby2(master_clk_i,clk50MHz)
	uart_rx_0 = uart_rx(clk50MHz,i_uart_rx,w_RX_DV,w_RX_Byte,state_rx,CLKS_PER_BIT=25)
	uart_tx_0 = uart_tx(clk50MHz,w_TX_DV,w_TX_Byte,w_TX_Active,w_TX_Serial,o_TX_Done,state_tx,CLKS_PER_BIT=25)

	forceHi_0 = forceHi(w_TX_Serial,w_TX_Active,o_uart_tx)
	
	 
	 
	msg = ['h','e','l','l','o','w','o','l','d']
	#msg = ['5','6','7','8','5','5','a','a','10','13']
	"""
	master_clk_i is 50 MHz 20 nsec is the output of the  clkgen
	This is further reduced to 25 MHz 40 nsec is what drives the 
	uart_rx_0 & uart_tx_0 with CLKS_PER_BIT=25  a baud rate of 1M Baud is obtained
	
	"""
	@always(delay(10))
	def clkgen():
		master_clk_i.next = not master_clk_i
		
	
	@instance
	def stimulus():
		i_uart_rx.next = 1
		for j in range(100):
			yield clk50MHz.posedge
		for j in range(8):
 
			
			w_TX_Byte.next = ord(msg[j])
			w_TX_DV.next = 1	
			for i in range(1):
				yield clk50MHz.posedge
			w_TX_DV.next = 0	
			for i in range(1):
				yield clk50MHz.posedge
			for i in range(250):
				yield clk50MHz.posedge
			for i in range(10):
				yield clk50MHz.posedge
		
		for j in range(8):
			"""
			srart bit
			"""
			i_uart_rx.next = 0
			for i in range(25):
				yield clk50MHz.posedge
			for i in range(1):
				yield clk50MHz.posedge	
			x = ord(msg[j])
			#print x
			"""
			8 data bits
			"""
			y = 1
			for i in range(8):
				z = x & y 
				#print z
				if (z > 0):
					i_uart_rx.next = 1
				else:
					i_uart_rx.next = 0
				y = y << 1
				for l in range(25):
					yield clk50MHz.posedge
			"""
			stop nit
			"""
			i_uart_rx.next = 1
			for i in range(25):
				yield clk50MHz.posedge
			
		
 
		
		raise StopSimulation()
	return uart_tx_0, uart_rx_0, clkgen, stimulus,  forceHi_0, divclkby2_0
tb = testbench()
tb.config_sim(trace=True)
tb.run_sim()
