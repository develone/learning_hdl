starting with a clean catzip
commit 1e0dd38e890187ae3d6629fd35ddeeaad39a6701
Author: Edward Vidal Jr <develone@sbcglobal.net>
Date:   Mon Aug 13 02:04:34 2018 +0000
git clone https://github.com/develone/catzip.git
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
cp ../../../../learning_hdl/MyHDL/sdram/hexbus.cpp .
cp ../../../../learning_hdl/MyHDL/sdram/hexbus.h
cp ../../../../learning_hdl/MyHDL/sdram/test_sim102218.sh .
Four shells w/path set
/home/pi/verilator
/home/pi/verilator/bin:/home/pi/zipcpu/sw/install/cross-tools/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games
catzip/myenv.sh

pi@mypi3-3:~/testbuilds/tmp/catzip $ 
pi@mypi3-3:~/testbuilds/tmp/catzip $ make datestamp
pi@mypi3-3:~/testbuilds/tmp/catzip $ make autodata

pi@mypi3-3:~/testbuilds/tmp/catzip/rtl/catzip $
pi@mypi3-3:~/testbuilds/tmp/catzip/rtl/catzip $ make clean
pi@mypi3-3:~/testbuilds/tmp/catzip/rtl/catzip $ make cpudefs.h
pi@mypi3-3:~/testbuilds/tmp/catzip/rtl/catzip $ make design.h
pi@mypi3-3:~/testbuilds/tmp/catzip/rtl/catzip $ make verilated
pi@mypi3-3:~/testbuilds/tmp/catzip/rtl/catzip $ make bin
write_txt catzip.asc...
icepack catzip.asc catzip.bin
icetime -d hx8k -c 50 catzip.asc
// Reading input .asc file..
// Reading 8k chipdb file..
// Creating timing netlist..
// Timing estimate: 19.19 ns (52.11 MHz)
// Checking 20.00 ns (50.00 MHz) clock constraint: PASSED.

pi@mypi3-3:~/testbuilds/tmp/catzip/sw/host $ 
pi@mypi3-3:~/testbuilds/tmp/catzip/sw/host $ make clean
pi@mypi3-3:~/testbuilds/tmp/catzip/sw/host $ make


pi@mypi3-3:~/testbuilds/tmp/catzip/sim/verilated $
pi@mypi3-3:~/testbuilds/tmp/catzip/sim/verilated $ make clean
pi@mypi3-3:~/testbuilds/tmp/catzip/sim/verilated $ make

Transfer new build to RPi with catboard
pi@mypi3-1:~/testbuilds/testcatzipmypi3-3 $ rsync -avl --delete mypi3-3:~/testbuilds/tmp/catzip .

pi@mypi3-1:~/testbuilds/testcatzipmypi3-3/catzip/sw/host $ sudo config_cat  ../../rtl/catzip/catzip.bin

pi@mypi3-1:~/testbuilds/testcatzipmypi3-3/catzip/sw/host $ ./arm-netpport 
Listening on port 8363
Listening on port 8364

pi@mypi3-1:~/testbuilds/testcatzipmypi3-3/catzip/sw/host $ ./test_sim102218.sh 
00c00010 ( VERSION) : [...%] 20181025
02000004 (        )-> 55aaaa55
02000004 (        ) : [.u.u] aa75aa75
020ffff8 (        )-> 55aaaa55
020ffff8 (        ) : [.u.u] aa75aa75
02800004 (        )-> 55aaaa55
02800004 (        ) : [.u.u] aa75aa75
028ffff8 (        )-> 55aaaa55
028ffff8 (        ) : [.u.u] aa75aa75
02c00004 (        )-> 55aaaa55
02c00004 (        ) : [.u.u] aa75aa75
02cffff8 (        )-> 55aaaa55
02cffff8 (        ) : [.u.u] aa75aa75
02f00004 (        )-> 55aaaa55
02f00004 (        ) : [.u.u] aa75aa75
02fffff8 (        )-> 55aaaa55
02fffff8 (        ) : [.u.u] aa75aa75 
