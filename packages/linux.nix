{ linuxManualConfig, ... }:
linuxManualConfig rec {
  version = "6.12-rc4";
  src = fetchTarball {
    url = "https://git.kernel.org/torvalds/t/linux-${version}.tar.gz";
    sha256 = "sha256:0qr5sbpm512rlkylqmqhy644s4lmfr1igvmx8ds0mrb54h3qhkwk";
  };
  configfile = "${src}/arch/arm64/configs/bcm2712_defconfig";
}
