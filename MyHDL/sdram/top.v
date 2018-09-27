// File: top.v
// Generated by MyHDL 0.10
// Date: Thu Sep 27 08:48:42 2018


`timescale 1ns/10ps

module top (
    clk100MHz,
    sdram_clk,
    sdram_return_clk,
    led_status,
    pb,
    sdramdev_SdramCntl0_sd_intf_cke,
    sdramdev_SdramCntl0_sd_intf_we,
    sdramdev_SdramCntl0_sd_intf_addr,
    sdramdev_SdramCntl0_sd_intf_dqml,
    sdramdev_SdramCntl0_sd_intf_cas,
    sdramdev_SdramCntl0_sd_intf_dqmh,
    sdramdev_SdramCntl0_sd_intf_ras,
    sdramdev_SdramCntl0_sd_intf_bs,
    sdramdev_SdramCntl0_sd_intf_cs,
    sdramdev_SdramCntl0_sd_intf_dq,
    sdramdev_SdramCntl0_host_intf_wr_i,
    sdramdev_SdramCntl0_host_intf_done_o,
    sdramdev_SdramCntl0_host_intf_rdPending_o,
    sdramdev_sdramdevfsm0_host_intf_rst_i,
    sdramdev_SdramCntl0_host_intf_data_i,
    sdramdev_SdramCntl0_host_intf_data_o,
    sdramdev_SdramCntl0_host_intf_rd_i,
    sdramdev_SdramCntl0_host_intf_addr_i
);


input clk100MHz;
output sdram_clk;
wire sdram_clk;
input sdram_return_clk;
input [3:0] led_status;
input pb;
output sdramdev_SdramCntl0_sd_intf_cke;
reg sdramdev_SdramCntl0_sd_intf_cke;
output sdramdev_SdramCntl0_sd_intf_we;
reg sdramdev_SdramCntl0_sd_intf_we;
output [12:0] sdramdev_SdramCntl0_sd_intf_addr;
reg [12:0] sdramdev_SdramCntl0_sd_intf_addr;
output sdramdev_SdramCntl0_sd_intf_dqml;
reg sdramdev_SdramCntl0_sd_intf_dqml;
output sdramdev_SdramCntl0_sd_intf_cas;
reg sdramdev_SdramCntl0_sd_intf_cas;
output sdramdev_SdramCntl0_sd_intf_dqmh;
reg sdramdev_SdramCntl0_sd_intf_dqmh;
output sdramdev_SdramCntl0_sd_intf_ras;
reg sdramdev_SdramCntl0_sd_intf_ras;
output [1:0] sdramdev_SdramCntl0_sd_intf_bs;
reg [1:0] sdramdev_SdramCntl0_sd_intf_bs;
output sdramdev_SdramCntl0_sd_intf_cs;
reg sdramdev_SdramCntl0_sd_intf_cs;
inout [15:0] sdramdev_SdramCntl0_sd_intf_dq;
wire [15:0] sdramdev_SdramCntl0_sd_intf_dq;
output sdramdev_SdramCntl0_host_intf_wr_i;
wire sdramdev_SdramCntl0_host_intf_wr_i;
output sdramdev_SdramCntl0_host_intf_done_o;
wire sdramdev_SdramCntl0_host_intf_done_o;
output sdramdev_SdramCntl0_host_intf_rdPending_o;
wire sdramdev_SdramCntl0_host_intf_rdPending_o;
output sdramdev_sdramdevfsm0_host_intf_rst_i;
wire sdramdev_sdramdevfsm0_host_intf_rst_i;
output [15:0] sdramdev_SdramCntl0_host_intf_data_i;
wire [15:0] sdramdev_SdramCntl0_host_intf_data_i;
output [15:0] sdramdev_SdramCntl0_host_intf_data_o;
wire [15:0] sdramdev_SdramCntl0_host_intf_data_o;
output sdramdev_SdramCntl0_host_intf_rd_i;
wire sdramdev_SdramCntl0_host_intf_rd_i;
output [23:0] sdramdev_SdramCntl0_host_intf_addr_i;
wire [23:0] sdramdev_SdramCntl0_host_intf_addr_i;

wire [31:0] i_wb_addr;
wire [15:0] o_wb_data;
reg clk50MHz;
wire i_wb_we;
wire i_wb_stb;
wire [3:0] i_wb_sel;
reg o_wb_ack;
reg o_wb_stall;
wire [15:0] i_wb_data;
reg sdramdev_pb_prev;
reg sdramdev_pb_debounced;
reg sdramdev_initialized;
reg [5:0] sdramdev_debounce_cntr;
wire sdramdev_clk;
wire sdramdev_reset;
reg [2:0] sdramdev_SdramCntl0_cmd_r;
reg [12:0] sdramdev_SdramCntl0_sAddr_x;
reg [2:0] sdramdev_SdramCntl0_cmd_x;
reg [1:0] sdramdev_SdramCntl0_activeBank_r;
reg [12:0] sdramdev_SdramCntl0_sAddr_r;
reg [15:0] sdramdev_SdramCntl0_sdramData_x;
reg sdramdev_SdramCntl0_activateInProgress_s;
reg sdramdev_SdramCntl0_sDataDir_x;
reg sdramdev_SdramCntl0_sDataDir_r;
wire [1:0] sdramdev_SdramCntl0_ba_x;
reg [4:0] sdramdev_SdramCntl0_rdPipeline_r;
wire [12:0] sdramdev_SdramCntl0_row_s;
reg [13:0] sdramdev_SdramCntl0_rfshCntr_x;
reg [1:0] sdramdev_SdramCntl0_ba_r;
reg [4:0] sdramdev_SdramCntl0_rdPipeline_x;
reg [13:0] sdramdev_SdramCntl0_rfshCntr_r;
reg [15:0] sdramdev_SdramCntl0_sDriver;
reg [1:0] sdramdev_SdramCntl0_activeBank_x;
reg sdramdev_SdramCntl0_doActivate_s;
wire [1:0] sdramdev_SdramCntl0_bank_s;
reg [8:0] sdramdev_SdramCntl0_refTimer_r;
reg sdramdev_SdramCntl0_rdInProgress_s;
reg [8:0] sdramdev_SdramCntl0_refTimer_x;
reg sdramdev_SdramCntl0_writeInProgress_s;
reg [2:0] sdramdev_SdramCntl0_state_x;
reg [15:0] sdramdev_SdramCntl0_sData_r;
wire [8:0] sdramdev_SdramCntl0_col_s;
reg [2:0] sdramdev_SdramCntl0_state_r;
wire [15:0] sdramdev_SdramCntl0_sData_x;
reg [9:0] sdramdev_SdramCntl0_timer_x;
reg [4:0] sdramdev_SdramCntl0_wrPipeline_x;
reg [1:0] sdramdev_SdramCntl0_wrTimer_x;
reg [4:0] sdramdev_SdramCntl0_wrPipeline_r;
reg [15:0] sdramdev_SdramCntl0_sdramData_r;
reg [1:0] sdramdev_SdramCntl0_wrTimer_r;
reg [9:0] sdramdev_SdramCntl0_timer_r;
reg [1:0] sdramdev_SdramCntl0_rasTimer_x;
reg [1:0] sdramdev_SdramCntl0_rasTimer_r;
reg sdramdev_sdramdevfsm0_rand_load;
reg sdramdev_sdramdevfsm0_rand_enable;
reg sdramdev_sdramdevfsm0_rd_enable;
wire [15:0] sdramdev_sdramdevfsm0_rand_val;
reg [1:0] sdramdev_sdramdevfsm0_test_state;
reg [26:0] sdramdev_sdramdevfsm0_address;
reg sdramdev_sdramdevfsm0_wr_enable;
reg sdramdev_sdramdevfsm0_error;
reg [15:0] sdramdev_sdramdevfsm0_data_delay0_0_tmpdata1;
reg [15:0] sdramdev_sdramdevfsm0_data_delay0_0_tmpdata;
reg [12:0] sdramdev_SdramCntl0_activeRow_x [0:4-1];
reg [12:0] sdramdev_SdramCntl0_activeRow_r [0:4-1];
reg sdramdev_SdramCntl0_activeFlag_x [0:4-1];
reg sdramdev_SdramCntl0_activeFlag_r [0:4-1];

assign i_wb_addr = 32'd0;
assign i_wb_we = 1'd0;
assign i_wb_stb = 1'd0;
assign i_wb_sel = 4'd0;
assign i_wb_data = 16'd0;
assign sdramdev_SdramCntl0_sd_intf_dq = sdramdev_SdramCntl0_sDriver;



assign sdramdev_reset = ((!sdramdev_initialized) || (!sdramdev_pb_debounced));



assign sdram_clk = clk50MHz;
assign sdramdev_clk = sdram_return_clk;


always @(posedge sdramdev_clk) begin: TOP_SDRAMDEV_DEBOUNCE_PB
    if ((pb != sdramdev_pb_prev)) begin
        sdramdev_debounce_cntr <= (49 - 1);
    end
    else begin
        if ((sdramdev_debounce_cntr == 0)) begin
            sdramdev_pb_debounced <= pb;
            sdramdev_debounce_cntr <= 1;
        end
        else begin
            sdramdev_debounce_cntr <= (sdramdev_debounce_cntr - 1);
        end
    end
    sdramdev_pb_prev <= pb;
end


always @(sdramdev_SdramCntl0_activeRow_r[0], sdramdev_SdramCntl0_activeRow_r[1], sdramdev_SdramCntl0_activeRow_r[2], sdramdev_SdramCntl0_activeRow_r[3], sdramdev_SdramCntl0_row_s, sdramdev_SdramCntl0_sAddr_r, sdramdev_SdramCntl0_activateInProgress_s, sdramdev_SdramCntl0_activeBank_r, sdramdev_SdramCntl0_sDataDir_r, sdramdev_SdramCntl0_ba_x, sdramdev_SdramCntl0_rdPipeline_r, sdramdev_SdramCntl0_ba_r, sdramdev_SdramCntl0_rfshCntr_r, sdramdev_SdramCntl0_host_intf_wr_i, sdramdev_SdramCntl0_doActivate_s, sdramdev_SdramCntl0_bank_s, sdramdev_SdramCntl0_refTimer_r, sdramdev_SdramCntl0_rdInProgress_s, sdramdev_SdramCntl0_writeInProgress_s, sdramdev_SdramCntl0_col_s, sdramdev_SdramCntl0_state_r, sdramdev_SdramCntl0_wrTimer_r, sdramdev_SdramCntl0_timer_r, sdramdev_SdramCntl0_host_intf_rd_i, sdramdev_SdramCntl0_rasTimer_r, sdramdev_SdramCntl0_activeFlag_r[0], sdramdev_SdramCntl0_activeFlag_r[1], sdramdev_SdramCntl0_activeFlag_r[2], sdramdev_SdramCntl0_activeFlag_r[3]) begin: TOP_SDRAMDEV_SDRAMCNTL0_COMB_FUNC
    integer index;
    sdramdev_SdramCntl0_rdPipeline_x = {1'b0, sdramdev_SdramCntl0_rdPipeline_r[(3 + 2)-1:1]};
    sdramdev_SdramCntl0_wrPipeline_x = 5'h0;
    if ((sdramdev_SdramCntl0_rasTimer_r != 0)) begin
        sdramdev_SdramCntl0_rasTimer_x = (sdramdev_SdramCntl0_rasTimer_r - 1);
    end
    else begin
        sdramdev_SdramCntl0_rasTimer_x = sdramdev_SdramCntl0_rasTimer_r;
    end
    if ((sdramdev_SdramCntl0_wrTimer_r != 0)) begin
        sdramdev_SdramCntl0_wrTimer_x = (sdramdev_SdramCntl0_wrTimer_r - 1);
    end
    else begin
        sdramdev_SdramCntl0_wrTimer_x = sdramdev_SdramCntl0_wrTimer_r;
    end
    if ((sdramdev_SdramCntl0_refTimer_r != 0)) begin
        sdramdev_SdramCntl0_refTimer_x = (sdramdev_SdramCntl0_refTimer_r - 1);
        sdramdev_SdramCntl0_rfshCntr_x = sdramdev_SdramCntl0_rfshCntr_r;
    end
    else begin
        sdramdev_SdramCntl0_refTimer_x = 391;
        sdramdev_SdramCntl0_rfshCntr_x = (sdramdev_SdramCntl0_rfshCntr_r + 1);
    end
    sdramdev_SdramCntl0_cmd_x = 7;
    sdramdev_SdramCntl0_state_x = sdramdev_SdramCntl0_state_r;
    sdramdev_SdramCntl0_sAddr_x = sdramdev_SdramCntl0_sAddr_r;
    sdramdev_SdramCntl0_activeBank_x = sdramdev_SdramCntl0_activeBank_r;
    sdramdev_SdramCntl0_sDataDir_x = sdramdev_SdramCntl0_sDataDir_r;
    for (index=0; index<(2 ** 2); index=index+1) begin
        sdramdev_SdramCntl0_activeFlag_x[index] = sdramdev_SdramCntl0_activeFlag_r[index];
        sdramdev_SdramCntl0_activeRow_x[index] = sdramdev_SdramCntl0_activeRow_r[index];
    end
    if ((sdramdev_SdramCntl0_timer_r != 0)) begin
        sdramdev_SdramCntl0_timer_x = (sdramdev_SdramCntl0_timer_r - 1);
        sdramdev_SdramCntl0_cmd_x = 7;
    end
    else begin
        sdramdev_SdramCntl0_timer_x = sdramdev_SdramCntl0_timer_r;
        case (sdramdev_SdramCntl0_state_r)
            3'b000: begin
                sdramdev_SdramCntl0_timer_x = 1000;
                sdramdev_SdramCntl0_state_x = 3'b001;
            end
            3'b001: begin
                sdramdev_SdramCntl0_cmd_x = 2;
                sdramdev_SdramCntl0_timer_x = 1;
                sdramdev_SdramCntl0_state_x = 3'b011;
                sdramdev_SdramCntl0_sAddr_x = 512;
                sdramdev_SdramCntl0_rfshCntr_x = 8;
            end
            3'b011: begin
                sdramdev_SdramCntl0_cmd_x = 1;
                sdramdev_SdramCntl0_timer_x = 4;
                sdramdev_SdramCntl0_rfshCntr_x = (sdramdev_SdramCntl0_rfshCntr_r - 1);
                if ((sdramdev_SdramCntl0_rfshCntr_r == 1)) begin
                    sdramdev_SdramCntl0_state_x = 3'b010;
                end
            end
            3'b010: begin
                sdramdev_SdramCntl0_cmd_x = 0;
                sdramdev_SdramCntl0_timer_x = 2;
                sdramdev_SdramCntl0_state_x = 3'b100;
                sdramdev_SdramCntl0_sAddr_x = 48;
            end
            3'b100: begin
                if ((sdramdev_SdramCntl0_rfshCntr_r != 0)) begin
                    if (((sdramdev_SdramCntl0_activateInProgress_s == 1'b0) && (sdramdev_SdramCntl0_writeInProgress_s == 1'b0) && (sdramdev_SdramCntl0_rdInProgress_s == 1'b0))) begin
                        sdramdev_SdramCntl0_cmd_x = 2;
                        sdramdev_SdramCntl0_timer_x = 1;
                        sdramdev_SdramCntl0_state_x = 3'b110;
                        sdramdev_SdramCntl0_sAddr_x = 512;
                        for (index=0; index<(2 ** 2); index=index+1) begin
                            sdramdev_SdramCntl0_activeFlag_x[index] = 1'b0;
                        end
                    end
                end
                else if ((sdramdev_SdramCntl0_host_intf_rd_i == 1'b1)) begin
                    if ((sdramdev_SdramCntl0_ba_x == sdramdev_SdramCntl0_ba_r)) begin
                        if ((sdramdev_SdramCntl0_doActivate_s == 1'b1)) begin
                            if (((sdramdev_SdramCntl0_activateInProgress_s == 1'b0) && (sdramdev_SdramCntl0_writeInProgress_s == 1'b0) && (sdramdev_SdramCntl0_rdInProgress_s == 1'b0))) begin
                                sdramdev_SdramCntl0_cmd_x = 2;
                                sdramdev_SdramCntl0_timer_x = 1;
                                sdramdev_SdramCntl0_state_x = 3'b101;
                                sdramdev_SdramCntl0_sAddr_x = 0;
                                sdramdev_SdramCntl0_activeFlag_x[sdramdev_SdramCntl0_bank_s] = 1'b0;
                            end
                        end
                        else if ((sdramdev_SdramCntl0_rdInProgress_s == 1'b0)) begin
                            sdramdev_SdramCntl0_cmd_x = 5;
                            sdramdev_SdramCntl0_sDataDir_x = 1'b0;
                            sdramdev_SdramCntl0_sAddr_x = sdramdev_SdramCntl0_col_s;
                            sdramdev_SdramCntl0_rdPipeline_x = {1'b1, sdramdev_SdramCntl0_rdPipeline_r[(3 + 2)-1:1]};
                        end
                    end
                end
                else if ((sdramdev_SdramCntl0_host_intf_wr_i == 1'b1)) begin
                    if ((sdramdev_SdramCntl0_ba_x == sdramdev_SdramCntl0_ba_r)) begin
                        if ((sdramdev_SdramCntl0_doActivate_s == 1'b1)) begin
                            if (((sdramdev_SdramCntl0_activateInProgress_s == 1'b0) && (sdramdev_SdramCntl0_writeInProgress_s == 1'b0) && (sdramdev_SdramCntl0_rdInProgress_s == 1'b0))) begin
                                sdramdev_SdramCntl0_cmd_x = 2;
                                sdramdev_SdramCntl0_timer_x = 1;
                                sdramdev_SdramCntl0_state_x = 3'b101;
                                sdramdev_SdramCntl0_sAddr_x = 0;
                                sdramdev_SdramCntl0_activeFlag_x[sdramdev_SdramCntl0_bank_s] = 1'b0;
                            end
                        end
                        else if ((sdramdev_SdramCntl0_rdInProgress_s == 1'b0)) begin
                            sdramdev_SdramCntl0_cmd_x = 4;
                            sdramdev_SdramCntl0_sDataDir_x = 1'b1;
                            sdramdev_SdramCntl0_sAddr_x = sdramdev_SdramCntl0_col_s;
                            sdramdev_SdramCntl0_wrPipeline_x = 5'h1;
                            sdramdev_SdramCntl0_wrTimer_x = 2;
                        end
                    end
                end
                else begin
                    sdramdev_SdramCntl0_cmd_x = 7;
                    sdramdev_SdramCntl0_state_x = 3'b100;
                end
            end
            3'b101: begin
                sdramdev_SdramCntl0_cmd_x = 3;
                sdramdev_SdramCntl0_timer_x = 1;
                sdramdev_SdramCntl0_state_x = 3'b100;
                sdramdev_SdramCntl0_rasTimer_x = 3;
                sdramdev_SdramCntl0_sAddr_x = sdramdev_SdramCntl0_row_s;
                sdramdev_SdramCntl0_activeBank_x = sdramdev_SdramCntl0_bank_s;
                sdramdev_SdramCntl0_activeRow_x[sdramdev_SdramCntl0_bank_s] = sdramdev_SdramCntl0_row_s;
                sdramdev_SdramCntl0_activeFlag_x[sdramdev_SdramCntl0_bank_s] = 1'b1;
            end
            3'b110: begin
                sdramdev_SdramCntl0_cmd_x = 1;
                sdramdev_SdramCntl0_timer_x = 4;
                sdramdev_SdramCntl0_state_x = 3'b100;
                sdramdev_SdramCntl0_rfshCntr_x = (sdramdev_SdramCntl0_rfshCntr_r - 1);
            end
            default: begin
                sdramdev_SdramCntl0_state_x = 3'b000;
            end
        endcase
    end
end


always @(posedge sdramdev_clk, posedge sdramdev_sdramdevfsm0_host_intf_rst_i) begin: TOP_SDRAMDEV_SDRAMCNTL0_SEQ_FUNC
    integer index;
    if (sdramdev_sdramdevfsm0_host_intf_rst_i == 1) begin
        sdramdev_SdramCntl0_cmd_r <= 7;
        sdramdev_SdramCntl0_rdPipeline_r <= 0;
        sdramdev_SdramCntl0_sdramData_r <= 0;
        sdramdev_SdramCntl0_ba_r <= 0;
        sdramdev_SdramCntl0_wrPipeline_r <= 0;
        sdramdev_SdramCntl0_sData_r <= 0;
        sdramdev_SdramCntl0_wrTimer_r <= 0;
        sdramdev_SdramCntl0_rfshCntr_r <= 0;
        sdramdev_SdramCntl0_sAddr_r <= 0;
        sdramdev_SdramCntl0_timer_r <= 0;
        sdramdev_SdramCntl0_activeRow_r[0] <= 0;
        sdramdev_SdramCntl0_activeRow_r[1] <= 0;
        sdramdev_SdramCntl0_activeRow_r[2] <= 0;
        sdramdev_SdramCntl0_activeRow_r[3] <= 0;
        sdramdev_SdramCntl0_activeBank_r <= 0;
        sdramdev_SdramCntl0_refTimer_r <= 391;
        sdramdev_SdramCntl0_state_r <= 3'b000;
        sdramdev_SdramCntl0_rasTimer_r <= 0;
        sdramdev_SdramCntl0_sDataDir_r <= 0;
        sdramdev_SdramCntl0_activeFlag_r[0] <= 0;
        sdramdev_SdramCntl0_activeFlag_r[1] <= 0;
        sdramdev_SdramCntl0_activeFlag_r[2] <= 0;
        sdramdev_SdramCntl0_activeFlag_r[3] <= 0;
    end
    else begin
        sdramdev_SdramCntl0_state_r <= sdramdev_SdramCntl0_state_x;
        sdramdev_SdramCntl0_cmd_r <= sdramdev_SdramCntl0_cmd_x;
        sdramdev_SdramCntl0_sAddr_r <= sdramdev_SdramCntl0_sAddr_x;
        sdramdev_SdramCntl0_sData_r <= sdramdev_SdramCntl0_sData_x;
        sdramdev_SdramCntl0_sDataDir_r <= sdramdev_SdramCntl0_sDataDir_x;
        sdramdev_SdramCntl0_activeBank_r <= sdramdev_SdramCntl0_activeBank_x;
        sdramdev_SdramCntl0_sdramData_r <= sdramdev_SdramCntl0_sdramData_x;
        sdramdev_SdramCntl0_wrPipeline_r <= sdramdev_SdramCntl0_wrPipeline_x;
        sdramdev_SdramCntl0_rdPipeline_r <= sdramdev_SdramCntl0_rdPipeline_x;
        sdramdev_SdramCntl0_ba_r <= sdramdev_SdramCntl0_ba_x;
        sdramdev_SdramCntl0_timer_r <= sdramdev_SdramCntl0_timer_x;
        sdramdev_SdramCntl0_rasTimer_r <= sdramdev_SdramCntl0_rasTimer_x;
        sdramdev_SdramCntl0_refTimer_r <= sdramdev_SdramCntl0_refTimer_x;
        sdramdev_SdramCntl0_wrTimer_r <= sdramdev_SdramCntl0_wrTimer_x;
        sdramdev_SdramCntl0_rfshCntr_r <= sdramdev_SdramCntl0_rfshCntr_x;
        for (index=0; index<(2 ** 2); index=index+1) begin
            sdramdev_SdramCntl0_activeRow_r[index] <= sdramdev_SdramCntl0_activeRow_x[index];
            sdramdev_SdramCntl0_activeFlag_r[index] <= sdramdev_SdramCntl0_activeFlag_x[index];
        end
    end
end


always @(sdramdev_SdramCntl0_cmd_r, sdramdev_SdramCntl0_sData_r, sdramdev_SdramCntl0_sAddr_r, sdramdev_SdramCntl0_bank_s, sdramdev_SdramCntl0_sDataDir_r) begin: TOP_SDRAMDEV_SDRAMCNTL0_SDRAM_PIN_MAP
    sdramdev_SdramCntl0_sd_intf_cke = 1;
    sdramdev_SdramCntl0_sd_intf_cs = 0;
    sdramdev_SdramCntl0_sd_intf_ras = sdramdev_SdramCntl0_cmd_r[2];
    sdramdev_SdramCntl0_sd_intf_cas = sdramdev_SdramCntl0_cmd_r[1];
    sdramdev_SdramCntl0_sd_intf_we = sdramdev_SdramCntl0_cmd_r[0];
    sdramdev_SdramCntl0_sd_intf_bs = sdramdev_SdramCntl0_bank_s;
    sdramdev_SdramCntl0_sd_intf_addr = sdramdev_SdramCntl0_sAddr_r;
    if ((sdramdev_SdramCntl0_sDataDir_r == 1'b1)) begin
        sdramdev_SdramCntl0_sDriver = sdramdev_SdramCntl0_sData_r;
    end
    else begin
        sdramdev_SdramCntl0_sDriver = 'bz;
    end
    sdramdev_SdramCntl0_sd_intf_dqml = 0;
    sdramdev_SdramCntl0_sd_intf_dqmh = 0;
end



assign sdramdev_SdramCntl0_host_intf_done_o = (sdramdev_SdramCntl0_rdPipeline_r[0] || sdramdev_SdramCntl0_wrPipeline_r[0]);
assign sdramdev_SdramCntl0_host_intf_data_o = sdramdev_SdramCntl0_sdramData_r;
assign sdramdev_SdramCntl0_host_intf_rdPending_o = sdramdev_SdramCntl0_rdInProgress_s;
assign sdramdev_SdramCntl0_sData_x = sdramdev_SdramCntl0_host_intf_data_i;



assign sdramdev_SdramCntl0_bank_s = sdramdev_SdramCntl0_host_intf_addr_i[((2 + 13) + 9)-1:(13 + 9)];
assign sdramdev_SdramCntl0_ba_x = sdramdev_SdramCntl0_host_intf_addr_i[((2 + 13) + 9)-1:(13 + 9)];
assign sdramdev_SdramCntl0_row_s = sdramdev_SdramCntl0_host_intf_addr_i[(13 + 9)-1:9];
assign sdramdev_SdramCntl0_col_s = sdramdev_SdramCntl0_host_intf_addr_i[9-1:0];


always @(sdramdev_SdramCntl0_activeRow_r[0], sdramdev_SdramCntl0_activeRow_r[1], sdramdev_SdramCntl0_activeRow_r[2], sdramdev_SdramCntl0_activeRow_r[3], sdramdev_SdramCntl0_rdPipeline_r, sdramdev_SdramCntl0_bank_s, sdramdev_SdramCntl0_sdramData_r, sdramdev_SdramCntl0_activeBank_r, sdramdev_SdramCntl0_wrTimer_r, sdramdev_SdramCntl0_sd_intf_dq, sdramdev_SdramCntl0_row_s, sdramdev_SdramCntl0_rasTimer_r, sdramdev_SdramCntl0_activeFlag_r[0], sdramdev_SdramCntl0_activeFlag_r[1], sdramdev_SdramCntl0_activeFlag_r[2], sdramdev_SdramCntl0_activeFlag_r[3]) begin: TOP_SDRAMDEV_SDRAMCNTL0_DO_ACTIVE
    if (((sdramdev_SdramCntl0_bank_s != sdramdev_SdramCntl0_activeBank_r) || (sdramdev_SdramCntl0_row_s != sdramdev_SdramCntl0_activeRow_r[sdramdev_SdramCntl0_bank_s]) || (sdramdev_SdramCntl0_activeFlag_r[sdramdev_SdramCntl0_bank_s] == 1'b0))) begin
        sdramdev_SdramCntl0_doActivate_s = 1'b1;
    end
    else begin
        sdramdev_SdramCntl0_doActivate_s = 1'b0;
    end
    if ((sdramdev_SdramCntl0_rdPipeline_r[1] == 1'b1)) begin
        sdramdev_SdramCntl0_sdramData_x = sdramdev_SdramCntl0_sd_intf_dq;
    end
    else begin
        sdramdev_SdramCntl0_sdramData_x = sdramdev_SdramCntl0_sdramData_r;
    end
    if ((sdramdev_SdramCntl0_rasTimer_r != 0)) begin
        sdramdev_SdramCntl0_activateInProgress_s = 1'b1;
    end
    else begin
        sdramdev_SdramCntl0_activateInProgress_s = 1'b0;
    end
    if ((sdramdev_SdramCntl0_wrTimer_r != 0)) begin
        sdramdev_SdramCntl0_writeInProgress_s = 1'b1;
    end
    else begin
        sdramdev_SdramCntl0_writeInProgress_s = 1'b0;
    end
    if ((sdramdev_SdramCntl0_rdPipeline_r[(3 + 2)-1:1] != 0)) begin
        sdramdev_SdramCntl0_rdInProgress_s = 1'b1;
    end
    else begin
        sdramdev_SdramCntl0_rdInProgress_s = 1'b0;
    end
end


always @(posedge sdramdev_clk) begin: TOP_SDRAMDEV_INTERNAL_RESET
    if ((sdramdev_initialized == 1'b0)) begin
        sdramdev_initialized <= (!sdramdev_initialized);
    end
end



assign sdramdev_sdramdevfsm0_host_intf_rst_i = sdramdev_reset;
assign sdramdev_SdramCntl0_host_intf_wr_i = (sdramdev_sdramdevfsm0_wr_enable && (!sdramdev_SdramCntl0_host_intf_done_o));
assign sdramdev_SdramCntl0_host_intf_rd_i = (sdramdev_sdramdevfsm0_rd_enable && (!sdramdev_SdramCntl0_host_intf_done_o));
assign sdramdev_SdramCntl0_host_intf_data_i = sdramdev_sdramdevfsm0_rand_val;
assign sdramdev_SdramCntl0_host_intf_addr_i = sdramdev_sdramdevfsm0_address;
assign o_wb_data = sdramdev_SdramCntl0_host_intf_data_o;


always @(posedge sdramdev_clk) begin: TOP_SDRAMDEV_SDRAMDEVFSM0_SDRAM_TESTER
    if ((sdramdev_reset == 1'b1)) begin
        sdramdev_sdramdevfsm0_error <= 1'b0;
        sdramdev_sdramdevfsm0_test_state <= 2'b01;
    end
    else if ((sdramdev_sdramdevfsm0_test_state == 2'b01)) begin
        sdramdev_sdramdevfsm0_rand_load <= 1;
        // Load the data_i into tmpdata
        // this is the write & read req using wb
        // i_wb_stb & i_wb_we is 1 is a write
        // i_wb_stb & i_wb_we is 0 is a read
        if (((i_wb_stb == 1) && (i_wb_sel == 15))) begin
            o_wb_stall <= 1;
            o_wb_ack <= 0;
            // this is the write req from wb
            // i_wb_we is 1
            if ((i_wb_we == 1)) begin
                sdramdev_sdramdevfsm0_rand_load <= 0;
                sdramdev_sdramdevfsm0_address <= i_wb_addr;
                sdramdev_sdramdevfsm0_rand_enable <= 1;
                // copy the the tmpdata which 
                // is the data_i to tmpdata1
            end
            else begin
                // this is the read req from wb
                sdramdev_sdramdevfsm0_address <= i_wb_addr;
                // wait for read to be done
                if ((sdramdev_SdramCntl0_host_intf_done_o == 0)) begin
                    sdramdev_sdramdevfsm0_rd_enable <= 1;
                end
                else begin
                    o_wb_stall <= 0;
                    o_wb_ack <= 1;
                    sdramdev_sdramdevfsm0_rd_enable <= 0;
                    sdramdev_sdramdevfsm0_test_state <= 2'b10;
                end
            end
            // wait for write to be done
            if ((sdramdev_SdramCntl0_host_intf_done_o == 0)) begin
                sdramdev_sdramdevfsm0_wr_enable <= 1;
                o_wb_stall <= 1;
            end
            else begin
                o_wb_stall <= 0;
                o_wb_ack <= 1;
                sdramdev_sdramdevfsm0_wr_enable <= 0;
                sdramdev_sdramdevfsm0_rd_enable <= 0;
                sdramdev_sdramdevfsm0_rand_enable <= 0;
                sdramdev_sdramdevfsm0_rand_load <= 1;
                sdramdev_sdramdevfsm0_test_state <= 2'b10;
            end
        end
    end
    else begin
        sdramdev_sdramdevfsm0_rand_load <= 1;
        sdramdev_sdramdevfsm0_rand_enable <= 0;
        o_wb_ack <= 0;
        sdramdev_sdramdevfsm0_error <= 1'b0;
        if ((i_wb_stb == 1)) begin
            sdramdev_sdramdevfsm0_test_state <= 2'b01;
        end
    end
end



assign sdramdev_sdramdevfsm0_rand_val = sdramdev_sdramdevfsm0_data_delay0_0_tmpdata1;


always @(posedge sdramdev_clk) begin: TOP_SDRAMDEV_SDRAMDEVFSM0_DATA_DELAY0_0_DELAYED
    if (sdramdev_sdramdevfsm0_rand_load) begin
        sdramdev_sdramdevfsm0_data_delay0_0_tmpdata <= i_wb_data;
    end
    else if (sdramdev_sdramdevfsm0_rand_enable) begin
        sdramdev_sdramdevfsm0_data_delay0_0_tmpdata1 <= sdramdev_sdramdevfsm0_data_delay0_0_tmpdata;
    end
end


always @(posedge clk100MHz) begin: TOP_DIVCLKBY20_0_DIV2
    clk50MHz <= (!clk50MHz);
end

endmodule
