#!/bin/bash
g++ -g -Wall -I. -I../../rtl -c scopecls.cpp -o obj-arm/scopecls.o
g++ -g -Wall -I. -I../../rtl obj-arm/scopecls.o obj-arm/hexbus.o obj-arm/llcomms.o sdramscope.cpp -o sdramscope
