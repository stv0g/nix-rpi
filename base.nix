{
  imports = [
    ./modules/boot.nix
    ./modules/filesystems.nix
    ./modules/generic.nix
    ./modules/minimize.nix
    ./modules/network.nix
    ./modules/partitions.nix
    ./modules/sysupdate.nix
  ];

  system.image.version = "1";
}
