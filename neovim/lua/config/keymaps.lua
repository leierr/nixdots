local git = require("git.custom-functions")
local map = vim.keymap.set

-- leader
vim.g.mapleader = ' '

-- unbindings
map("", "<Space>", "<Nop>")

-- Norwegian keyboard remap
vim.opt.langmap = 'ø[,Ø{,æ],Æ}'

-- Visual-mode: Remove unnessecary spaces
map("v", "<leader>ss", [[:s/\v(\S)\zs\s{2,}/ /g | nohlsearch<CR>]], { desc = "Squash spaces (selection, keep indent)" })

-- Search
map("n", "<leader>h", function() vim.opt.hlsearch = not vim.opt.hlsearch:get() end, { desc = "Toggle search highlight" })
map({ "n", "v" }, ",", "/", { desc = "Start / search" })

-- easy write&quit
map('n', '<leader>w', ':w<CR>', { noremap = true })
map('n', '<leader>q', ':q<CR>', { noremap = true })

-- Floating term
map("n", "<leader><CR>", function() Snacks.terminal() end, { desc = "Toggle floating terminal" })

-- oil
map("n", "<leader>e", function() require("oil").open() end, { desc = "toggle Oil" })

-- Git
map("n", "<leader>ga", git.commit_and_push, { desc = "Git add → commit → push" })

-- flash
map({ "n", "x", "o" }, "S", function() require("flash").jump() end, { desc = "Flash jump", noremap = true })
