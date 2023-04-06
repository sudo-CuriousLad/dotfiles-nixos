{config, lib, pkgs, ...}:

with lib;
let cfg = config.modules.steam;

in {
  options.modules.steam = {enable = mkEnableOption "steam"; };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [

      steam

    ];

  };
}
