{config, lib, pkgs, ...}:

with lib;
let cfg = config.modules.discord;

in {
  
  options.modules.discord = {enable = mkEnableOption "discord"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      webcord
    ];
  };

}
