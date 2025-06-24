-- theme
require("kanagawa").setup({
  theme = "wave",
  background = { dark = "wave", light = "lotus" },
  overrides = function(colors)
    return { LineNr = { fg = colors.theme.ui.fg_dim } } -- slightly brighter linenumbers
  end,
})

vim.cmd.colorscheme("kanagawa")

-- lualine setup
require("lualine").setup({ theme = "kanagawa" })

-- telescope setup
require("telescope").setup({
  defaults = {
    layout_config = {
      prompt_position = "top"
    },

    sorting_strategy = "ascending",

    file_ignore_patterns = {
      -- images
      "%.jpe?g$", "%.png$", "%.gif$", "%.svg$",
      -- video / audio
      "%.mp4$", "%.mkv$", "%.webm$", "%.mp3$", "%.wav$", "%.ogg$",
      -- other heavies
      "%.pdf$", "%.zip$", "%.tar$", "%.7z$", "%.iso$",
      -- nono directories
      "%.git/", "%.cache/",
    },

    mappings = {
      i = {
        ["<Esc>"] = require("telescope.actions").close,
        ["<C-d>"] = require("telescope.actions").delete_buffer,
        ["<Tab>"]  = require("telescope.actions").move_selection_next,
        ["<S-Tab>"] = require("telescope.actions").move_selection_previous,
      },
    },
  },

  pickers = {
    find_files = { hidden = false, follow = false },
    live_grep = {
      additional_args = function() return { "--hidden" } end,
    },
  },
})

require("telescope").load_extension("projects")
require("telescope").load_extension("undo")
require("telescope").load_extension("fzf")

-- mini helpers
require("mini.pairs").setup({})
require("mini.splitjoin").setup({})
require("mini.cursorword").setup({})
require("mini.surround").setup({
  mappings = {
    add = "sa", -- Add surrounding in Normal and Visual modes
    delete = "sd", -- Delete surrounding
    replace = "sr", -- Replace surrounding
    find = '',
    find_left = '',
    highlight = '',
    update_n_lines = '',
    suffix_last = '',
    suffix_next = '',
  },
  silent = false, -- remove helper messages shown after idle time
})
require("mini.jump").setup({
  mappings = {
    forward = 'f',
    backward = 'F',
    forward_till = 't',
    backward_till = 'T',
    repeat_jump = ';',
  },
  silent = true,
})

-- treesitter
require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  indent = { enable = true },
  ensure_installed = {}, -- Disable runtime downloads so Nix remains the single source of truth
  sync_install = false,
  auto_install = false,
})

-- oil file explorer
require("oil").setup({
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  watch_for_changes = false,
  git = {
    -- Return true to automatically git add/mv/rm files
    add = function(path) return true end,
    mv = function(src_path, dest_path) return true end,
    rm = function(path) return true end,
  },
})

-- projects setup
require("project_nvim").setup({ patterns = { ".git", "flake.nix" } })

-- gitsigns setup
require('gitsigns').setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "-" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
  signcolumn = true,
})

-- dashboard
local startify = require("alpha.themes.startify")

startify.section.header.val = {
  [[                               __                ]],
  [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
  [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
  [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
  [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
  [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}
startify.file_icons.provider = "devicons"
startify.section.mru_cwd.val = { { type = "padding", val = 0 } } -- disable MRU cwd
startify.section.mru.val[4].val = function() return { startify.mru(1, nil, 15) } end -- reset MRU (non-cwd's) shortcut key index

require("alpha").setup(startify.config)
