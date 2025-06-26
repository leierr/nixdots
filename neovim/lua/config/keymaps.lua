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

-- Floating term
map("n", "<leader><CR>", require("Snacks").terminal(), { desc = "Toggle floating terminal" })

