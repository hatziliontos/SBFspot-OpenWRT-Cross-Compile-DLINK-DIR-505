# SBFspot-OpenWRT-Cross-Compile-DLINK-DIR-505
Cross compile SBFspot procedure for OpenWRT DLINK DIR-505 router

## Host OS settings (Virtual Box Debian 10)

1. login to host operating system as a non root user, e.g. deb10 in my case
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

13. 
