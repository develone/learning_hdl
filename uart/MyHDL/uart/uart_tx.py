from myhdl import block, always, Signal, instance, delay, Simulation, intbv

@block
def uart_tx(i_Clock,i_TX_DV,i_TX_Byte,o_TX_Active,o_TX_Serial,o_TX_Done,CLKS_PER_BIT=None):
	r_TX_Done = Signal(bool(0))
	r_TX_Active = Signal(bool(0))
	r_Clock_Count = Signal(intbv(0)[12:])
	r_TX_data = Signal(intbv(0)[8:])
	r_Bit_Index = Signal(intbv(0)[3:])
	
	r_SM_Main = Signal(intbv(0)[3:])
	TX_START_BIT = Signal(intbv(0)[3:])
	TX_DATA_BITS = Signal(intbv(0)[3:])
	TX_STOP_BIT = Signal(intbv(0)[3:])
	
	IDLE = Signal(intbv(0)[3:])
	CLEANUP = Signal(intbv(0)[3:])
	IDLE = 0
	TX_START_BIT = 1
	TX_DATA_BITS = 2
	TX_STOP_BIT = 3
	CLEANUP = 4
	@always(i_Clock.posedge)
	def send():
		if(r_SM_Main==IDLE):
			"""Drive Line High for IDLE"""
		
			o_TX_Serial.next = 1
			r_TX_Done.next = 0
			r_Bit_Index.next = 0
			r_Clock_Count.next = 0
			if(i_TX_DV == 1):
				r_TX_Active.next = 1
				r_TX_data.next = i_TX_Byte
				r_SM_Main.next = TX_START_BIT
			else:
				r_SM_Main.next = IDLE 
				"""End of IDLE"""
		elif (r_SM_Main==TX_START_BIT):
			o_TX_Serial.next = 0
			if (r_Clock_Count < CLKS_PER_BIT -1):
				r_Clock_Count.next = r_Clock_Count + 1
				r_SM_Main.next = TX_START_BIT
			else:
				r_Clock_Count.next = 0
				r_SM_Main.next = TX_DATA_BITS
		elif (r_SM_Main==TX_DATA_BITS):
			o_TX_Serial.next = r_TX_data[r_Bit_Index]
			if (r_Clock_Count < CLKS_PER_BIT -1):
				r_Clock_Count.next = r_Clock_Count + 1
				r_SM_Main.next = TX_DATA_BITS
			else:
				r_Clock_Count.next = 0
				if (r_Bit_Index < 7):
					r_Bit_Index.next = r_Bit_Index + 1
					r_SM_Main.next = TX_DATA_BITS
				else:
					r_Bit_Index.next = 0
					r_SM_Main.next = TX_STOP_BIT
					
		elif (r_SM_Main==TX_STOP_BIT):
			o_TX_Serial.next = 1
			if (r_Clock_Count < CLKS_PER_BIT -1):
				r_Clock_Count.next = r_Clock_Count + 1
				r_SM_Main.next = TX_STOP_BIT
			else:
				r_TX_Done.next = 1
				r_Clock_Count.next = 0
				r_SM_Main.next = CLEANUP
				r_TX_Active.next = 0
		elif (r_SM_Main==CLEANUP):
			r_TX_Done.next = 1
			r_SM_Main.next = IDLE
		else:
			r_SM_Main.next = IDLE
		o_TX_Active.next = r_TX_Active
		o_TX_Done.next = r_TX_Done
				
				
				
			
				
				


	return send

def convert_uart(hdl):
	"""Convert inc block to Verilog or VHDL."""

	i_TX_DV = Signal(bool(0))
	o_TX_Done = Signal(bool(0))
	o_TX_Serial = Signal(bool(0))
	o_TX_Active = Signal(bool(0))
	#o_uart_tx = Signal(bool(0))
	i_Clock  = Signal(bool(0))
	i_TX_Byte = Signal(intbv(0)[8:])
	uart_tx_inst = uart_tx(i_Clock,i_TX_DV,i_TX_Byte,o_TX_Active,o_TX_Serial,o_TX_Done,CLKS_PER_BIT=868)
        uart_tx_inst.convert(hdl=hdl)
convert_uart(hdl='Verilog')
