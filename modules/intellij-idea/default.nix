{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.idea-ultimate;

in {

  ###### interface

  options.modules.idea-ultimate = {
      enable = mkEnableOption "idea-ultimate";
    };

  ###### implementation

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      jetbrains.idea-community androidStudioPackages.dev
    ];

  };

}
