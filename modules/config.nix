{config, lib, inputs, ...}:

{
  imports = [./default.nix];
  config.modules = {
    hyprland.enable = false   ; 
    foot.enable = true; 
    eww.enable = false; 
    nvim.enable = true; 
    firefox.enable = true;  
    wofi.enable = true; 
    zsh.enable = true;  
    idea-ultimate.enable = true;
    obs-studio.enable = true  ;
    packages.enable = true; 
    discord.enable = true;  
    steam.enable = true;  
    prism-launcher.enable = true;
    dunst.enable = true;  
    git.enable = true;  
    spotify.enable = true;  
    direnv.enable=true; 
    langs.enable=true;  
    vscode.enable=true; 
    # krita.enable=false;   

    ### PowerSave
    # hyprland.enable = false;
    # foot.enable = true;
    # eww.enable = false;
    # nvim.enable = false;
    # firefox.enable = true;
    # wofi.enable = false;
    # zsh.enable = true;
    # idea-ultimate.enable = false;
    # obs-studio.enable = true;
    # packages.enable = true;
    # discord.enable = true;
    # steam.enable = false;  
    # prism-launcher.enable = false;
    # dunst.enable = true;
    # git.enable = false;
    # spotify.enable = true;
    # direnv.enable=true;
    # langs.enable=false;
    # vscode.enable=true;
    # krita.enable=false;
  };
  
}
