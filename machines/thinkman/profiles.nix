# enabled profiles
{ config, lib, ... }:
let
  secrets = config.sops.secrets;
in
{
  my.profiles = {
    "3d-design".enable = true;
    android.enable = true;
    clean.enable = true;
    latex.enable = true;
    printing.enable = true;
    sync.enable = true;
  };
}
