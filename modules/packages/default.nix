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
            eza htop fzf 
            gnupg bat
            unzip 
            grim slurp 
            libnotify
            git python3 lua 
            mpv 
            screen bandw maintenance
            wf-recorder 
            # davinci-resolve
            obsidian
            vscode
            brave
            buttercup-desktop tmux
            ocs-url kdePackages.kclock
            krita affine  
            gsettings-desktop-schemas glib 
            wacomtablet libwacom speechd 
            lzip cachix

        ];

    };
}
