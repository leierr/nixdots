{ config, lib, pkgs, flakeInputs, ... }:
let
  theme = config.dots.theme;
in
{
  config = lib.mkIf config.dots.gui.hyprland.astal.enable {
    environment.systemPackages = [
      (pkgs.stdenvNoCC.mkDerivation {
        pname = "astal-shell";
        version = "unstable-${builtins.currentTime}";
        src = flakeInputs.astalConfig;

        nativeBuildInputs = [
          flakeInputs.ags.packages.${pkgs.system}.default
          pkgs.wrapGAppsHook
          pkgs.gobject-introspection
        ];

        buildInputs = with flakeInputs.astal.packages.${pkgs.system}; [
          astal3
          hyprland
          notifd
          battery
          tray
        ];

        installPhase = ''
          mkdir -p $out/bin
          ags bundle app.ts $out/bin/astal-shell
        '';
      })
      flakeInputs.ags.packages.${pkgs.system}.agsFull
      pkgs.dart-sass
    ];
  };
}
