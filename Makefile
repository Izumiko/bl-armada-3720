#toolchain: 
#arm-gnu-toolchain-11.3.rel1-x86_64-aarch64-none-linux-gnu
#arm-gnu-toolchain-11.3.rel1-x86_64-arm-none-linux-gnueabihf

PWD := $(shell pwd)

DEFCFG := mvebu_catdrive-88f3720_defconfig
DTB := armada-3720-catdrive

DDR := $(PWD)/mv-ddr-marvell
A3700_TOOLS := $(PWD)/A3700-utils-marvell
BL33 := $(PWD)/u-boot-marvell/u-boot.bin

MAKE_ARCH := make CROSS_COMPILE=aarch64-none-linux-gnu- CROSS_CM3=arm-none-linux-gnueabihf-

all: uboot atf

prepare:
	cd patches && sh patch.sh

uboot-config: prepare
	$(MAKE_ARCH) -C u-boot-marvell $(DEFCFG)

uboot: uboot-config
	$(MAKE_ARCH) -C u-boot-marvell DEVICE_TREE=$(DTB)

atf: uboot
	$(MAKE_ARCH) -C atf-marvell ENABLE_LTO=1 \
		MV_DDR_PATH=$(DDR) WTP=$(A3700_TOOLS) BL33=$(BL33) \
		CRYPTOPP_LIBDIR=/usr/lib/ \
		CRYPTOPP_INCDIR=/usr/include/crypto++/ \
		CLOCKSPRESET=CPU_1000_DDR_800 DDR_TOPOLOGY=0 \
		BOOTDEV=SPINOR PARTNUM=0 PLAT=a3700 DEBUG=0 \
		USE_COHERENT_MEM=0 LOG_LEVEL=20 SECURE=0 \
		all fip mrvl_bootimage mrvl_flash mrvl_uart

clean:
	$(MAKE_ARCH) -C u-boot-marvell clean
	$(MAKE_ARCH) -C atf-marvell distclean
