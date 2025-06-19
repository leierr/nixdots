local lspconfig = require('lspconfig')

-- Format *all* buffers just before they’re written, but **only**
-- use the formatter(s) listed above (won’t block if missing).
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf, lsp_fallback = true })
  end,
})

-- LuaSnip – snippet engine
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load() -- loads friendly-snippets

-- nvim-cmp – completion UI
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  mapping = {
    ["<C-n>"] = vim.keymap.set.select_next_item(),
    ["<C-p>"] = vim.keymap.set.select_prev_item(),
    ["<CR>"] = vim.keymap.set.confirm({ select = false }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer" },
  },
})
