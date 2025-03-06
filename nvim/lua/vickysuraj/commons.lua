local M = {}

local detached_bufnrs = {}

---@type table<string, string>
local langs_to_lsp = {}
langs_to_lsp["clojure"] = "clojure_lsp"
langs_to_lsp["lua"] = "lua_ls"
langs_to_lsp["java"] = "jdtls"
langs_to_lsp["typescript"] = "tsserver"
langs_to_lsp["javascript"] ="eslint"
langs_to_lsp["python"] = "pyright"

---@type string[]
M.required_langs = {
    "c",
    "vim", "vimdoc",
    "query",
    "markdown", "markdown_inline",
    "go"
}

M.required_lsp = {
    'jsonls'
}

for lang_name, lsp_name in ipairs(langs_to_lsp) do
    table.insert(M.required_langs, lang_name)
    table.insert(M.required_lsp, lsp_name)
end

M.is_huge_file = function (buf)
  local max_file_size = 100 * 1024 --100KB
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  if ok and stats and stats.size > max_file_size then
    return true
  end
  return false
end

M.detach_lsp_for_huge_file = function (buf, client_id)
  if detached_bufnrs[buf] == nil then
    if M.is_huge_file(buf) then
      local lsp = vim.lsp or {}
      if lsp.buf_detach_client ~= nil then
        lsp.buf_detach_client(buf, client_id)
        detached_bufnrs[buf] = client_id
      end
    end
  end
end

M.huge_bufs = detached_bufnrs

return M
