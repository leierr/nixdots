{ pkgs, lib, ... }:
{
  dots.gui.enable = true;

  # overwriting home-manager values
  home-manager.sharedModules = [
    ({
      programs.git.includes = [
        {
          condition = "hasconfig:remote.*.url:git@github.com:**/**";
          contents = {
            user = {
              name = "Lars Smith Eier";
              email = "larssmitheier@gmail.com";
            };
          };
        }
      ];

      # more scaling stuff
      dconf.settings."org/gnome/desktop/interface".text-scaling-factor = 1.1;

      wayland.windowManager.hyprland.settings = {
        general.border_size = lib.mkForce 3;
        windowrulev2 = [ "monitor DP-2, class:^(vesktop)$" ];
        exec-once = [ "vesktop" ];
      };

      programs.ssh = {
        enable = true;
        matchBlocks = {
          "github.com" = {
            hostname = "github.com";
            user = "git";
            identityFile = [ "~/.ssh/id_ed25519" ];
          };
        };
      };

      programs.zsh.shellAliases = {};
    })
  ];

  # GAMING
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true; # udev rules for controllers etc

  # wireguard
  networking.firewall.checkReversePath = false;

  # various packages
  environment.systemPackages = with pkgs; [
    tmux
    wireguard-tools
    unstable.bottles
    age
    sops
    pavucontrol
    fzf
    meld
    obsidian
    fastfetch
    spotify
    brave
    vesktop
    xfce.mousepad
  ];
}
