#!/bin/bash
#**************************chgs for sdramscope ************************
#modifications 
# Makefile_autodata
#new files
#sdramscope.txt wbscope.v sdramscope.cpp scopecls.cpp scopecls.h
#buildsdramscope.sh

cp ~/testbuilds/learning_hdl/MyHDL/sdram/Makefile_autodata \
~/testbuilds/catzip_simulation/catzip/auto-data/Makefile

diff ~/testbuilds/learning_hdl/MyHDL/sdram/Makefile_autodata \
~/testbuilds/catzip_simulation/catzip/auto-data/Makefile

cp ~/testbuilds/learning_hdl/MyHDL/sdram/sdramscope.txt \
~/testbuilds/catzip_simulation/catzip/auto-data

diff ~/testbuilds/learning_hdl/MyHDL/sdram/sdramscope.txt \
~/testbuilds/catzip_simulation/catzip/auto-data/sdramscope.txt

cp ~/testbuilds/learning_hdl/MyHDL/sdram/wbscope.v \
~/testbuilds/catzip_simulation/catzip/rtl/catzip

diff ~/testbuilds/learning_hdl/MyHDL/sdram/wbscope.v \
~/testbuilds/catzip_simulation/catzip/rtl/catzip/wbscope.v

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





 
