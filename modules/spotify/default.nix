{ config, pkgs, lib, ... }:
with lib;
let
  flake-compat = builtins.fetchTarball {
    url = "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
    sha256 = "0m9grvfsbwmvgwaxvdzv6cmyvjnlww004gfxjvcl806ndqaxzy4j";
  };
  spicetify-nix =
    (import flake-compat {
      src = builtins.fetchTarball {
        url = "https://github.com/the-argus/spicetify-nix/archive/master.tar.gz";
        sha256 = "0yvkw9i3xk0qn1j01b4mnj912p55zi1v3fdsy77jy3pz8zxfll4h";
      };
    })
    .defaultNix;
    spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
  cfg = config.modules.spotify;
in
{
  options.modules.spotify = {enable = mkEnableOption "spotify";};

  # configure spicetify :)
  config = mkIf cfg.enable {
    programs.spicetify =
      {
      enable = true;
      theme = {
        name = "catppuccin";
        appendName = true;
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "spicetify";
          rev = "dc3d4b24dcdd2fc3a8aa716d6280047c1928c029";
          sha256 = "sha256-XqsPnr0BiTHKgz6G6YOPT8+iSJMxkKHD2MEJBVdZk6w=";
        };
        injectCss = true;
        replaceColors = true;
        overwriteAssets = true;
        sidebarConfig = false;
      }; 
      colorScheme = "mocha";

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle # shuffle+ (special characters are sanitized out of ext names)
        hidePodcasts
        brokenAdblock
      ];
      
    };

  };
}
