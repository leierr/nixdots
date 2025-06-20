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
            cmp-buffer # cmp source: words from current buffer
            cmp-nvim-lsp # cmp source: LSP completions
            cmp-path # cmp source: file paths
            cmp_luasnip # cmp source: LuaSnip snippets
            gitsigns-nvim # Git hunks in signcolumn
            lspkind-nvim # icons & labels for cmp menu
            lualine-nvim # lightweight statusline
            luasnip # snippet engine
            mini-surround
            mini-splitjoin
            nvim-autopairs # auto-insert (), {}, "", etc.
            nvim-cmp # completion popup UI
            nvim-lspconfig # simple LSP-server setup helper
            nvim-treesitter # AST-based highlighting/objects
            nvim-treesitter.withAllGrammars
            nvim-web-devicons # nerd font
            project-nvim # project-root detection
            telescope-fzf-native-nvim # native FZF sorter for Telescope
            telescope-nvim # fuzzy finder core
            telescope-undo-nvim # Telescope view of undo-tree
            vim-fugitive # full-featured Git CLI wrapper
            oil-nvim
          ];
          extraLuaConfig = builtins.concatStringsSep "\n" [
            (builtins.readFile ./options.lua)
            (builtins.readFile ./popupTerminal.lua)
            (builtins.readFile ./helpers.lua)
            (builtins.readFile ./plugins.lua)
            (builtins.readFile ./keymaps.lua)
            (import ./lsp.nix { inherit pkgs; })
            (builtins.readFile ./completions.lua)
          ];
        };
      })
    ];

    environment.systemPackages = with pkgs; [
      fzf
      ripgrep
      fd
    ];
  };
}
