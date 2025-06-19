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
	    nvim-autopairs
	    nvim-surround
	    nvim-treesitter
	    oil-nvim # file explorer
            lualine-nvim # status line
            project-nvim # vscode style projects
            telescope-nvim telescope-fzf-native-nvim telescope-undo-nvim # telescope
          ];
          extraLuaConfig = builtins.concatStringsSep "\n" [
            (builtins.readFile ./config/nvim/options.lua)
            (builtins.readFile ./config/nvim/plugins.lua)
            (builtins.readFile ./config/nvim/keymaps.lua)
            (builtins.readFile ./config/nvim/popupTerminal.lua)
          ];
        };
      })
    ];

    environment.systemPackages = with pkgs; [ fzf ripgrep fd ];
  };
}
