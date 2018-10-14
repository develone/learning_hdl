#!/bin/bash


echo "The date built"
./pc-wbregs version
#sleep 2
#sleep 2
./pc-wbregs 0x1000000 0x10000001
#sleep 2 
./pc-wbregs 0x1000004 0x10000002
#sleep 2
./pc-wbregs 0x1000008 0x10000003
#sleep 2
./pc-wbregs 0x100000c 0x10000004
#sleep 2
#sleep 2
#sleep 2
#sleep 2
#sleep 2 
./pc-wbregs 0x1000000 
#sleep 2 
./pc-wbregs 0x1000004 
#sleep 2
./pc-wbregs 0x1000008 
#sleep 2
./pc-wbregs 0x100000c
#sleep 2
