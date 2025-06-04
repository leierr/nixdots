{ config, lib, pkgs, ... }:
let
  theme = config.dots.theme;
  # Function to generate SCSS variable declarations from theme attributes
  nixThemeToScssVariables = lib.concatStrings (lib.mapAttrsToList
    (name: value:
      if lib.isString value && builtins.match "^#[0-9a-fA-F]{6}" value != null then ''
        ''$${name}: ${value};
      '' else ""
    )
    theme);
in
{
  config = lib.mkIf config.dots.gui.hyprland.ags.enable {
    home-manager.sharedModules = [
      ({
        #home.file.".config/ags" = {
        #  source = ./config;
        #  recursive = true;
        #};

        home.file.".config/ags/style/nix_theme.scss".text = nixThemeToScssVariables;
      })
    ];

    environment.systemPackages = with pkgs; [
      ags
      astal.astal3
      astal.astal4
      astal.hyprland
      astal.notifd
      astal.tray
      dart-sass
    ];
  };
}
