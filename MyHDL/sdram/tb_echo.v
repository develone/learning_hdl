module tb_echo;

reg master_clk_i;
reg i_uart_rx;
wire o_uart_tx;

initial begin
    $from_myhdl(
        master_clk_i,
        i_uart_rx
    );
    $to_myhdl(
        o_uart_tx
    );
end

echo dut(
    master_clk_i,
    i_uart_rx,
    o_uart_tx
);

endmodule
