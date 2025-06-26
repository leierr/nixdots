{ pkgs, ... }:
let
  neovimFinalPackage = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
    wrapRc = false;
    wrapperArgs = ''--suffix PATH : "${
      pkgs.lib.makeBinPath (with pkgs; [
        git ripgrep fd fzf tree-sitter
        lua-language-server nil alejandra
        vscode-langservers-extracted
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
