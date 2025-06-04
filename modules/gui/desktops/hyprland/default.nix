{ config, lib, pkgs, flakeInputs, ... }:
let
  cfg = config.dots.gui.hyprland;
in
{
  options.dots.gui.hyprland = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.dots.gui.enable;
    };
    hyprpaper.enable = lib.mkOption { type = lib.types.bool; default = cfg.enable; };
    hyprlock.enable = lib.mkOption { type = lib.types.bool; default = cfg.enable; };
    hypridle.enable = lib.mkOption { type = lib.types.bool; default = cfg.enable; };
    ags.enable = lib.mkOption { type = lib.types.bool; default = cfg.enable; };
  };

  imports = [
    ./ags
    ./configuration
    ./rofi
    ./hypridle
    ./hyprlock
    ./hyprpaper
  ];

  config = lib.mkIf cfg.enable {
    # Install
    programs.hyprland.enable = true;
    programs.hyprland.package = flakeInputs.hyprland.packages.${pkgs.system}.hyprland;
    programs.hyprland.portalPackage = flakeInputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;

    # Basic Functionallity
    xdg.portal.config.hyprland.default = [ "hyprland" "gtk" ];
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; # https://github.com/NixOS/nixpkgs/issues/334260

    # Default application suite
    services.gvfs.enable = true; # nautilus functionallity
    services.dbus.packages = [ pkgs.sushi ]; # nautilus functionallity

    environment.systemPackages = with pkgs; [
      nautilus # file explorer
      sushi # file explorer addon
      file-roller # file explorer addon
      grimblast # screenshot utility
      wl-clipboard # wayland clipboard utility
      firefox-bin # browser of choice currently
    ];

    dots.gui.apps.footTerminal.enable = true; # terminal of choice
  };
}
