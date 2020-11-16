{ config, pkgs, lib, ... }:
{
  users.users.felix = {
    isNormalUser = true;
    home = "/home/felix";
    group = "felix";
    extraGroups = [
      "wheel"
      "adbusers"
      "audio"
      "docker"
      "input"
      "libvirtd"
      "networkmanager"
      "video"
    ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOFx6OLwL9MbkD3mnMsv+xrzZHN/rwCTgVs758SCLG0h felix@thinkman" ];
  };

  users.groups.felix = {
    gid = 1000;
  };
}
