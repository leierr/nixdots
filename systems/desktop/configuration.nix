{ pkgs, lib, ... }:
{
  dots.core.privilegeEscalation.noPasswordForWheel = true;
  dots.gui.enable = true;

  # scaling - 1440p
  dots.gui.cursor.size = 32;

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

      # vscodium
      programs.vscode.enable = true;
      programs.vscode.package = pkgs.vscodium;
      programs.vscode.profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide # nix syntax highlighting
          kamikillerto.vscode-colorize # colorize color codes in code
        ];
        userSettings = {
          "editor.tabSize" = 2;
          "editor.insertSpaces" = true;
          "security.workspace.trust.enabled" = false;
          "git.enableSmartCommit" = true;
          "git.autofetch" = true;
          "git.confirmSync" = false;
          "explorer.confirmDelete" = false;
          "explorer.confirmDragAndDrop" = false;
          "colorize.colorized_colors" = ["BROWSERS_COLORS" "HEXA" "RGB" "HSL"];
          "colorize.colorized_variables" = ["CSS"];
          "colorize.exclude" = ["**/.git" "**/.svn" "**/.hg" "**/CVS" "**/.DS_Store" "**/.git" "**/node_modules" "**/bower_components" "**/tmp" "**/dist" "**/tests"];
          "colorize.include" = ["**/*.nix" "**/*.css" "**/*.scss" "**/*.sass" "**/*.less" "**/*.styl"];
        };
      };

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
