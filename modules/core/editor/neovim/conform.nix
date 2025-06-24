{ pkgs }:
let
  shFmtCmd = "${pkgs.shfmt}/bin/shfmt";
in
''
require("conform").setup({
  formatters_by_ft = {
    sh = { "shfmt" },
    bash = { "shfmt" },
  },
  formatters = {
    shfmt = {
      command = "${shFmtCmd}",
      prepend_args = { "-i", "2" },
    },
  },
})
''
