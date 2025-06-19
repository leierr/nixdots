{ pkgs }:
let
  luaLS = "${pkgs.lua-language-server}/bin/lua-language-server";
  bashLS = "${pkgs.bash-language-server}/bin/bash-language-server";
  nixLS = "${pkgs.nil}/bin/nil";
  tsLS = "${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server";
in
''
local lspconfig = require('lspconfig')

-- Lua
lspconfig.lua_ls.setup({ cmd = { '${luaLS}' } })

-- Bash
lspconfig.bashls.setup({ cmd = { '${bashLS}', 'start' } })

-- Nix
lspconfig.nil_ls.setup { cmd = { '${nixLS}' } }

-- TypeScript / JavaScript
lspconfig.tsserver.setup({ cmd = { '${tsLS}', '--stdio' } })
''
