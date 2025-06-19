{ pkgs }:
let
  luaFmt = "${pkgs.stylua}/bin/stylua";
  shFmt = "${pkgs.shfmt}/bin/shfmt"; bashFmt = shFmt;
  nixFmt = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
  jsTsFmt = "${pkgs.nodePackages.prettier}/bin/prettier";
in
''
-- formatting plugin
require("conform").setup{
  formatters_by_ft = {
    lua = { '${luaFmt}' },
    sh = { '${shFmt}' },
    bash = { '${bashFmt}' },
    nix = { '${nixFmt}' },
    javascript = { '${jsTsFmt}' },
    typescript = { '${jsTsFmt}' },
  },
}
''
