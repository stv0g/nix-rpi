# nix-rpi: Playground for trusted boot and updates on Raspberry Pis using NixOS

WIP: Ongoing work to integrate and test the following features on Raspberry Pi 5 using NixOS:

- General system hardening
- Secure Boot
  - [Raspberry Pi specific](https://github.com/raspberrypi/usbboot/blob/master/secure-boot-recovery5/README.md)
- Measured Boot
  - using u-boot & systemd-boot
  - using Infineon SLB9670 TPM 2.0 module ([LetsTrust TPM](https://letstrust.de/))
- Firmware Updates
  - using systemd-sysupdate
- Remote Attestation
  - using Linux IMA
  - using ACME `device-attest-01` challenge, Smallstep's step-ca?

## Required Hardware

- [Raspberry Pi 5](https://buyzero.de/products/raspberry-pi-5)
- [Raspberry Pi Debug Probe](https://buyzero.de/products/raspberry-pi-debug-probe?_pos=1&_sid=dffa5e890&_ss=r)
- [LetsTrust TPM Module](https://buyzero.de/collections/andere-platinen/products/letstrust-hardware-tpm-trusted-platform-module)

## ToDo

- u-boot is missing drivers for Raspberry Pi 5's RP1 GPIO's / SPI which is required to get the TPM working

## References

- https://x86.lol/generic/2024/08/28/systemd-sysupdate.html
- https://apalos.github.io/EFI%20TCG2%20protocol%20in%20U-Boot%20and%20QEMU.html
- https://github.com/joholl/rpi4-uboot-tpm
- https://github.com/blitz/sysupdate-playground
- https://forums.raspberrypi.com/viewtopic.php?t=358584
