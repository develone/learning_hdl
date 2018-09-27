#!/bin/bash


echo "The date built"
./arm-wbregs version
sleep 2
./arm-wbregs 0x0c00000 0x10000001
sleep 2 
./arm-wbregs 0x0c00004 0x10000002
sleep 2
./arm-wbregs 0x0c00008 0x10000003
sleep 2
./arm-wbregs 0x0c0000c 0x10000004
sleep 2
./arm-wbregs 0x0e00000 0x10000001
sleep 2
./arm-wbregs 0x0e00002 0x10000002
sleep 2
./arm-wbregs 0x0e00004 0x10000003
sleep 2
./arm-wbregs 0x0e00006 0x10000004
sleep 2
./arm-wbregs 0x0c00000 
sleep 2
./arm-wbregs 0x0c00004 
sleep 2
./arm-wbregs 0x0c00008 
sleep 2
./arm-wbregs 0x0c0000c
sleep 2 
./arm-wbregs 0x0e00000 
sleep 2
./arm-wbregs 0x0e00002 
sleep 2
./arm-wbregs 0x0e00004 
sleep 2
./arm-wbregs 0x0e00006
sleep 2 
echo "Turning on the 4th led "
./arm-wbregs gpio 0x00010001
sleep 2 
echo "Turning on the 1st led "
./arm-wbregs gpio 0x00020002
sleep 2 
echo "Turning on the 2nd led "
./arm-wbregs gpio 0x00040004
sleep 5
echo "Turning off the leds "
./arm-wbregs gpio 0x00070000
