
//`include "uart_tx.v" 
module tb_dut_echo;

 
  parameter c_CLOCK_PERIOD_NS = 10;
  //parameter c_CLKS_PER_BIT    = 868;
  //The parameter c_BIT_PERIOD      = 8600;
  //not required
  //parameter c_BIT_PERIOD      = 8600;
  //Used to generate 100MHz clock 
  //using the parameter c_CLOCK_PERIOD_NS = 10;
  reg r_Clock = 0;

  //Signal to start to the transfer on o_uart_tx
  //During the transfer the o_TX_Active is hi
  reg r_TX_DV = 0;
  wire w_TX_Active, w_UART_Line;
  //Signal to map to o_uart_tx
  wire w_TX_Serial;
  //Signal to map to i_TX_Byte
  reg [7:0] r_TX_Byte = 0;
  //Signal to map to o_RX_Byte
  wire [7:0] w_RX_Byte;
  //for loop reg that allows
  //clocks pass the detection of 
  //w_RX_Byte to see that the r_TX_Done
  reg [12:0] r_loop = 0;
  
  uart_rx dut_rx(
    .i_Clock(r_Clock),
    .i_RX_Serial(w_UART_Line),
    .o_RX_DV(w_RX_DV),
    .o_RX_Byte(w_RX_Byte),
	.state_rx()
);
  
  uart_tx dut_tx(
    .i_Clock(r_Clock),
    .i_TX_DV(r_TX_DV),
    .i_TX_Byte(r_TX_Byte),
    .o_TX_Active(w_TX_Active),
	.o_TX_Serial(w_TX_Serial),
    .o_TX_Done(),
	.state_tx()
);
 
  // Keeps the UART Receive input high (default) when
  // UART transmitter is not active
  assign w_UART_Line = w_TX_Active ? w_TX_Serial : 1'b1;
  //Used to generate 100MHz clock
  //which drives the simulation
  always
    #(c_CLOCK_PERIOD_NS/2) r_Clock <= !r_Clock;
  // Main Testing:
  initial
    begin
      // Tell UART to send a command (exercise TX)
      @(posedge r_Clock);
      @(posedge r_Clock);
      r_TX_DV   <= 1'b1;
      r_TX_Byte <= 8'h3F;
      @(posedge r_Clock);
      r_TX_DV <= 1'b0;
      // Check that the correct command was received
      @(posedge w_RX_DV);
      if (w_RX_Byte == 8'h3F)
        $display("Test Passed - Correct Byte Received");
      else
        $display("Test Failed - Incorrect Byte Received");
      //for loop reg that allows
      //clocks pass the detection of 
      //w_RX_Byte to see that the r_TX_Done      
      for (r_loop = 0; r_loop <= 1023 ; r_loop = r_loop + 1) begin
      
			@(posedge r_Clock);
	  end  
      $finish();
    end


  initial 
  begin
    // Required to dump signals to EPWave
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
endmodule
