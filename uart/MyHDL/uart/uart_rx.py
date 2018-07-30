from myhdl import block, always, Signal, instance, delay, Simulation, intbv

@block
def uart_rx(i_Clock,i_RX_Serial,o_RX_DV,o_RX_Byte,CLKS_PER_BIT=None):
	r_RX_DV = Signal(bool(0))
	r_Clock_Count = Signal(intbv(0)[12:])
	r_RX_data = Signal(intbv(0)[8:])
	r_RX_Byte = Signal(intbv(0)[8:])
	r_Bit_Index = Signal(intbv(0)[3:])
	
	r_SM_Main = Signal(intbv(0)[3:])
	RX_START_BIT = Signal(intbv(0)[3:])
	RX_DATA_BITS = Signal(intbv(0)[3:])
	RX_STOP_BIT = Signal(intbv(0)[3:])
	IDLE = Signal(intbv(0)[3:])
	CLEANUP = Signal(intbv(0)[3:])
	
	IDLE = 0
	RX_START_BIT = 1
	RX_DATA_BITS = 2
	RX_STOP_BIT = 3
	CLEANUP = 4
	@always(i_Clock.posedge)
	def recv():
		if(r_SM_Main==IDLE):
			"""Drive Line High for IDLE"""
		
			r_RX_DV.next = 0
			r_Bit_Index.next = 0
			r_Clock_Count.next = 0
			if(i_RX_Serial == 0):
				r_SM_Main.next = RX_START_BIT
			else:
				r_SM_Main.next = IDLE 
		elif (r_SM_Main==RX_START_BIT):
			if (r_Clock_Count == (CLKS_PER_BIT -1)//2):
				if ( i_RX_Serial == 0):
					r_Clock_Count.next = 0
					r_SM_Main.next = RX_DATA_BITS
				else:
					r_SM_Main.next = IDLE
			else:
				r_Clock_Count.next = r_Clock_Count + 1
				r_SM_Main.next = RX_START_BIT
		elif (r_SM_Main==RX_DATA_BITS):
			if (r_Clock_Count < CLKS_PER_BIT -1):
				r_Clock_Count.next = r_Clock_Count + 1
				r_SM_Main.next = RX_DATA_BITS
			else:
				r_Clock_Count.next = 0
				r_RX_Byte[r_Bit_Index].next = i_RX_Serial
				if (r_Bit_Index < 7):
					r_Bit_Index.next = r_Bit_Index + 1
					r_SM_Main.next = RX_DATA_BITS
				else:
					r_Bit_Index.next = 0
					r_SM_Main.next = RX_STOP_BIT
		elif (r_SM_Main==RX_STOP_BIT):
			if (r_Clock_Count < CLKS_PER_BIT -1):
				r_Clock_Count.next = r_Clock_Count + 1
				r_SM_Main.next = RX_STOP_BIT
			else:
				r_RX_DV.next = 1
				r_Clock_Count.next = 0
				r_SM_Main.next = CLEANUP
		elif (r_SM_Main==CLEANUP):
			r_SM_Main.next = IDLE
			r_RX_DV.next = 0
		else:
			r_SM_Main.next = IDLE
		o_RX_DV.next = r_RX_DV
		o_RX_Byte.next = r_RX_Byte

	return recv

def convert_uart(hdl):
	"""Convert inc block to Verilog or VHDL."""

	o_RX_DV = Signal(bool(0))
	i_RX_Serial = Signal(bool(0))
	#i_uart_rx = Signal(bool(0))
	i_Clock  = Signal(bool(0))
	o_RX_Byte = Signal(intbv(0)[8:])
	uart_rx_inst = uart_rx(i_Clock,i_RX_Serial,o_RX_DV,o_RX_Byte,CLKS_PER_BIT=868)
	uart_rx_inst.convert(hdl=hdl)
convert_uart(hdl='Verilog')
