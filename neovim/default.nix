{ pkgs, ... }:
let
  neovimFinalPackage = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
    wrapRc = false;
    wrapperArgs = ''--suffix PATH : "${
      pkgs.lib.makeBinPath (with pkgs; [
        # Dependencies
        git ripgrep fd tree-sitter gcc gnumake
        # language servers + linters
        lua-language-server # lua
        nil alejandra # nix
        vscode-langservers-extracted # html, css, scss, javascript, etc
      ])
    }"'';
  };

in {
  home.packages = [ neovimFinalPackage ];

  xdg.configFile."nvim".source = ./.; # symlink “this very folder” - might be: "${./.}"
  xdg.configFile."nvim".recursive = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };
}
