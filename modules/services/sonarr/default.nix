# manages and downloads series
{ config, lib, pkgs, ... }:
let
  cfg = config.my.services.sonarr;
  domain = config.networking.domain;
  port = 8989;
in
{
  options.my.services.sonarr = with lib; {
    enable = mkEnableOption "Sonarr for series management";
  };

  config = lib.mkIf cfg.enable {
    services.sonarr = {
      enable = true;
    };

    systemd.services.sonarr = {
      after = [ "network-online.target" ];
    };

    my.services.nginx.virtualHosts = [
      {
        subdomain = "series";
        inherit port;
      }
    ];

    my.services.exportarr.sonarr = {
      port = port + 1;
      url = "http://127.0.0.1:${toString port}";
    };

    webapps.apps.sonarr = {
      dashboard = {
        name = "Series";
        category = "media";
        icon = "tv";
        link = "https://series.${domain}";
      };
    };
  };
}
