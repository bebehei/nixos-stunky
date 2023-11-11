{ config, pkgs, inputs, ... }:
{
  nix = {
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";

    settings = {
      trusted-users = [
        "root"
        "@wheel"
      ];
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
      warn-dirty = false
    '';

    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      unstable.flake = inputs.nixpkgs-unstable;
    };
  };
  nixpkgs.config.allowUnfree = true;

  # auto upgrade with own flakes
  system.autoUpgrade = {
    enable = true;
    flake = "github:Stunkymonkey/nixos";
  };

  environment.systemPackages = with pkgs; [
    nix-index
    nix-prefetch
    nix-update
    nixpkgs-fmt
    nixpkgs-hammering
    nixpkgs-review
  ];
}
