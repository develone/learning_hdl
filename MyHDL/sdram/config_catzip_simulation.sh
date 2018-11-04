#!/bin/bash
#**************************chgs for sdramscope ************************
#modifications 
# Makefile_autodata
#new files
#sdramscope.txt  sdramscope.cpp scopecls.cpp scopecls.h
#buildsdramscope.sh clockpll50,txt
#o_ram_ce_n	--> o_ram_cs_n
#o_ram_oe_n --> o_ram_ras_n
#o_ram_sel --> o_ram_cas_n
cp ~/testbuilds/learning_hdl/MyHDL/sdram/Makefile_autodata \
~/testbuilds/catzip_simulation/catzip/auto-data/Makefile

diff ~/testbuilds/learning_hdl/MyHDL/sdram/Makefile_autodata \
~/testbuilds/catzip_simulation/catzip/auto-data/Makefile

cp ~/testbuilds/learning_hdl/MyHDL/sdram/sdramscope.txt \
~/testbuilds/catzip_simulation/catzip/auto-data

diff ~/testbuilds/learning_hdl/MyHDL/sdram/sdramscope.txt \
~/testbuilds/catzip_simulation/catzip/auto-data/sdramscope.txt


cp ~/testbuilds/learning_hdl/MyHDL/sdram/sdramscope.cpp \
~/testbuilds/catzip_simulation/catzip/sw/host

diff ~/testbuilds/learning_hdl/MyHDL/sdram/sdramscope.cpp \
~/testbuilds/catzip_simulation/catzip/sw/host/sdramscope.cpp


cp ~/testbuilds/learning_hdl/MyHDL/sdram/sdramscope.cpp \
~/testbuilds/catzip_simulation/catzip/sw/host

diff ~/testbuilds/learning_hdl/MyHDL/sdram/sdramscope.cpp \
~/testbuilds/catzip_simulation/catzip/sw/host/sdramscope.cpp

cp ~/testbuilds/learning_hdl/MyHDL/sdram/scopecls.cpp \
~/testbuilds/catzip_simulation/catzip/sw/host/

diff ~/testbuilds/learning_hdl/MyHDL/sdram/scopecls.cpp \
~/testbuilds/catzip_simulation/catzip/sw/host/scopecls.cpp

cp ~/testbuilds/learning_hdl/MyHDL/sdram/scopecls.h \
~/testbuilds/catzip_simulation/catzip/sw/host/

diff ~/testbuilds/learning_hdl/MyHDL/sdram/scopecls.h \
~/testbuilds/catzip_simulation/catzip/sw/host/scopecls.h

cp ~/testbuilds/learning_hdl/MyHDL/sdram/buildsdramscope.sh \
~/testbuilds/catzip_simulation/catzip/sw/host/

diff ~/testbuilds/learning_hdl/MyHDL/sdram/buildsdramscope.sh \
~/testbuilds/catzip_simulation/catzip/sw/host/buildsdramscope.sh

cp ~/testbuilds/learning_hdl/MyHDL/sdram/clockpll50.txt \
~/testbuilds/catzip_simulation/catzip/auto-data/

diff ~/testbuilds/learning_hdl/MyHDL/sdram/clockpll50.txt \
~/testbuilds/catzip_simulation/catzip/auto-data/clockpll50.txt

#cp ~/testbuilds/learning_hdl/MyHDL/sdram/wbscope.v \
#~/testbuilds/catzip_simulation/catzip/rtl/catzip

#diff ~/testbuilds/learning_hdl/MyHDL/sdram/wbscope.v \
#~/testbuilds/catzip_simulation/catzip/rtl/catzip/wbscope.v



 
