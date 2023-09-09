# bl-armada-3720
U-boot/ATF for armada-3720-catdrive

## 参考资料

H大的[猫盘 (ARMADA A3720) 刷机教程](https://www.jianshu.com/p/77e529fb35f9)
Trusted Firmware-A的文档，[UART BOOT的部分](https://trustedfirmware-a.readthedocs.io/en/latest/plat/marvell/armada/uart-booting.html)

## 刷机

### 使用 Marvell Wtpdownloader (Wtptp)刷机/救砖

在Linux环境下，解压uart-images.tgz.bin，并执行以下命令。其中`<port#>`对应USB转TTL线的ID。

```shell
stty -F /dev/ttyUSB<port#> clocal
./WtpDownload_linux -P UART -C <port#> -E -B TIM_ATF.bin -I wtmi_h.bin -I boot-image_h.bin
```

执行完成后，立即打开`/dev/ttyUSB<port#>`上的终端来查看启动输出日志。

### 使用mox-imager刷机

mox-imager可以使用`flash-image.bin`或者从`uart-images.tgz.bin`解压出的三个文件进行刷机。

执行以下命令，详细参数见[官方说明](https://gitlab.nic.cz/turris/mox-imager)

```shell
./mox-imager -D /dev/ttyUSB<port#> -E -b 6000000 -t flash-image.bin
```
或
```shell
./mox-imager -D /dev/ttyUSB<port#> -E -b 6000000 -t TIM_ATF.bin wtmi_h.bin boot-image_h.bin
```
