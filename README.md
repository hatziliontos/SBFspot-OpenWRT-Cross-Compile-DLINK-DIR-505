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
8. first select the target system, e.g. DLINK DIR-505

9. 

