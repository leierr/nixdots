local map = vim.keymap.set

-- leader key
vim.g.mapleader = " "

-- unbindings
map("", "<Space>", "<Nop>")
map("", "<C-l>", "<Nop>")
map("", "s", "<Nop>") -- mini.surround binding

-- Norwegian keyboard remap
vim.opt.langmap = "ø[,Ø{,æ],Æ}"

-- Visual-mode: Remove unnessecary spaces
map("v", "<leader>ss", [[:<C-u>silent! '<,'>s/\v(\S)\zs\s{2,}/ /g<CR>]], { desc = "Squash spaces (selection)" })

-- Search
map("n", "<leader>h", function() vim.opt.hlsearch = not vim.opt.hlsearch:get() end, { desc = "Toggle search highlight" })
map({ "n", "v" }, ",", "/", { desc = "Start / search" })

-- buffer
map("n", "<Tab>", vim.cmd.bnext, { desc = "buffer next" })
map("n", "<S-Tab>", vim.cmd.bprevious, { desc = "buffer previous" })
map("n", "<leader>bd", vim.cmd.bd, { desc = "buffer previous" })

-- telescope bindings
map("n", "<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Find files" })
map("n", "<leader>fo", function() require("telescope.builtin").oldfiles() end, { desc = "Old files" })
map("n", "<leader>fg", function() require("telescope.builtin").live_grep() end, { desc = "Live grep" })
map("n", "<leader>fc", function() require("telescope.builtin").current_buffer_fuzzy_find() end, { desc = "Fuzzy current buffer" }) map("n", "<leader>fb", function() require("telescope.builtin").buffers() end, { desc = "Buffers" })
map("n", "<leader>fp", function() require("telescope").extensions.projects.projects() end, { desc = "Fuzzy current buffer" }) map("n", "<leader>fu", function() require("telescope").extensions.undo.undo() end, { desc = "Undo history" })

map("n", "<leader><CR>", floatyTerm.toggle, { desc = "Toggle floating terminal" })

-- easy write&quit
map("n", "<leader>w", ":w<CR>", { noremap = true })
map("n", "<leader>q", ":qa<CR>", { noremap = true })

-- Git keybinds
map("n", "<leader>gr", function() require("gitsigns").reset_hunk() end, { desc = "Undo the changes in the current hunk" })
map("n", "<leader>gb", function() require("gitsigns").toggle_current_line_blame() end, { desc = "Undo the changes in the current hunk" })
map("n", "<leader>ga", commit_and_push, { desc = "Save, commit, and push all" })

-- oil
map("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Toggle Oil filebrowser" })

-- Rebinds
map("n", "J", function() require("mini.splitjoin").toggle() end, { desc = "Splitjoin: Toggle split/join" })
map('n', 'gf', ":e <cword><CR>", { desc = 'Open file under cursor (create if missing)' })
map("n", "<leader>d", vim.diagnostic.open_float)
map({ "n", "x", "o" }, "<C-u>", "10k", { noremap = true, silent = true })
map({ "n", "x", "o" }, "<C-d>", "10j", { noremap = true, silent = true })
