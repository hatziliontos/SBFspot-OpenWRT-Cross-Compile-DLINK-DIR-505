# SBFspot-OpenWRT-Cross-Compile-DLINK-DIR-505
Cross compile SBFspot procedure for OpenWRT DLINK DIR-505 router

## 1. Host OS initial openwrt setup (Virtual Box Debian 10)

1. login to host operating system as a non root user, e.g. deb10 in my case, and run:

   `sudo apt update`

   `sudo apt install git-core build-essential libssl-dev libncurses5-dev unzip gawk zlib1g-dev`

   `sudo apt install subversion mercurial`

2. get the latest openwrt version: `git clone https://github.com/openwrt/openwrt.git`
3. `cd openwrt`
4. `./scripts/feeds update -a`
5. `./scripts/feeds install -a`
6. steps 2 - 5 take only a few minutes
7. now `make menuconfig` to choose some basic settings
8. first select the target system, e.g. `DLINK DIR-505`

   ![](https://raw.githubusercontent.com/hatziliontos/SBFspot-OpenWRT-Cross-Compile-DLINK-DIR-505/main/images/Clipboard01.jpg)

9. then go to `Libraries`
10. select `bluez-libs`

    ![](https://raw.githubusercontent.com/hatziliontos/SBFspot-OpenWRT-Cross-Compile-DLINK-DIR-505/main/images/Clipboard02.jpg)

11. just below select `boost` and leave `Boost Options` as it is

    ![](https://raw.githubusercontent.com/hatziliontos/SBFspot-OpenWRT-Cross-Compile-DLINK-DIR-505/main/images/Clipboard03.jpg)

12. go to `Boost libraries` and select `Boost date_time library`

    ![](https://raw.githubusercontent.com/hatziliontos/SBFspot-OpenWRT-Cross-Compile-DLINK-DIR-505/main/images/Clipboard04.jpg)

13. finally, if you want to use `SBFspot` with `sqlite3 database` support, go to `Libraries->Database`, select `libsqlite3` and leave `Configuration` as it is

    ![](https://raw.githubusercontent.com/hatziliontos/SBFspot-OpenWRT-Cross-Compile-DLINK-DIR-505/main/images/Clipboard05.jpg)

14. choose exit and save configuration
15. now do `make V=sc`, it takes a long time to finish (it took me more than 5 hours)
16. after ending compilation my `vdi` file size increased to 23GB (`make` process creates lots of folders and files)

## 2. Host OS cross compilation settings (Virtual Box Debian 10)

1. create the file `/bin/openwrt.config` and place inside:

   `export STAGING_DIR=/home/deb10/chaos_calmer/staging_dir`

   `export TOOLCHAIN_DIR=$STAGING_DIR/toolchain-mips_24kc_gcc-8.4.0_musl`

   `export LDCFLAGS=$TOOLCHAIN_DIR/usr/lib`

   `export LD_LIBRARY_PATH=$TOOLCHAIN_DIR/usr/lib`

   `export PATH=$TOOLCHAIN_DIR/bin:$PATH`

2. `toolchain-mips_24kc_gcc-8.4.0_musl` was created automatically during compilation and it depends on router architecture (e.g. `DLINK DIR-505`)
3. now run `source /bin/openwrt.config`
4. go to `/home/deb10/`
5. download SBFspot source code: `wget https://github.com/SBFspot/SBFspot/archive/V3.7.0.zip`
6. `unzip V3.7.0.zip` to `/home/deb10/SBFspot-3.7.0/` folder
7. in order to successfully compile SBFspot source code we must edit `/home/deb10/SBFspot-3.7.0/SBFspot/makefile`
8. go to `/home/deb10/openwrt/staging_dir/toolchain-mips_24kc_gcc-8.4.0_musl/bin/` and see which cross compile tools have been created by the compilation system: `mips-openwrt-linux-musl-ar`, `mips-openwrt-linux-musl-c++`, `mips-openwrt-linux-musl-g++`, `mips-openwrt-linux-musl-gcc`, etc
9. from `makefile`, make suitable changes to the following lines:

   from `CC = gcc` to `CC = mips-openwrt-linux-musl-gcc`

   from `CXX = g++` to `CXX = mips-openwrt-linux-musl-g++`

   from `AR = ar` to `AR = mips-openwrt-linux-musl-ar`

   from `LD = g++ ` to `LD = mips-openwrt-linux-musl-g++`

10. now we have to tell the cross compile tools where to search for our compiled libraries (`libbluetooth`, `libboost_date_time` and if needed `libsqlite3`, the same with their c++ header files)
11. continue to `INCDIR     := ` and replace with `INCDIR     := /home/deb10/openwrt/build_dir/target-mips_24kc_musl/boost_1_75_0/ipkg-install/include/ /home/deb10/openwrt/build_dir/target-mips_24kc_musl/bluez-5.54/ipkg-install/usr/include/ /home/deb10/openwrt/build_dir/target-mips_24kc_musl/sqlite-autoconf-3330000/ipkg-install/usr/include/`
12. similarly, replace `LIBDIR     :=` with `LIBDIR     := /home/deb10/openwrt/build_dir/target-mips_24kc_musl/boost_1_75_0/ipkg-install/lib/ /home/deb10/openwrt/build_dir/target-mips_24kc_musl/bluez-5.54/ipkg-install/usr/lib/ /home/deb10/openwrt/build_dir/target-mips_24kc_musl/sqlite-autoconf-3330000/ipkg-install/usr/lib/`
13. now run `cd /home/deb10/SBFspot-3.7.0/SBFspot`
14. `make nosql` and
15. `make install_nosql`
16. after `make install_nosql` the compiled files can be found in `/usr/local/bin/sbfspot.3/`
17. the binary file `SBFspot` is not executable on Host OS, it must be transfered to Target OS (e.g. DLINK DIR-505) along with all related files (cross compiled libraries included, watch inside the 3 LIBDIR directories for compiled libraries)
18. in case of a missing library, the Target OS will complain about it

## 3. Target OS results (DLINK DIR-505)

1. in my case, the `DLINK DIR-505` complained only about missing `libboost_date_time.so`, `libbluetooth.so` and `libsqlite3.so` had been previously installed by other means for different purposes, e.g. by openwrt GUI package manager
2. one solution is to transfer the compiled `libboost_date_time.so` inside `/usr/lib/`
3. a second solution is to use openwrt GUI package manager, search for the library and press `install` button
4. `SBFspot` on this system takes 5-6 secs to return a full daily report (e.g. `./SBFspot -finq -v5`)

[source: basic info for openwrt setup](https://electrosome.com/cross-compile-openwrt-c-program/)
