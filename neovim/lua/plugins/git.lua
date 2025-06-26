local function has_dirty_real_buffers()
  for _, buf in ipairs(vim.fn.getbufinfo({ bufloaded = 1 })) do
    if buf.changed == 1 and buf.buftype == '' and buf.listed == 1 then
      return true
    end
  end
  return false
end

local function commit_and_push()
  vim.cmd('G fetch origin')

  if has_dirty_real_buffers() then
    local ans = vim.fn.confirm(
      'Unsaved buffers – write before committing?', '&Yes\n&No', 1
    )
    if ans ~= 1 then
      vim.notify('Aborted: unsaved files', vim.log.levels.WARN)
      return
    end
    vim.cmd('wall')
  end

  vim.cmd('G add --all')

  vim.ui.input({ prompt = 'Commit message: ' }, function(msg)
    if not msg or msg == '' then
      vim.notify('Aborted: empty commit message', vim.log.levels.WARN)
      return
    end
    vim.cmd('G commit -m ' .. vim.fn.shellescape(msg))
    vim.cmd('G push')
  end)
end

return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "+" },   -- Additions (typically green)
        change       = { text = "~" },   -- Modifications (typically blue/yellow)
        delete       = { text = "-" },   -- Deletions (typically red)
        topdelete    = { text = "‾" },   -- Deletion at top of file
        changedelete = { text = "~" },   -- Changed then deleted
        untracked    = { text = "┆" },   -- Untracked lines (or use "?" if preferred)
      },
    };
  },
  {
    "tpope/vim-fugitive",
    init = function() -- expose helpers **before** keymaps.lua runs
      package.loaded["git.custom-functions"] = {
        commit_and_push = commit_and_push,
      }
    end,
  },
}
