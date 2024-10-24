{
  writeShellScriptBin,
  rpiboot,
  boot,
}:
writeShellScriptBin "usbboot" ''
  ${rpiboot}/bin/rpiboot -v -o -l -d ${boot}
''
