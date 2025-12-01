local M= {}

M.staged = function()
  local reader = io.popen("git --no-pager diff --staged");
  if not reader then
    return nil
  end
  local staged_diff = reader:read("*a");
  reader:close();
  if staged_diff and staged_diff ~= "" then
    return staged_diff
  else
    return nil
  end
end

return M
