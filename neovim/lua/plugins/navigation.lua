return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      watch_for_changes = true,
      git = {
        -- Return true to automatically git add/mv/rm files
        add = function(path) return true end,
        mv = function(src_path, dest_path) return true end,
        rm = function(path) return true end,
      },

      keymaps = { ["<Esc>"] = { "actions.close", mode = "n" } },
    },
  },
  {
    "folke/flash.nvim",
    opts = {
      jump = { autojump = false },
      label = {
        uppercase = false,
        style = "inline",
        min_pattern_length = 2,
        rainbow = { enabled = true },
      },
      highlight = {
        backdrop = false,
      },
      modes = {
        search = { enabled = false },
        char = { enabled = false },
      },
    },
  },
}
