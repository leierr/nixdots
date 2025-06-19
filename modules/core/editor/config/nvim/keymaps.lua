local map = vim.keymap.set

-- leader key
vim.g.mapleader = ' '

-- unbindings
map("", "<Space>", "<Nop>")
map("", "<C-l>", "<Nop>")
map("", "s", "<Nop>")

-- Norwegian keyboard remap
vim.opt.langmap = 'ø[,Ø{,æ],Æ}'

-- Visual-mode: Remove unnessecary spaces
map("v", "<leader>ss", [[:s/\v(\S)\zs\s{2,}/ /g | nohlsearch<CR>]], { desc = "Squash spaces (selection, keep indent)" })

-- Search
map("n", "<leader>h", function() vim.opt.hlsearch = not vim.opt.hlsearch:get() end, { desc = "Toggle search highlight" })
map({ "n", "v" }, ",", "/", { desc = "Start / search" })

-- buffer
map("n", "<Tab>", vim.cmd.bnext, { desc = "buffer next"})
map("n", "<S-Tab>", vim.cmd.bprevious, { desc = "buffer previous"})
map("n", "<leader>bd", vim.cmd.bd, { desc = "buffer previous"})

-- telescope bindings
map("n", "<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Find files" })
map("n", "<leader>fo", function() require("telescope.builtin").oldfiles() end, { desc = "Old files" })
map("n", "<leader>fg", function() require("telescope.builtin").live_grep() end, { desc = "Live grep" })
map("n", "<leader>fc", function() require("telescope.builtin").current_buffer_fuzzy_find() end, { desc = "Fuzzy current buffer" })
map("n", "<leader>fp", function() require("telescope").extensions.projects.projects() end, { desc = "Fuzzy current buffer" })

map("n", "<leader><CR>", floatyTerm.toggle, { desc = "Toggle floating terminal" })

-- oil
map("n", "<leader>e", function() require("oil").toggle_float() end, { desc = "toggle Oil" })

-- easy write&quit
map('n', '<leader>w', ':w<CR>', { noremap = true })
map('n', '<leader>q', ':q<CR>', { noremap = true })
