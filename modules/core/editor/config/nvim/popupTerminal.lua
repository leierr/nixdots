local M = {}
local term_buf, term_win -- state

local function geometry()
  local ui = vim.api.nvim_list_uis()[1]
  local w = math.floor(ui.width * 0.80) -- 80 %
  local h = math.floor(ui.height * 0.70) -- 70 %
  local col = math.floor((ui.width - w) / 2)
  local row = math.floor((ui.height - h) / 2)
  return w, h, col, row
end

local function create_buffer()
  term_buf = vim.api.nvim_create_buf(false, true) -- [No Name] buffer
  vim.bo[term_buf].bufhidden = "hide"
end

local function open_float()
  local w, h, col, row = geometry()
  term_win = vim.api.nvim_open_win(term_buf, true, {
    relative = "editor",
    width = w,
    height = h,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
    title = " Terminal ",
    title_pos = "center",
  })
end

local function setup_keys()
  local opts = { buffer = term_buf, nowait = true, silent = true }
  -- 1st Esc → exit terminal-mode
  vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
  -- 2nd Esc (now in normal mode) → hide window
  vim.keymap.set("n", "<Esc>", function()
    if term_win and vim.api.nvim_win_is_valid(term_win) then
      vim.api.nvim_win_close(term_win, true)
      term_win = nil
    end
  end, opts)
end

function M.toggle()
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    -- hide current floating window (buffer kept)
    vim.api.nvim_win_close(term_win, true)
    term_win = nil
    return
  end

  -- buffer missing? create a fresh one
  if not (term_buf and vim.api.nvim_buf_is_valid(term_buf)) then
    create_buffer()
    setup_keys()
  end

  -- open or reopen the floating window
  open_float()

  -- if buffer isn't already a terminal, spawn one
  if vim.bo[term_buf].buftype ~= "terminal" then
    vim.api.nvim_set_current_win(term_win)
    vim.fn.termopen(vim.o.shell)
  end

  -- drop user into insert mode
  vim.cmd("startinsert!")
end

return M
