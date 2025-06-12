-- define leader before doing anything else
vim.g.mapleader = ' '

-- UI
vim.opt.number = true -- Show absolute line number on the current line
vim.opt.relativenumber = true -- Show relative line numbers on all other lines
vim.opt.cursorline = true -- Highlight the line where the cursor is located
vim.opt.signcolumn = 'yes' -- Always show the sign column to avoid text shifting
vim.opt.scrolloff = 8 -- Keep at least 8 lines visible above/below the cursor

-- Indentation
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.tabstop = 2 -- A tab character displays as 2 spaces
vim.opt.shiftwidth = 2 -- Indent/outdent by 2 spaces when using >> or <<
vim.opt.smartindent = true -- Automatically indent new lines based on context
vim.opt.breakindent = true -- Maintain indentation on wrapped lines

-- Search
vim.opt.hlsearch = true -- Highlight all matches after a search
vim.opt.incsearch = true -- Show matches while typing the search pattern
vim.opt.ignorecase = true -- Make search case-insensitive by default
vim.opt.smartcase = true -- Make search case-sensitive if uppercase letters are used

-- Splits
vim.opt.splitright = true -- Vertical splits open to the right
vim.opt.splitbelow = true -- Horizontal splits open below
vim.opt.equalalways = false -- Don’t auto-resize all windows when opening a new split

-- Files
vim.opt.undofile = true -- Enable persistent undo history across sessions
vim.opt.swapfile = false -- Disable swap file creation (.swp files)
vim.opt.backup = false -- Don’t create a backup file before overwriting
vim.opt.writebackup = false -- Don’t keep a backup during write (safer for some setups)
vim.opt.updatetime = 250 -- Delay in ms before triggering CursorHold/autocommands (default is 4000)

-- Clipboard / mouse
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard for all yanks, deletes, and pastes
vim.opt.mouse = '' -- Disable mouse support entirely

-- Performance
vim.opt.lazyredraw = true -- Don’t redraw screen during macros for better performance
vim.opt.timeoutlen = 400 -- Time in ms to wait for mapped key sequences (faster UX)
vim.opt.completeopt = { 'menuone', 'noselect' } -- Completion menu: show even with one item, don’t auto-select
