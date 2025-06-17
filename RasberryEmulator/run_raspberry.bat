@echo off
"c:\Program Files\qemu\qemu-system-aarch64.exe" ^
-M raspi3b ^
-cpu cortex-a53 ^
-m 1G -smp 4 ^
-kernel kernel8.img ^
-sd "2025-05-13-raspios-bookworm-arm64-lite.img" ^
-dtb bcm2710-rpi-3-b-plus.dtb ^
-append "rw earlyprintk loglevel=8 console=ttyAMA0,115200 dwc_otg.lpm_enable=0 root=/dev/mmcblk0p2 rootdelay=1" ^
-serial stdio ^
-usb -device usb-mouse -device usb-kbd ^
-device usb-net,netdev=net0 ^
-netdev user,id=net0,hostfwd=tcp::5555-:22
echo QEMU is finished
pause