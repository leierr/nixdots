{ config, pkgs, lib, ... }:
let
  cfg = config.dots.overlays.vesktop;
in
{
  options.dots.overlays.vesktop.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "vesktop overlay for discord alias";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [
      (final: prev: {
        vesktop = prev.vesktop.overrideAttrs (old: {
          desktopItems = [
            (pkgs.makeDesktopItem {
              name = "discord";
              exec = "vesktop %U";
              icon = "discord";
              desktopName = "Discord";
              genericName = "All-in-one cross-platform voice and text chat for gamers";
              categories = [ "Network" "InstantMessaging" ];
              mimeTypes = [ "x-scheme-handler/discord" ];
            })
          ];
        });
      })
    ];
  };
}
