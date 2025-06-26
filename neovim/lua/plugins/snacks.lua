return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    statuscolumn = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1, limit = 10 },
        { section = "startup" },
      },
    },
    terminal = {
      enabled = true,
      start_insert = true,
      auto_insert = true,
      auto_close = false, -- keep terminal open in the background
      win = {
        position = "float",
        width = 0.8,
        height = 0.8,
        border = "rounded",
        -- Keys
        keys = {
          {
            "<Esc>",
            function(self)
              self.timer = self.timer or (vim.uv or vim.loop).new_timer()

              if self.timer:is_active() then
                self.timer:stop()
                vim.api.nvim_feedkeys(
                  vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "t", false
                )
              else
                self.timer:start(200, 0, function()
                  vim.schedule(function() self:hide() end)
                end)
              end
            end,
            mode = "t",
            desc = "<Esc>: hide | <Esc><Esc>: normal mode",
          },
        },
        -- buffer & window options
        bo = { filetype = "snacks_terminal" },
        wo = { cursorline = false },
      },
    },
  },
}
