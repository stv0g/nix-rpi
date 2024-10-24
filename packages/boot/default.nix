{
  runCommand,
  raspberrypifw,
  pkgsCross,
  rpiboot,
  dtc,
  ubootTools,
}:
let
  uboot = pkgsCross."aarch64-multiplatform".rpi5-uboot-tpm;

  rpifw = raspberrypifw.overrideAttrs (old: {
    meta = old.meta // {
      broken = false;
    };
  });

  dts = ./overlays/soft-spi.dts;
  dtbo = runCommand "soft-spi-dtbo" { } ''
    ${dtc}/bin/dtc -O dtb -b 0 -@ ${dts} -o $out
  '';

  scr = ./boot.scr;
  uimg = runCommand "boot.scr.uimg" { } ''
    ${ubootTools}/bin/mkimage -A arm64 -T script -C none -n "Boot script" -d ${scr} $out
  '';
in
runCommand "boot" { } ''
  mkdir -p $out/overlays

  # For usbboot only
  cp ${rpiboot}/share/rpiboot/firmware/bootfiles.bin $out

  cp ${rpifw}/share/raspberrypi/boot/bcm2712-rpi-5-b.dtb $out
  cp ${uboot}/u-boot.bin $out
  cp ${./config.txt} $out/config.txt
  cp ${./cmdline.txt} $out/cmdline.txt
  cp ${dtbo} $out/overlays/soft-spi.dtbo
  cp ${uimg} $out/boot.scr.uimg
''
