{ config, pkgs, lib, ... }:
with lib;
let
  flake-compat = builtins.fetchTarball {
    url = "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
    sha256 = "1prd9b1xx8c0sfwnyzkspplh30m613j42l1k789s521f4kv4c2z2";
  };
  spicetify-nix =
    (import flake-compat {
      src = builtins.fetchTarball {
        url = "https://github.com/the-argus/spicetify-nix/archive/master.tar.gz";
        sha256 = "1ri60f2v1sz6wwqcp97hqhb0bbynfkg5155kxp7kmchhp4g8ayz8";
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
      theme = spicePkgs.themes.catppuccin-mocha;
      colorScheme = "flamingo";

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle # shuffle+ (special characters are sanitized out of ext names)
        hidePodcasts
        brokenAdblock
      ];
    };

  };
}
