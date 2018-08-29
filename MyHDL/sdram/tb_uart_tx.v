module tb_uart_tx;

reg i_Clock;
reg i_TX_DV;
reg [7:0] i_TX_Byte;
wire o_TX_Active;
wire o_TX_Serial;
wire o_TX_Done;
wire [2:0] state_tx;

initial begin
    $from_myhdl(
        i_Clock,
        i_TX_DV,
        i_TX_Byte
    );
    $to_myhdl(
        o_TX_Active,
        o_TX_Serial,
        o_TX_Done,
        state_tx
    );
end

uart_tx dut(
    i_Clock,
    i_TX_DV,
    i_TX_Byte,
    o_TX_Active,
    o_TX_Serial,
    o_TX_Done,
    state_tx
);

endmodule
