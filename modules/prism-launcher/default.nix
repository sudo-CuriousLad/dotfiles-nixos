{config, lib, pkgs, ...}:

with lib;
let cfg = config.modules.prism-launcher;

in {
  
  options.modules.prism-launcher = {enable = mkEnableOption "prism-launcher";};

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      prismlauncher
    ];
  };

}
