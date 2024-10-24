{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    let
      overlay = final: prev: {
        rpi4-uboot-tpm = final.callPackage ./packages/uboot-rpi4-tpm.nix { };
        rpi5-uboot-tpm = final.callPackage ./packages/uboot-rpi5-tpm.nix { };
        rpiboot = final.callPackage ./packages/rpiboot.nix { };
        linux = final.callPackage ./packages/linux.nix { };
        boot = final.callPackage ./packages/boot.nix { };
        boot-from-usb = final.callPackage ./packages/boot-from-usb.nix { };
      };
    in
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
      in
      {
        overlays = {
          default = overlay;
        };

        devShells = {
          default = pkgs.mkShell {
            packages =
              with pkgs;
              [
                openocd
                rpiboot
                boot-from-usb
              ]
              ++ pkgs.lib.optional pkgs.stdenv.isLinux pkgs.gdb;
          };
        };

        packages = {
          inherit (pkgs)
            rpiboot
            linux
            boot-from-usb
            rpi5-uboot-tpm
            ;
        };
      }
    )
    // {
      nixosConfigurations = {
        rpi = nixpkgs.lib.nixosSystem {
          modules = [
            ./base.nix
            {
              nixpkgs.overlays = [ overlay ];
            }
          ];
          system = "aarch64-linux";
        };
      };
    };
}
