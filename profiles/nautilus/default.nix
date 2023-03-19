{ config, lib, pkgs, ... }:
let
  cfg = config.my.profiles.nautilus;
in
{
  options.my.profiles.nautilus = with lib; {
    enable = mkEnableOption "nautilus profile";
  };

  config = lib.mkIf cfg.enable {
    # enable trash & network-mount
    services.gvfs.enable = true;

    environment.sessionVariables.NAUTILUS_4_EXTENSION_DIR = "${config.system.path}/lib/nautilus/extensions-4";
    environment.pathsToLink = [
      "/share/nautilus-python/extensions"
    ];

    services.gnome.glib-networking.enable = true; # network-mount

    # default-programms
    xdg.mime.enable = true;
    xdg.icons.enable = true;

    environment.systemPackages = with pkgs; [
      gnome.nautilus

      ffmpegthumbnailer # thumbnails
      gnome.nautilus-python # enable plugins
      gst_all_1.gst-libav # thumbnails
      nautilus-open-any-terminal # terminal-context-entry
    ];
  };
}
