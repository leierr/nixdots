{ config, lib, pkgs, ... }:
let
  cfg = config.dots.core.editor;
in
{
  options.dots.core.editor = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "configuration of the system default terminal editor (e.g. sets $EDITOR)";
    };

    program = lib.mkOption {
      type = lib.types.enum [ "nvim" ];
      default = "nvim";
      description = "Editor program to configure";
    };
  };

  imports = [
    ./neovim
  ];
}
