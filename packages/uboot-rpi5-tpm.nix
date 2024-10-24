{ buildUBoot, ... }:
buildUBoot {
  defconfig = "rpi_arm64_defconfig";

  extraConfig = ''
    CONFIG_AUTOBOOT=n
    CONFIG_USE_PREBOOT=n
    CONFIG_PREBOOT="pci enum; usb start;"

    # Commands
    CONFIG_CMD_EFIDEBUG=y
    CONFIG_CMD_LOG=y

    # Debugging
    CONFIG_CC_OPTIMIZE_FOR_DEBUG=y
    CONFIG_LTO=n
    CONFIG_SEMIHOSTING=y
    CONFIG_SEMIHOSTING_SERIAL=y
    CONFIG_DEBUG_UART_SEMIHOSTING=y
    CONFIG_BCM283X_PL011_SERIAL=n

    CONFIG_LOG_CONSOLE=y
    CONFIG_LOGLEVEL=7
    CONFIG_LOG_MAX_LEVEL=8
    # CONFIG_DEBUG_UART=y

    # GPIO
    CONFIG_CMD_GPIO=y
    CONFIG_CMD_GPIO_READ=y

    # TPM
    # CONFIG_TPM=y
    # CONFIG_TPMv2=y
    # CONFIG_CMD_TPM=y
    # CONFIG_DM_SPI=y
    # CONFIG_SOFT_SPI=y
    # CONFIG_TPM2_TIS_SPI=y

    # CONFIG_MEASURED_BOOT=y
    # CONFIG_EFI_TCG2_PROTOCOL=y
    # CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE=y
    # CONFIG_EFI_TCG2_PROTOCOL_MEASURE_DTB=y
  '';
  extraMeta.platforms = [ "aarch64-linux" ];
  filesToInstall = [
    "u-boot.bin"
    "u-boot" # For debugging in OpenOCD & GDB
  ];
}
