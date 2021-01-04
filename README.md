# SBFspot-OpenWRT-Cross-Compile-DLINK-DIR-505
Cross compile SBFspot procedure for OpenWRT DLINK DIR-505 router

## 1. Host OS initial settings (Virtual Box Debian 10)

[source for openwrt setup](https://electrosome.com/cross-compile-openwrt-c-program/)

1. login to host operating system as a non root user, e.g. deb10 in my case, and execute:

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

`export STAGING_DIR=/home/ligo/chaos_calmer/staging_dir`

`export TOOLCHAIN_DIR=$STAGING_DIR/toolchain-mips_34kc_gcc-4.8-linaro_uClibc-0.9.33.2`

`export LDCFLAGS=$TOOLCHAIN_DIR/usr/lib`

`export LD_LIBRARY_PATH=$TOOLCHAIN_DIR/usr/lib`

`export PATH=$TOOLCHAIN_DIR/bin:$PATH`

2. now run `source /bin/openwrt.config`
3. 
