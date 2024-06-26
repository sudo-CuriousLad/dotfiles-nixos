{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.hyprland;

in {
    options.modules.hyprland= { enable = mkEnableOption "hyprland"; };

    config = mkIf cfg.enable {
	home.packages = with pkgs; [
	    wofi swaybg wlsunset wl-clipboard
	];

        wayland.windowManager.hyprland = {
          enable = false;
            extraConfig = builtins.readFile ./hyprland.conf ;
        };
	
    };
    
    
}
