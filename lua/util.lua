local M = {}

function M.notify(msg, title)
  local Snacks = package.loaded["snacks"]
  if Snacks then
    Snacks.notify.info(msg, { title = title or "Notification" })
  else
    vim.notify(msg)
  end
end

return M
