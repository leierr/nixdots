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
            luasnip # snippet engine
            cmp-buffer # cmp source: current buffer words
            cmp-nvim-lsp # cmp source: LSP completions
            cmp-path # cmp source: file paths
            cmp_luasnip # cmp source: LuaSnip snippets
            conform-nvim # on-save formatter runner
            gitsigns-nvim # git hunk signs + actions
            lualine-nvim # lightweight statusline
            nvim-autopairs # auto-insert (), {}, "", etc.
            nvim-cmp # completion menu UI
            nvim-lspconfig # easy LSP-server setup
            nvim-surround # manipulate surroundings (quotes, tags…)
            nvim-treesitter # syntax tree highlighting/objects
            oil-nvim # buffer-style file explorer
            project-nvim # project root detection
            telescope-nvim # fuzzy finder core
            telescope-fzf-native-nvim # native FZF sorter for Telescope
            telescope-undo-nvim # Telescope view of undotree
            vim-fugitive # full-featured Git CLI wrapper
          ];
          extraLuaConfig = builtins.concatStringsSep "\n" [
            (builtins.readFile ./config/nvim/options.lua)
            (builtins.readFile ./config/nvim/popupTerminal.lua)
            (builtins.readFile ./config/nvim/plugins.lua)
            (builtins.readFile ./config/nvim/keymaps.lua)
            (import ./config/nvim/lsp.nix { inherit pkgs; })
            (builtins.readFile completions.lua)
            (import ./config/nvim/fmt.nix { inherit pkgs; })
          ];
        };
      })
    ];

    environment.systemPackages = with pkgs; [ fzf ripgrep fd ];
  };
}
