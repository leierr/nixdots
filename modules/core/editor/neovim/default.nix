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
            ## ── Completion ─────────────────────────────────────────────
            nvim-cmp
            cmp-buffer
            cmp-path
            cmp-nvim-lsp
            cmp_luasnip
            ## ── Snippets & Text Objects ────────────────────────────────
            luasnip
            friendly-snippets
            mini-pairs
            mini-splitjoin
            mini-surround
            ## ── LSP, Formatting & Icons ────────────────────────────────
            nvim-lspconfig
            lspkind-nvim
            conform-nvim
            ## ── Syntax Highlighting ────────────────────────────────────
            nvim-treesitter
            nvim-treesitter.withAllGrammars
            ## ── Git Integration ────────────────────────────────────────
            vim-fugitive
            gitsigns-nvim
            ## ── UI & Theme ─────────────────────────────────────────────
            alpha-nvim
            kanagawa-nvim
            lualine-nvim
            nvim-web-devicons
            ## ── Navigation, Search & Projects ─────────────────────────
            oil-nvim
            project-nvim
            telescope-nvim
            telescope-fzf-native-nvim
            telescope-undo-nvim
          ];
          extraLuaConfig = builtins.concatStringsSep "\n" [
            (builtins.readFile ./options.lua)
            (builtins.readFile ./popupTerminal.lua)
            (builtins.readFile ./helpers.lua)
            (builtins.readFile ./plugins.lua)
            (builtins.readFile ./keymaps.lua)
            (import ./lsp.nix { inherit pkgs; })
            (import ./conform.nix { inherit pkgs; })
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
