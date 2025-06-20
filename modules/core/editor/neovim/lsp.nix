{ pkgs }:
let
  luaLS = "${pkgs.lua-language-server}/bin/lua-language-server";
  bashLS = "${pkgs.bash-language-server}/bin/bash-language-server";
  nixLS = "${pkgs.nil}/bin/nil";
  tsLS = "${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server";
  yamlLS = "${pkgs.yaml-language-server}/bin/yaml-language-server";
  jsonLS = "${pkgs.vscode-langservers-extracted}/bin/vscode-json-language-server";
  cssLS  = "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
  htmlLS = "${pkgs.vscode-langservers-extracted}/bin/vscode-html-language-server";
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
lspconfig.ts_ls.setup({ cmd = { '${tsLS}', '--stdio' } })

-- YAML
lspconfig.yamlls.setup({ cmd = { '${yamlLS}', '--stdio' } })

-- JSON
lspconfig.jsonls.setup({ cmd = { '${jsonLS}', '--stdio' } })

-- HTML
lspconfig.html.setup({ cmd = { '${htmlLS}', '--stdio' } })

-- CSS / SCSS
lspconfig.cssls.setup({ cmd = { '${cssLS}', '--stdio' } })
''
