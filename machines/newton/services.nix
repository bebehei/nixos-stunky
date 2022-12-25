# Deployed services
{ config, lib, ... }:
let
  secrets = config.sops.secrets;
in
{
  sops.secrets."acme/inwx" = { };
  sops.secrets."sso/auth-key" = { };
  sops.secrets."sso/felix/password-hash" = { };
  sops.secrets."sso/felix/totp-secret" = { };
  sops.secrets."paperless/password" = { };
  sops.secrets."nextcloud/password" = { };
  sops.secrets."nextcloud/password".owner = config.users.users.nextcloud.name;

  # List services that you want to enable:
  my.services = {
    # My own personal homepage
    homepage = {
      enable = true;
    };
    # Dashboard
    homer = {
      enable = true;
    };
    # RSS provider for websites that do not provide any feeds
    rss-bridge = {
      enable = true;
    };
    # voice-chat server
    mumble-server = {
      enable = true;
    };
    # sandbox video game
    minecraft-server = {
      enable = true;
    };
    # music streaming server
    navidrome = {
      enable = true;
      musicFolder = "/srv/data/music";
    };
    # self-hosted cloud
    nextcloud = {
      enable = true;
      passwordFile = secrets."nextcloud/password".path;
    };
    # document management system
    paperless = {
      enable = true;
      passwordFile = secrets."paperless/password".path;
      extraConfig.PAPERLESS_ADMIN_USER = "felix";
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
    ssh-server = {
      enable = true;
    };
    # self-hosted recipe manager
    tandoor-recipes = {
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