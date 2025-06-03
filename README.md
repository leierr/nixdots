# REFACTOR PLAN

1. this exsists:

```nix
config = lib.mkIf cfg.enable {
  home-manager.sharedModules = [
    ({ pkgs, ... }: {
      programs.git.enable = true;
    })
  ];
};
```

2. nixfmt

```bash
nix run nixpkgs#nixpkgs-fmt -- .
nix run nixpkgs#nixpkgs-fmt -- --check .
```

3. Replace bad language in comments

4. Don’t reference config.option inside options = { … }

5. Set lib.mkEnableOption "…", not just ""

6. Switch to kebab-case in filenames - keep camelCase for everything else

7. Move modules to new structure:

```
modules/
  desktop/
    desktops/          # hyprland, gnome …
    apps/              # vesktop, firefox …
    theme/             # gtk, cursors …
  base/
    core/              # boot-loader, users, time…
    services/          # bluetooth, printing…
    apps/              # htop, git, neovim…
  shared/
    overlays/
    lib/
```

8. 

---

Ha AI sjekke for camelCase