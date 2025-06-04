{ config, lib, pkgs, ... }:
let
  theme = config.dots.theme;
in
{
  config = lib.mkIf config.dots.gui.hyprland.enable {
    environment.systemPackages = with pkgs; [
      # dependencies to run correctly
      rofi-wayland
      hack-font
      papirus-icon-theme
    ];

    home-manager.sharedModules = [
      ( import ./assets/drun.nix )
      ( import ./assets/theme.nix { inherit theme; } )
    ];
  };
}
