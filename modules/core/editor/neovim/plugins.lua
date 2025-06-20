-- lualine setup
require("lualine").setup({
  options = {
    theme = "codedark",
  },
})

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
      },
    },
  },

  pickers = {
    find_files = { hidden = true, follow = false },
    live_grep = {
      additional_args = function() return { "--hidden" } end,
    },
  },
})

require("telescope").load_extension("projects")
require("telescope").load_extension("undo")
require("telescope").load_extension("fzf")

-- autopairs setup
require("nvim-autopairs").setup { check_ts = true }

-- mini helpers
require('mini.surround').setup({})
require('mini.splitjoin').setup({})

-- treesitter
require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  indent = { enable = true },
  ensure_installed = {}, -- Disable runtime downloads so Nix remains the single source of truth
  sync_install = false,
  auto_install = false,
})

-- yazi
require("oil").setup({})

-- projects setup
require("project_nvim").setup({
  patterns = { ".git", "flake.nix" }
})

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
