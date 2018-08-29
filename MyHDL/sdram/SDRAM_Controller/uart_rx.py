from myhdl import *
ACTIVE_LOW = 0

t_state_rx = enum('RX_IDLE', 'RX_START_BIT', 'RX_DATA_BITS','RX_STOP_BIT','RX_CLEANUP')

@block
def uart_rx(i_Clock,i_RX_Serial,o_RX_DV,o_RX_Byte,state_rx,CLKS_PER_BIT=868):
	r_RX_DV = Signal(bool(0))
	r_Clock_Count = Signal(intbv(0)[12:])
	r_RX_data = Signal(intbv(0)[8:])
	#r_RX_Byte = Signal(intbv(0)[8:])
	r_Bit_Index = Signal(intbv(0)[3:])
	 
	@always(i_Clock.posedge)
	def recv():
		if(state_rx==t_state_rx.RX_IDLE):
			"""Drive Line High for RX_IDLE"""
		
			r_RX_DV.next = 0
			r_Bit_Index.next = 0
			r_Clock_Count.next = 0
			if(i_RX_Serial == 0):
				state_rx.next = t_state_rx.RX_START_BIT
			else:
				state_rx.next = t_state_rx.RX_IDLE 
				"""
				End of RX RX_IDLE state_rx
				Start of RX RX_START_BIT state_rx
				"""				
		elif (state_rx==t_state_rx.RX_START_BIT):
			if (r_Clock_Count == (CLKS_PER_BIT -1)//2):
				if ( i_RX_Serial == 0):
					r_Clock_Count.next = 0
					state_rx.next = t_state_rx.RX_DATA_BITS
				else:
					state_rx.next = t_state_rx.RX_IDLE
			else:
				r_Clock_Count.next = r_Clock_Count + 1
				state_rx.next = t_state_rx.RX_START_BIT
				"""
				End of RX RX_START_BIT state_rx
				Start of RX RX_DATA_BITS state_rx
				"""				
		elif (state_rx==t_state_rx.RX_DATA_BITS):
			if (r_Clock_Count < CLKS_PER_BIT -1):
				r_Clock_Count.next = r_Clock_Count + 1
				state_rx.next = t_state_rx.RX_DATA_BITS
			else:
				r_Clock_Count.next = 0
				o_RX_Byte.next[r_Bit_Index]  = i_RX_Serial
				if (r_Bit_Index < 7):
					r_Bit_Index.next = r_Bit_Index + 1
					state_rx.next = t_state_rx.RX_DATA_BITS
				else:
					r_Bit_Index.next = 0
					state_rx.next = t_state_rx.RX_STOP_BIT
				"""
				End of RX RX_DATA_BITS state_rx
				Start of RX RX_STOP_BIT state_rx
				"""					
		elif (state_rx==t_state_rx.RX_STOP_BIT):
			if (r_Clock_Count < CLKS_PER_BIT -1):
				r_Clock_Count.next = r_Clock_Count + 1
				state_rx.next = t_state_rx.RX_STOP_BIT
			else:
				r_RX_DV.next = 1
				r_Clock_Count.next = 0
				state_rx.next = t_state_rx.RX_CLEANUP
				"""
				End of RX RX_STOP_BIT state_rx
				Start of RX RX_CLEANUP state_rx
				"""
		elif (state_rx==t_state_rx.RX_CLEANUP):
			state_rx.next = t_state_rx.RX_IDLE
			r_RX_DV.next = 0
		else:
			state_rx.next = t_state_rx.RX_IDLE
		o_RX_DV.next = r_RX_DV
		#o_RX_Byte.next = r_RX_Byte

	return recv

def convert_uart(hdl):
	"""Convert inc block to Verilog or VHDL."""

	o_RX_DV = Signal(bool(0))
	i_RX_Serial = Signal(bool(0))
	#i_uart_rx = Signal(bool(0))
	i_Clock  = Signal(bool(0))
	o_RX_Byte = Signal(intbv(0)[8:])
	state_rx = Signal(t_state_rx.RX_IDLE)
	uart_rx_inst = uart_rx(i_Clock,i_RX_Serial,o_RX_DV,o_RX_Byte,state_rx,CLKS_PER_BIT=868)
	uart_rx_inst.convert(hdl=hdl)
convert_uart(hdl='Verilog')
