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

