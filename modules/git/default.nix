{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.git;

in {
    options.modules.git = { enable = mkEnableOption "git"; };
    config = mkIf cfg.enable {
        programs.git = {
          enable = true;
          userName = "sudo-CuriousLad";
          userEmail = "curiousladmc@protonmail.com";
            extraConfig = {
                init = { defaultBranch = "main"; };
            };
        };
        programs.gh = {
            enable = true;
            gitCredentialHelper.enable = true;
        };
    };
}
