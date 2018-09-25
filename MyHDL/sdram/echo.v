// File: echo.v
// Generated by MyHDL 0.10
// Date: Sat Sep  8 21:14:06 2018


`timescale 1ns/10ps

module echo (
    master_clk_i,
    i_uart_rx,
    o_uart_tx
);


input master_clk_i;
input i_uart_rx;
output o_uart_tx;
reg o_uart_tx;

reg o_TX_Done = 0;
reg w_TX_Serial = 0;
reg [2:0] state_rx = 3'b000;
reg clk50MHz = 0;
reg w_RX_DV = 0;
reg [7:0] w_RX_Byte = 0;
reg w_TX_Active = 0;
reg [2:0] state_tx = 3'b000;
reg [11:0] uart_tx0_0_r_Clock_Count = 0;
reg [2:0] uart_tx0_0_r_Bit_Index = 0;
reg [7:0] uart_tx0_0_r_TX_data = 0;
reg uart_tx0_0_r_TX_Active = 0;
reg uart_tx0_0_r_TX_Done = 0;
reg uart_rx0_0_r_RX_DV = 0;
reg [11:0] uart_rx0_0_r_Clock_Count = 0;
reg [2:0] uart_rx0_0_r_Bit_Index = 0;



always @(posedge clk50MHz) begin: ECHO_UART_TX0_0_SEND
    case (state_tx)
        3'b000: begin
            // Drive Line High for TX_IDLE
            w_TX_Serial <= 1;
            uart_tx0_0_r_TX_Done <= 0;
            uart_tx0_0_r_Bit_Index <= 0;
            uart_tx0_0_r_Clock_Count <= 0;
            if ((w_RX_DV == 1)) begin
                uart_tx0_0_r_TX_Active <= 1;
                uart_tx0_0_r_TX_data <= w_RX_Byte;
                state_tx <= 3'b001;
            end
            else begin
                state_tx <= 3'b000;
                // End of TX TX_IDLE state
                // Start of TX TX_START_BIT state
            end
        end
        3'b001: begin
            w_TX_Serial <= 0;
            if (($signed({1'b0, uart_tx0_0_r_Clock_Count}) < (50 - 1))) begin
                uart_tx0_0_r_Clock_Count <= (uart_tx0_0_r_Clock_Count + 1);
                state_tx <= 3'b001;
            end
            else begin
                uart_tx0_0_r_Clock_Count <= 0;
                state_tx <= 3'b010;
                // End of TX TX_START_BIT state_tx
                // Start of TX TX_DATA_BITS state_tx
            end
        end
        3'b010: begin
            w_TX_Serial <= uart_tx0_0_r_TX_data[uart_tx0_0_r_Bit_Index];
            if (($signed({1'b0, uart_tx0_0_r_Clock_Count}) < (50 - 1))) begin
                uart_tx0_0_r_Clock_Count <= (uart_tx0_0_r_Clock_Count + 1);
                state_tx <= 3'b010;
            end
            else begin
                uart_tx0_0_r_Clock_Count <= 0;
                if ((uart_tx0_0_r_Bit_Index < 7)) begin
                    uart_tx0_0_r_Bit_Index <= (uart_tx0_0_r_Bit_Index + 1);
                    state_tx <= 3'b010;
                end
                else begin
                    uart_tx0_0_r_Bit_Index <= 0;
                    state_tx <= 3'b011;
                end
                // End of TX TX_DATA_BITS state_tx
                // Start of TX TX_STOP_BIT state_tx
            end
        end
        3'b011: begin
            w_TX_Serial <= 1;
            if (($signed({1'b0, uart_tx0_0_r_Clock_Count}) < (50 - 1))) begin
                uart_tx0_0_r_Clock_Count <= (uart_tx0_0_r_Clock_Count + 1);
                state_tx <= 3'b011;
            end
            else begin
                uart_tx0_0_r_TX_Done <= 1;
                uart_tx0_0_r_Clock_Count <= 0;
                state_tx <= 3'b100;
                uart_tx0_0_r_TX_Active <= 0;
                // End of TX TX_STOP_BIT state_tx
                // Start of TX TX_CLEANUP state_tx
            end
        end
        3'b100: begin
            uart_tx0_0_r_TX_Done <= 1;
            state_tx <= 3'b000;
        end
        default: begin
            state_tx <= 3'b000;
        end
    endcase
    w_TX_Active <= uart_tx0_0_r_TX_Active;
    o_TX_Done <= uart_tx0_0_r_TX_Done;
end


always @(posedge clk50MHz) begin: ECHO_UART_RX0_0_RECV
    case (state_rx)
        3'b000: begin
            // Drive Line High for RX_IDLE
            uart_rx0_0_r_RX_DV <= 0;
            uart_rx0_0_r_Bit_Index <= 0;
            uart_rx0_0_r_Clock_Count <= 0;
            if ((i_uart_rx == 0)) begin
                state_rx <= 3'b001;
            end
            else begin
                state_rx <= 3'b000;
                // End of RX RX_IDLE state_rx
                // Start of RX RX_START_BIT state_rx
            end
        end
        3'b001: begin
            if (($signed({1'b0, uart_rx0_0_r_Clock_Count}) == ((50 - 1) / 2))) begin
                if ((i_uart_rx == 0)) begin
                    uart_rx0_0_r_Clock_Count <= 0;
                    state_rx <= 3'b010;
                end
                else begin
                    state_rx <= 3'b000;
                end
            end
            else begin
                uart_rx0_0_r_Clock_Count <= (uart_rx0_0_r_Clock_Count + 1);
                state_rx <= 3'b001;
                // End of RX RX_START_BIT state_rx
                // Start of RX RX_DATA_BITS state_rx
            end
        end
        3'b010: begin
            if (($signed({1'b0, uart_rx0_0_r_Clock_Count}) < (50 - 1))) begin
                uart_rx0_0_r_Clock_Count <= (uart_rx0_0_r_Clock_Count + 1);
                state_rx <= 3'b010;
            end
            else begin
                uart_rx0_0_r_Clock_Count <= 0;
                w_RX_Byte[uart_rx0_0_r_Bit_Index] <= i_uart_rx;
                if ((uart_rx0_0_r_Bit_Index < 7)) begin
                    uart_rx0_0_r_Bit_Index <= (uart_rx0_0_r_Bit_Index + 1);
                    state_rx <= 3'b010;
                end
                else begin
                    uart_rx0_0_r_Bit_Index <= 0;
                    state_rx <= 3'b011;
                end
                // End of RX RX_DATA_BITS state_rx
                // Start of RX RX_STOP_BIT state_rx
            end
        end
        3'b011: begin
            if (($signed({1'b0, uart_rx0_0_r_Clock_Count}) < (50 - 1))) begin
                uart_rx0_0_r_Clock_Count <= (uart_rx0_0_r_Clock_Count + 1);
                state_rx <= 3'b011;
            end
            else begin
                uart_rx0_0_r_RX_DV <= 1;
                uart_rx0_0_r_Clock_Count <= 0;
                state_rx <= 3'b100;
                // End of RX RX_STOP_BIT state_rx
                // Start of RX RX_CLEANUP state_rx
            end
        end
        3'b100: begin
            state_rx <= 3'b000;
            uart_rx0_0_r_RX_DV <= 0;
        end
        default: begin
            state_rx <= 3'b000;
        end
    endcase
    w_RX_DV <= uart_rx0_0_r_RX_DV;
end


always @(w_TX_Active, w_TX_Serial) begin: ECHO_FORCEHI0_COMB
    if (w_TX_Active) begin
        o_uart_tx = w_TX_Serial;
    end
    else begin
        o_uart_tx = 1'b1;
    end
end


always @(posedge master_clk_i) begin: ECHO_DIVCLKBY20_0_DIV2
    clk50MHz <= (!clk50MHz);
end

endmodule