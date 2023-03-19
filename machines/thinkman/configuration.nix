{ config, pkgs, lib, ... }:
{
  imports = [
    ./disks.nix
    ./hardware-configuration.nix
    ./services.nix
    ./profiles.nix
    ./system.nix
    ../../legacy/modules/bluetooth-audio.nix
    ../../legacy/modules/desktop-default.nix
    ../../legacy/modules/desktop-development.nix
    ../../legacy/modules/development.nix
    ../../legacy/modules/filesystem.nix
    ../../legacy/modules/gaming.nix
    ../../legacy/modules/hardware-base.nix
    ../../legacy/modules/intel-video.nix
    ../../legacy/modules/media.nix
    ../../legacy/modules/meeting.nix
    ../../legacy/modules/systemd-user.nix
    ../../legacy/modules/systemduefi.nix
    ../../legacy/modules/webcam.nix
  ];

  networking.hostName = "thinkman";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    gnupg.sshKeyPaths = [ ];
  };

  nix.extraOptions = ''
    extra-platforms = aarch64-linux i686-linux
  '';
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  system = {
    stateVersion = "22.11";
    autoUpgrade.enable = true;
  };
}
