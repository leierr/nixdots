{ config, lib, pkgs, ... }:
let
  cfg = config.dots.core.editor;
in
{
  config = lib.mkIf (cfg.enable && cfg.program == "nvim") {
    programs.neovim = {
      defaultEditor = true;
      enable = true;
    };

    home-manager.sharedModules = [
      ({
        programs.neovim = {
          enable = true;
          defaultEditor = true;
          viAlias = true;
          vimAlias = true;
          plugins = with pkgs.vimPlugins; [
            gitsigns-nvim # Git UI extension
            lualine-nvim # status line
            nvim-autopairs
            nvim-surround
            nvim-treesitter
            oil-nvim # file explorer
            project-nvim # vscode style projects
            telescope-nvim telescope-fzf-native-nvim telescope-undo-nvim # telescope
            vim-fugitive # Git cli extension
            nvim-lspconfig # official lsp-configuration utility
          ];
          extraLuaConfig = builtins.concatStringsSep "\n" [
            (builtins.readFile ./config/nvim/options.lua)
            (builtins.readFile ./config/nvim/popupTerminal.lua)
            (builtins.readFile ./config/nvim/plugins.lua)
            (builtins.readFile ./config/nvim/keymaps.lua)
            (import ./config/nvim/lsp.nix { inherit pkgs; })
          ];
        };
      })
    ];

    environment.systemPackages = with pkgs; [ fzf ripgrep fd ];
  };
}
