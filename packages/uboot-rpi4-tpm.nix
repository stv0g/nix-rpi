{ ubootRaspberryPi4_64bit, ... }:
ubootRaspberryPi4_64bit.overrideAttrs {
  extraConfig = ''
    DM_SPI=y
    SOFT_SPI=y
    TPM=y
    TPM_V2=y
    TPM2_TIS_SPI=y
    CMD_TPM_V2=y
    CMD_EFIDEBUG=y
  '';
}
