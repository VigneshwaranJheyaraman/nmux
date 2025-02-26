local M = {}

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

return M
