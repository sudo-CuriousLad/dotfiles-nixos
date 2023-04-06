{config, lib, inputs, ...}:

{
  imports = [./default.nix];
  config.modules = {
    hyprland.enable = true;
    foot.enable = true;
    eww.enable = true;
    nvim.enable = true;
    firefox.enable = true;
    wofi.enable = true;
    zsh.enable = true;
    idea-ultimate.enable = true;
    obs-studio.enable = true;
    packages.enable = true;
    discord.enable = true;
    steam.enable = true;
    prism-launcher.enable = true;
    dunst.enable = true;
    git.enable = true;
  };
  
}
