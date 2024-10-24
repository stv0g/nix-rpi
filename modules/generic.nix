{ pkgs, config, ... }:
{
  # TODO Is there a way to override these?
  #system.nixos.release = "2024-08";
  #system.nixos.codeName = "Babylon";

  system.nixos.distroId = "applianceos";
  system.nixos.distroName = "ApplianceOS";

  # Make the current system version visible in the prompt.
  programs.bash.promptInit = ''
    export PS1="\u@\h (version ${config.system.image.version}) $ "
  '';

  # Not compatible with system.etc.overlay.enable yet.
  # users.mutableUsers = false;

  services.getty.autologinUser = "root";

  boot.initrd.systemd.enable = true;

  # Don't accumulate crap.
  boot.tmp.cleanOnBoot = true;
  services.journald.extraConfig = ''
    SystemMaxUse=10M
  '';

  # Debugging
  environment.systemPackages = with pkgs; [
    parted
    (runCommand "systemd-sysupdate" { } ''
      mkdir -p $out/bin
      ln -s ${config.systemd.package}/lib/systemd/systemd-sysupdate $out/bin
    '')
  ];

  system.stateVersion = "24.11";
}
