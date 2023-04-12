{ pkgs, lib, config, ... }:

with lib;
let cfg = 
    config.modules.packages;
    screen = pkgs.writeShellScriptBin "screen" ''${builtins.readFile ./screen}'';
    bandw = pkgs.writeShellScriptBin "bandw" ''${builtins.readFile ./bandw}'';
    maintenance = pkgs.writeShellScriptBin "maintenance" ''${builtins.readFile ./maintenance}'';

in {
    options.modules.packages = { enable = mkEnableOption "packages"; };
    config = mkIf cfg.enable {
    	home.packages = with pkgs; [
            ripgrep ffmpeg 
            exa htop fzf
            pass gnupg bat
            unzip 
            grim slurp slop
            imagemagick age libnotify
            git python3 lua 
            mpv pqiv
            screen bandw maintenance
            wf-recorder gnome-solanum
        ];
    };
}
