#!/bin/bash
rsync -avl --delete ~/catzip ~/testbuilds/catzip_simulation/

#rsync -avl --delete ~/icozip ~/testbuilds/

cp ~/testbuilds/learning_hdl/MyHDL/sdram/sdramdev.txt \
~/testbuilds/catzip_simulation/catzip/auto-data

diff ~/testbuilds/learning_hdl/MyHDL/sdram/sdramdev.txt \
~/testbuilds/catzip_simulation/catzip/auto-data/sdramdev.txt

cp ~/testbuilds/learning_hdl/MyHDL/sdram/catzip.pcf \
~/testbuilds/catzip_simulation/catzip/rtl/catzip

diff ~/testbuilds/learning_hdl/MyHDL/sdram/catzip.pcf \
~/testbuilds/catzip_simulation/catzip/rtl/catzip/catzip.pcf

cp ~/testbuilds/learning_hdl/MyHDL/sdram/wbsdram.v \
~/testbuilds/catzip_simulation/catzip/rtl/catzip

diff ~/testbuilds/learning_hdl/MyHDL/sdram/wbsdram.v \
~/testbuilds/catzip_simulation/catzip/rtl/catzip/wbsdram.v

cp ~/testbuilds/learning_hdl/MyHDL/sdram/Makefile_autodata \
~/testbuilds/catzip_simulation/catzip/auto-data/Makefile

diff ~/testbuilds/learning_hdl/MyHDL/sdram/Makefile_autodata \
~/testbuilds/catzip_simulation/catzip/auto-data/Makefile

cp ~/testbuilds/learning_hdl/MyHDL/sdram/sdramsim.* \
~/testbuilds/catzip_simulation/catzip/sim/verilated

diff ~/testbuilds/learning_hdl/MyHDL/sdram/sdramsim.cpp \
~/testbuilds/catzip_simulation/catzip/sim/verilated/sdramsim.cpp

diff ~/testbuilds/learning_hdl/MyHDL/sdram/sdramsim.h \
~/testbuilds/catzip_simulation/catzip/sim/verilated/sdramsim.h

cp ~/testbuilds/learning_hdl/MyHDL/sdram/sim_hw_test.sh \
~/testbuilds/catzip_simulation/catzip/sw/host/

diff ~/testbuilds/learning_hdl/MyHDL/sdram/sim_hw_test.sh \
~/testbuilds/catzip_simulation/catzip/sw/host/sim_hw_test.sh

cp ~/testbuilds/learning_hdl/MyHDL/sdram/test_sim102218.sh \
~/testbuilds/catzip_simulation/catzip/sw/host/

diff ~/testbuilds/learning_hdl/MyHDL/sdram/test_sim102218.sh \
~/testbuilds/catzip_simulation/catzip/sw/host/test_sim102218.sh

cp ~/testbuilds/learning_hdl/MyHDL/sdram/Makefile_verilated \
~/testbuilds/catzip_simulation/catzip/sim/verilated/Makefile

diff ~/testbuilds/learning_hdl/MyHDL/sdram/Makefile_verilated \
~/testbuilds/catzip_simulation/catzip/sim/verilated/Makefile
#**************************chgs for sdramscope ************************
#modifications 
#hexbus.cpp hexbus.h Makefile_sw_host Makefile_autodata
#new files
#sdramscope.txt sdramscope.cpp scopecls.h flashid.cpp spixscope.cpp
#

cp ~/testbuilds/learning_hdl/MyHDL/sdram/sdramscope.txt \
~/testbuilds/catzip_simulation/catzip/auto-data

diff ~/testbuilds/learning_hdl/MyHDL/sdram/sdramscope.txt \
~/testbuilds/catzip_simulation/catzip/auto-data/sdramscope.txt

cp ~/testbuilds/learning_hdl/MyHDL/sdram/sdramscope.cpp \
~/testbuilds/catzip_simulation/catzip/sw/host

diff ~/testbuilds/learning_hdl/MyHDL/sdram/sdramscope.cpp \
~/testbuilds/catzip_simulation/catzip/sw/host/sdramscope.cpp


cp ~/testbuilds/learning_hdl/MyHDL/sdram/Makefile_sw_host \
~/testbuilds/catzip_simulation/catzip/sw/host/Makefile

diff ~/testbuilds/learning_hdl/MyHDL/sdram/Makefile_sw_host \
~/testbuilds/catzip_simulation/catzip/sw/host/Makefile

cp ~/testbuilds/learning_hdl/MyHDL/sdram/scopecls.h \
~/testbuilds/catzip_simulation/catzip/sw/host/

diff ~/testbuilds/learning_hdl/MyHDL/sdram/scopecls.h \
~/testbuilds/catzip_simulation/catzip/sw/host/scopecls.h

cp ~/testbuilds/learning_hdl/MyHDL/sdram/flashid.cpp \
~/testbuilds/catzip_simulation/catzip/sw/host/

diff ~/testbuilds/learning_hdl/MyHDL/sdram/flashid.cpp \
~/testbuilds/catzip_simulation/catzip/sw/host/flashid.cpp

cp ~/testbuilds/learning_hdl/MyHDL/sdram/spixscope.cpp \
~/testbuilds/catzip_simulation/catzip/sw/host/

diff ~/testbuilds/learning_hdl/MyHDL/sdram/spixscope.cpp \
~/testbuilds/catzip_simulation/catzip/sw/host/spixscope.cpp

cp ~/testbuilds/learning_hdl/MyHDL/sdram/hexbus.* \
~/testbuilds/catzip_simulation/catzip/sw/host/

diff ~/testbuilds/learning_hdl/MyHDL/sdram/hexbus.cpp \
~/testbuilds/catzip_simulation/catzip/sw/host/hexbus.cpp

diff ~/testbuilds/learning_hdl/MyHDL/sdram/hexbus.h \
~/testbuilds/catzip_simulation/catzip/sw/host/hexbus.h
