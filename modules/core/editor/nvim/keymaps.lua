-- Functions
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.cmd('startinsert') -- enter insert mode when I fist launch terminal

    local opts = { buffer = 0 }
    vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('n', '<Esc>', ':bd!<CR>', opts)
  end,
})

local function commit_and_push()
  vim.cmd('G fetch origin')

  if next(vim.fn.getbufinfo({ bufloaded = 1, changed = 1 })) ~= nil then
    -- Show a Yes / No dialog. 1 = “Yes”, 2 = “No”
    local answer = vim.fn.confirm(
      'There are unsaved buffers – write them before committing?', '&Yes\n&No', 1
    )
    if answer ~= 1 then
      print('Aborted: unsaved files')
      return
    end
    vim.cmd('wall') -- write *all* buffers
  end

  -- stop if remote is ahead
  local behind = tonumber((vim.fn.system('git rev-list --count --left-only @{u}...HEAD'):gsub('%s+', ''))) or 0
  if behind > 0 then
    print('Upstream has new commits – pull/rebase first')
    return
  end

  vim.cmd('G add --all')

  vim.ui.input({ prompt = 'Commit message: ' }, function(msg)
    if not msg or msg == '' then
      print('Aborted: empty commit message')
      return
    end
    -- Commit and push
    vim.cmd('G commit -m ' .. vim.fn.shellescape(msg) .. ' | G push')
  end)
end

-- Keymaps with associated functions
vim.keymap.set('n', '<leader>ga', commit_and_push, { desc = 'Add -A → commit → push' })

-- Norwegian keyboard remaps
-- Might come in handy: vim.opt.langmap:append('ø[,æ]')
vim.keymap.set({ 'n', 'v' }, 'ø', '[', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'æ', ']', { noremap = true })
vim.keymap.set({ 'n', 'v' }, ',', '/', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'Ø', '{', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'Æ', '}', { noremap = true })

-- Navigation & splits
vim.keymap.set('n', 'H', '^', { noremap = true }) -- start of line
vim.keymap.set('n', 'L', 'g_', { noremap = true }) -- end of line
vim.keymap.set('n', 'K', '<C-u>zz', { desc = 'Up half page & recenter' })
vim.keymap.set('n', 'J', '<C-d>zz', { desc = 'Down half page & recenter' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', { noremap = true })
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', { noremap = true })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { noremap = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { noremap = true })

-- Leader basics
vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true })
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true })
vim.keymap.set('n', '<leader>n', ':nohlsearch<CR>', { noremap = true })
vim.keymap.set('n', '<leader>t', function() vim.cmd('terminal') end, { desc = 'Open terminal' })

-- Buffer navigation
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { desc = 'Next buffer' }) -- Ctrl+6 = toggle last two buffers
vim.keymap.set('n', '<leader>q', '<cmd>bdelete<CR>', { desc = 'Delete buffer' })

-- Telescope pickers
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Find file' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fo', require('telescope.builtin').oldfiles, { desc = 'Old files' })
vim.keymap.set('n', '<leader>fp', require('telescope').extensions.projects.projects, { desc = 'Projects' })
vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_status, { desc = 'Git status' })
vim.keymap.set('n', '<leader>gc', require('telescope.builtin').git_commits, { desc = 'Git commits' })

-- Leap movement keybinds
vim.keymap.set('n', 's', '<Plug>(leap)')

-- Gitsigns helpers
vim.keymap.set('n', ']h', require('gitsigns').next_hunk, { desc = 'Next hunk' })
vim.keymap.set('n', '[h', require('gitsigns').prev_hunk, { desc = 'Prev hunk' })
vim.keymap.set('n', '<leader>hs', require('gitsigns').stage_hunk, { desc = 'Stage hunk' })
vim.keymap.set('n', '<leader>hu', require('gitsigns').undo_stage_hunk, { desc = 'Undo stage' })
vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { desc = 'Preview hunk' })
vim.keymap.set('n', '<leader>hb', ':Gitsigns toggle_current_line_blame<CR>', { desc = 'Toggle blame' })

-- Fugitive shortcuts
vim.keymap.set('n', '<leader>gd', ':G diffsplit<CR>', { desc = 'Diff split' })
vim.keymap.set('n', '<leader>gl', ':G log --oneline<CR>', { desc = 'Git log' })
vim.keymap.set('n', '<leader>gp', ':G push<CR>', { desc = 'Git push' })
vim.keymap.set('n', '<leader>gP', ':G pull<CR>', { desc = 'Git pull' })

