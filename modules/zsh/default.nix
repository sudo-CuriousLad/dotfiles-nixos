{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.zsh;
in {
    options.modules.zsh = { enable = mkEnableOption "zsh"; };

    config = mkIf cfg.enable {
    	home.packages = [
	    pkgs.zsh
	];

        programs.zsh = {
            enable = true;

            # directory to put config files in
            dotDir = ".config/zsh";

            enableCompletion = true;
            autosuggestion.enable = true;
            syntaxHighlighting.enable = true;

            # .zshrc
            initExtra = ''
                PROMPT="%F{blue}%m %~%b "$'\n'"%(?.%F{green}%Bλ%b |.%F{red}?) %f"

                export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store";
                bindkey '^ ' autosuggest-accept

                edir() { tar -cz $1 | age -p > $1.tar.gz.age && rm -rf $1 &>/dev/null && echo "$1 encrypted" }
                ddir() { age -d $1 | tar -xz && rm -rf $1 &>/dev/null && echo "$1 decrypted" }
            '';

            # Tweak settings for history
            history = {
                save = 1000;
                size = 1000;
                path = "$HOME/.cache/zsh_history";
            };

            # Set some aliases
            shellAliases = {
                c = "clear";
                mkdir = "mkdir -vp";
                rm = "rm -rifv";
                mv = "mv -iv";
                cp = "cp -riv";
                nd = "nix develop -c $SHELL";
                rebuild = "doas nixos-rebuild switch --flake /etc/nixos#zephyr --fast; notify-send 'Rebuild complete\!'";
            };

    };
};
}
