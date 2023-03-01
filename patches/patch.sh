#!/bin/sh

cp ./mvebu_catdrive-88f3720_defconfig ../u-boot-marvell/configs/mvebu_catdrive-88f3720_defconfig
cp ./armada-3720-catdrive.dts ../u-boot-marvell/arch/arm/dts/armada-3720-catdrive.dts
cd ../u-boot-marvell && patch -N -p1 < ../patches/uboot.patch
exit 0
