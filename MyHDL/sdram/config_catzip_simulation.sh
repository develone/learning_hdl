#!/bin/bash
rsync -avl --delete ~/catzip ~/testbuilds/catzip_simulation/

rsync -avl --delete ~/icozip ~/testbuilds/

cp ~/testbuilds/learning_hdl/MyHDL/sdram/sdramdev.txt \
~/testbuilds/catzip_simulation/catzip/auto-data

diff ~/testbuilds/learning_hdl/MyHDL/sdram/sdramdev.txt \
~/testbuilds/catzip_simulation/catzip/auto-data/sdramdev.txt


cp ~/testbuilds/learning_hdl/MyHDL/sdram/sdcntl.txt \
~/testbuilds/catzip_simulation/catzip/auto-data

diff ~/testbuilds/learning_hdl/MyHDL/sdram/sdcntl.txt \
~/testbuilds/catzip_simulation/catzip/auto-data/sdcntl.txt

cp ~/testbuilds/learning_hdl/MyHDL/sdram/SdramCntl.v \
~/testbuilds/catzip_simulation/catzip/rtl/catzip

diff ~/testbuilds/learning_hdl/MyHDL/sdram/SdramCntl.v \
~/testbuilds/catzip_simulation/catzip/rtl/catzip/SdramCntl.v

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

cp ~/testbuilds/learning_hdl/MyHDL/sdram/topsdcntl.v \
~/testbuilds/catzip_simulation/catzip/rtl/catzip

diff ~/testbuilds/learning_hdl/MyHDL/sdram/topsdcntl.v \
~/testbuilds/catzip_simulation/catzip/rtl/catzip/topsdcntl.v

cp ~/testbuilds/learning_hdl/MyHDL/sdram/sim_hw_test.sh \
~/testbuilds/catzip_simulation/catzip/sw/host

diff ~/testbuilds/learning_hdl/MyHDL/sdram/sim_hw_test.sh \
~/testbuilds/catzip_simulation/catzip/rtl/catzip/sw/host
