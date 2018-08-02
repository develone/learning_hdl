import myhdl
from myhdl import block, always, instance, Signal, ResetSignal, intbv, delay,StopSimulation
from uart_rx import uart_rx
ACTIVE_LOW = 0
@block
def testbench():
	o_RX_DV = Signal(bool(0))
	i_RX_Serial = Signal(bool(0))
	#i_uart_rx = Signal(bool(0))
	i_Clock  = Signal(bool(0))
	o_RX_Byte = Signal(intbv(0)[8:])
	 
	uart_rx_0 = uart_rx(i_Clock,i_RX_Serial,o_RX_DV,o_RX_Byte,CLKS_PER_BIT=868)
	@always(delay(10))
	def clkgen():
		i_Clock.next = not i_Clock
	@instance
	def stimulus():
		i_RX_Serial.next = 1	
		for i in range(10):
			yield i_Clock.posedge
		#Setting the stop bit
		i_RX_Serial.next = 0	
		for i in range(867):
			yield i_Clock.posedge
		#Setting 4 bits high
		i_RX_Serial.next = 1
		for i in range(3468):
			yield i_Clock.posedge
		#Setting 1 bit low
		i_RX_Serial.next = 0	
		for i in range(867):
			yield i_Clock.posedge
		#Setting 1 bit high	
		i_RX_Serial.next = 1	
		for i in range(867):
			yield i_Clock.posedge
		#Setting 1 bit low
		i_RX_Serial.next = 0
		for i in range(867):
			yield i_Clock.posedge
		#Setting 1 bit high
		i_RX_Serial.next = 1	
		for i in range(867):
			yield i_Clock.posedge
		for i in range(400):
			yield i_Clock.posedge
		raise StopSimulation()
	return uart_rx_0, clkgen, stimulus
tb = testbench()
tb.config_sim(trace=True)
tb.run_sim()
