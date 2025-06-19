{ pkgs }:
let
  luaLS  = "${pkgs.lua-language-server}/bin/lua-language-server";
  bashLS = "${pkgs.bash-language-server}/bin/bash-language-server";
in
''
local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup({
  cmd = { '${luaLS}' },
  settings = {},
})

lspconfig.bashls.setup({
  cmd = { '${bashLS}', 'start' },
})
''
