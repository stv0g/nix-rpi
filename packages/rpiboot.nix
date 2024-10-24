{
  lib,
  stdenv,
  fetchFromGitHub,
  libusb1,
  pkg-config,
}:

stdenv.mkDerivation rec {
  pname = "rpiboot";
  version = "unrelease-20241022";

  src = fetchFromGitHub {
    owner = "raspberrypi";
    repo = "usbboot";
    rev = "d0a2ed95ade02fbc042d325a22e4a7abcaf8fd34";
    hash = "sha256-PImx+EDXoxbOf525cZmOUEQEOvNYVhfanikqziVT8mY=";
  };

  buildInputs = [ libusb1 ];
  nativeBuildInputs = [ pkg-config ];

  patchPhase = ''
    sed -i "s@/usr/@$out/@g" main.c
  '';

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/rpiboot
    cp rpiboot $out/bin
    cp -r msd firmware eeprom-erase mass-storage-gadget* recovery* secure-boot* rpi-imager-embedded $out/share/rpiboot
  '';

  meta = with lib; {
    homepage = "https://github.com/raspberrypi/usbboot";
    changelog = "https://github.com/raspberrypi/usbboot/blob/${version}/debian/changelog";
    description = "Utility to boot a Raspberry Pi CM/CM3/CM4/Zero over USB";
    mainProgram = "rpiboot";
    license = licenses.asl20;
    maintainers = with maintainers; [
      cartr
      flokli
    ];
    platforms = [
      "aarch64-linux"
      "aarch64-darwin"
      "armv7l-linux"
      "armv6l-linux"
      "x86_64-linux"
      "x86_64-darwin"
    ];
  };
}
