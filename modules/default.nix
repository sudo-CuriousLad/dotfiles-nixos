{inputs, pkgs, config, ...}:

{
  imports = [
    ./hyprland/default.nix
    ./foot/default.nix
    ./eww/default.nix
    ./nvim/default.nix
    ./firefox/default.nix
    ./wofi/default.nix
    ./zsh/default.nix
    ./intellij-idea/default.nix
    ./obs-studio/default.nix
    ./packages/default.nix
    ./discord/default.nix
    ./steam/default.nix
    ./prism-launcher/default.nix
    ./dunst/default.nix
    ./git/default.nix
    ./spotify/default.nix
  ];
}

