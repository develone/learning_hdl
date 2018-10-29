#!/bin/bash
cd catzip/auto-data
cp ../../../learning_hdl/MyHDL/sdram/sdramdev.txt .
cp ../../../learning_hdl/MyHDL/sdram/sdramscope.txt .
cp ../../../learning_hdl/MyHDL/sdram/Makefile_autodata Makefile 

cd ../rtl/catzip/
cp ../../../../learning_hdl/MyHDL/sdram/wbsdram.v .
cp ../../../../learning_hdl/MyHDL/sdram/catzip.pcf .
cd ../../sim/verilated/
cp ../../../../learning_hdl/MyHDL/sdram/sdramsim.* .
cp ../../../../learning_hdl/MyHDL/sdram/Makefile_verilated Makefile

cd ../../sw/host
cp ../../../../learning_hdl/MyHDL/sdram/Makefile_sw_host Makefile
cp ../../../../learning_hdl/MyHDL/sdram/sdramscope.cpp .
cp ../../../../learning_hdl/MyHDL/sdram/scopecls.h .
cp ../../../../learning_hdl/MyHDL/sdram/flashid.cpp .
cp ../../../../learning_hdl/MyHDL/sdram/spixscope.cpp .
cp ../../../../learning_hdl/MyHDL/sdram/scopecls.cpp .
cp ../../../../learning_hdl/MyHDL/sdram/scopecls.h .
cp ../../../../learning_hdl/MyHDL/sdram/hexbus.cpp .
cp ../../../../learning_hdl/MyHDL/sdram/hexbus.h .
cp ../../../../learning_hdl/MyHDL/sdram/test_sim102218.sh .
cd ../../
git add auto-data/sdramdev.txt
git add auto-data/sdramscope.txt
git add rtl/catzip/wbsdram.v
git add sim/verilated/sdramsim.cpp
git add sim/verilated/sdramsim.h
git add sw/host/flashid.cpp
git add sw/host/scopecls.h
git add sw/host/sdramscope.cpp
git add sw/host/spixscope.cpp
git add sw/host/scopecls.cpp
git add sw/host/scopecls.h
git add sw/host/test_sim102218.sh

