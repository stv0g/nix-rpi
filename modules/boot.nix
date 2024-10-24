{ lib, pkgs, ... }:
let
  linux_rpi5 = pkgs.linux_rpi4.override {
    rpiVersion = 5;
    argsOverride.defconfig = "bcm2712_defconfig";
  };
in
{
  boot = {
    loader.grub.enable = false;
    loader.generic-extlinux-compatible.enable = false;
    consoleLogLevel = lib.mkDefault 7;

    # The serial ports listed here are:
    # - ttyS0: for Tegra (Jetson TX1)
    # - ttyAMA0: for QEMU's -machine virt
    kernelParams = [
      "console=ttyS0,115200n8"
      "console=ttyAMA0,115200n8"
      "console=tty0"
    ];

    kernelPackages = lib.mkDefault (pkgs.linuxPackagesFor linux_rpi5);

    initrd.availableKernelModules = [
      "nvme"
      "usbhid"
      "usb_storage"
    ];

    uki.name = "appliance";
  };
}
