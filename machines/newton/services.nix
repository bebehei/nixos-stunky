# Deployed services
{ config, ... }:
let
  inherit (config.sops) secrets;
in
{
  sops.secrets = {
    "acme/inwx" = { };
    "borgbackup/password" = { };
    "borgbackup/ssh_key" = { };
    "sso/auth-key" = { };
    "sso/felix/password-hash" = { };
    "sso/felix/totp-secret" = { };
    "paperless/password" = { };
    "nextcloud/password" = {
      owner = config.users.users.nextcloud.name;
    };
    "nextcloud-exporter/password" = {
      owner = config.users.users.nextcloud-exporter.name;
    };
    "freshrss/password" = {
      owner = config.users.users.freshrss.name;
    };
    "photoprism/password" = { };
    "grafana/password" = {
      owner = config.users.users.grafana.name;
    };
    "matrix-bot/password" = {
      owner = config.systemd.services.go-neb.serviceConfig.User;
    };
  };

  # List services that you want to enable:
  my.services = {
    backup = {
      enable = true;
      OnFailureMail = "server@buehler.rocks";
      passwordFile = secrets."borgbackup/password".path;
      sshKeyFile = secrets."borgbackup/ssh_key".path;
      paths = [ "/" ];
    };
    # My own personal homepage
    homepage = {
      enable = true;
    };
    # Dashboard
    homer = {
      enable = true;
    };
    # remote build
    remote-build.enable = true;
    # RSS provider for websites that do not provide any feeds
    rss-bridge = {
      enable = true;
    };
    # voice-chat server
    mumble-server = {
      enable = true;
    };
    # sandbox video game
    # minecraft-server = {
    #   enable = true;
    # };
    # music streaming server
    navidrome = {
      enable = true;
      musicFolder = "/data/music";
    };
    # self-hosted cloud
    nextcloud = {
      enable = true;
      passwordFile = secrets."nextcloud/password".path;
      exporterPasswordFile = secrets."nextcloud-exporter/password".path;
    };
    # document management system
    paperless = {
      enable = true;
      passwordFile = secrets."paperless/password".path;
      settings.PAPERLESS_ADMIN_USER = "felix";
      mediaDir = "/data/docs";
    };
    # RSS aggregator and reader
    freshrss = {
      enable = true;
      defaultUser = "felix";
      passwordFile = secrets."freshrss/password".path;
    };
    # self-hosted git service
    gitea = {
      enable = true;
    };
    # collaborative markdown editor
    hedgedoc = {
      enable = true;
    };
    # a password-generator using the marokov model
    passworts = {
      enable = true;
    };
    # self-hosted photo gallery
    photoprism = {
      enable = true;
      passwordFile = secrets."photoprism/password".path;
      originalsPath = "/data/photos";
      settings = {
        PHOTOPRISM_ADMIN_USER = "felix";
        PHOTOPRISM_SPONSOR = "true";
      };
    };
    ssh-server = {
      enable = true;
    };
    initrd-ssh = {
      enable = true;
    };
    # self-hosted recipe manager
    tandoor-recipes = {
      enable = true;
    };

    prometheus = {
      enable = true;
    };
    alertmanager = {
      enable = true;
    };
    matrix-bot = {
      enable = true;
      PasswortFile = secrets."matrix-bot/password".path;
    };
    grafana = {
      enable = true;
      passwordFile = secrets."grafana/password".path;
    };
    loki = {
      enable = true;
    };
    promtail = {
      enable = true;
    };
    blackbox = {
      enable = true;
    };
    # Webserver
    nginx = {
      enable = true;
      acme = {
        credentialsFile = secrets."acme/inwx".path;
      };
      sso = {
        authKeyFile = secrets."sso/auth-key".path;
        users = {
          felix = {
            passwordHashFile = secrets."sso/felix/password-hash".path;
            totpSecretFile = secrets."sso/felix/totp-secret".path;
          };
        };
        groups = {
          root = [ "felix" ];
        };
      };
    };
  };
}
