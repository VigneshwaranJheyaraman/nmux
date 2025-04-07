local M = {}

M.is_huge_file = function (buf)
  local max_file_size = 100 * 1024 --100KB
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  if ok and stats and stats.size > max_file_size then
    return true
  end
  return false
end

M.has_file = function (file_name)
  if vim.fn.executable("rg") then
    local file_found = string.gsub(vim.fn.system("rg --files --color never *" .. file_name .. "*"), "%s+", "")
    return file_found == file_name
  end
  return false
end

return M
