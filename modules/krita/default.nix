{config, lib, pkgs, ...}:

with lib;
let cfg = config.modules.krita;

{
  options.modules.krita = {enable = mkEnableOption "krita";};

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      krita
    ];

  };
}
