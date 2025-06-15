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
            telescope-nvim telescope-fzf-native-nvim # telescope
            project-nvim # vscode style projects
            gitsigns-nvim vim-fugitive # git
            lualine-nvim # status line
            yazi-nvim # file manager
            leap-nvim # advanced movement
          ];
          extraLuaConfig = builtins.concatStringsSep "\n" [
            (builtins.readFile ./config.lua)
            (builtins.readFile ./plugins.lua)
            (builtins.readFile ./keymaps.lua)
          ];
        };
      })
    ];

    environment.systemPackages = [ pkgs.ripgrep ];
  };
}
