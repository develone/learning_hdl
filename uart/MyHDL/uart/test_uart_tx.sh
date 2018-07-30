#!/bin/bash

python uart_tx.py

yosys < syn_uart_tx.ys

