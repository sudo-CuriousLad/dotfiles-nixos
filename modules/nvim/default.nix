{  lib, config, pkgs, ... }:
with lib;
let
    cfg = config.modules.nvim;
    # Source my theme
    jabuti-nvim = pkgs.vimUtils.buildVimPlugin {
        name = "jabuti-nvim";
        src = pkgs.fetchFromGitHub {
            owner = "jabuti-theme";
            repo = "jabuti-nvim";
            rev = "17f1b94cbf1871a89cdc264e4a8a2b3b4f7c76d2";
            sha256 = "sha256-iPjwx/rTd98LUPK1MUfqKXZhQ5NmKx/rN8RX1PIuDFA=";
        };
    };
in {
    options.modules.nvim = { enable = mkEnableOption "nvim"; };
    config = mkIf cfg.enable {

        home.file.".config/nvim/settings.lua".source = ./init.lua;
        
        home.packages = with pkgs; [
            nixfmt # Nix
            sumneko-lua-language-server stylua # Lua
            nodePackages.typescript-language-server
            nodePackages.svelte-language-server
            rust-analyzer
        ];

        programs.neovim = {
            enable = true;
            plugins = with pkgs.vimPlugins; [ 
                vim-nix
                plenary-nvim
                vim-svelte
                vim-javascript
                html5-vim
                coc-nvim
                coc-svelte
                coc-rust-analyzer
                vim-endwise
                auto-pairs
                vim-floaterm
                vim-commentary
                {
                  plugin = vim-closetag;
                  config = "let g:closetag_filenames = '*.html,*.xhtml,*.jsx,*.svelte'";
                }
                {
                  plugin = nvim-ts-autotag;
                  config = "lua require('nvim-ts-autotag').setup()";
                }
                {
                    plugin = jabuti-nvim;
                    config = "colorscheme jabuti";
                }
                {
                    plugin = impatient-nvim;
                    config = "lua require('impatient')";
                }
                {
                    plugin = lualine-nvim;
                    config = "lua require('lualine').setup()";
                }
                {
                    plugin = telescope-nvim;
                    config = "lua require('telescope').setup()";
                }
                {
                    plugin = indent-blankline-nvim;
                    config = "lua require('indent_blankline').setup()";
                }
                {
                    plugin = nvim-lspconfig;
                    config = ''
                        lua << EOF
                        require('lspconfig').rust_analyzer.setup{}
                        require('lspconfig').sumneko_lua.setup{}
                        require('lspconfig').rnix.setup{}
                        require('lspconfig').svelte.setup{}
                        require('lspconfig').tsserver.setup{}
                        EOF
                    '';
                }
                {
                    plugin = nvim-treesitter;
                    config = ''
                    lua << EOF
                    require('nvim-treesitter.configs').setup {
                        highlight = {
                            enable = true,
                            additional_vim_regex_highlighting = false,
                        },
                        autotag = {
                          enable = true,
                          filetypes = {"html", "xml", "jsx", "svelte"},
                        },
                    }
                    EOF
                    '';
                }
            ];

            extraConfig = ''
                luafile ~/.config/nvim/settings.lua
            '';
        };
    };
}
