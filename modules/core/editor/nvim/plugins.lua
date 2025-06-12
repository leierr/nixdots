-- Project roots
require('project_nvim').setup({
  patterns = { '.git', 'flake.nix' },
})

-- Telescope
require('telescope').setup({
  defaults = {
    -- put any layout / sorter tweaks here later
  },
})

require('telescope').load_extension('fzf') -- fast sorter (remove if plugin not installed)
require('telescope').load_extension('projects') -- workspace picker

-- Gitsigns
require('gitsigns').setup({
})

-- lualine
require('lualine').setup {
  options = {
    theme = 'codedark',
  },
  sections = {
    -- git signs integration
    lualine_b = {
      'branch', -- Show current Git branch
      'diff', -- Show added/modified/removed lines (requires gitsigns or git signs backend)
      'diagnostics', -- Optional: show LSP diagnostics
    },
  }
}
