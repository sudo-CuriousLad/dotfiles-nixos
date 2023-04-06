{config, lib, pkgs, ...}:

with lib;
let cfg = config.modules.obs-studio;

in {

  options.modules.obs-studio = { enable = mkEnableOption "obs-studio";};

  config = mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
        obs-vkcapture
      ];
    };
  };
}
