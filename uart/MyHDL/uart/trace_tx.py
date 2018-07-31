import myhdl
from myhdl import block, always, instance, Signal, ResetSignal, intbv, delay,StopSimulation
from uart_tx import uart_tx, t_state_tx
ACTIVE_LOW = 0
@block
def testbench():
	i_TX_DV = Signal(bool(0))
	o_TX_Done = Signal(bool(0))
	o_TX_Serial = Signal(bool(0))
	o_TX_Active = Signal(bool(0))
	#i_uart_rx = Signal(bool(0))
	i_Clock  = Signal(bool(0))
	i_TX_Byte = Signal(intbv(0)[8:])
	state_tx = Signal(t_state_tx.TX_IDLE)
	 
	msg = ['h','e','l','l','o','w','o','l','d']
	uart_tx_0 = uart_tx(i_Clock,i_TX_DV,i_TX_Byte,o_TX_Active,o_TX_Serial,o_TX_Done,state_tx,CLKS_PER_BIT=868)
	@always(delay(10))
	def clkgen():
		i_Clock.next = not i_Clock
	@instance
	def stimulus():
		for j in range(8):
 
			
			i_TX_Byte.next = ord(msg[j])
			i_TX_DV.next = 1	
			for i in range(1):
				yield i_Clock.posedge
			i_TX_DV.next = 0	
			for i in range(1):
				yield i_Clock.posedge
			for i in range(9080):
				yield i_Clock.posedge
 		raise StopSimulation()
	return uart_tx_0, clkgen, stimulus
tb = testbench()
tb.config_sim(trace=True)
tb.run_sim()
