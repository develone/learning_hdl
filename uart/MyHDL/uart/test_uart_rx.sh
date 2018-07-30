#!/bin/bash

python uart_rx.py

yosys < syn_uart_rx.ys

