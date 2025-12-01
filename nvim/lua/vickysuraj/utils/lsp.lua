local M = {}

---@type table<string, string>
local langs_to_lsp = {}
langs_to_lsp["clojure"] = "clojure_lsp"
langs_to_lsp["lua"] = "lua_ls"
langs_to_lsp["java"] = "jdtls"
langs_to_lsp["typescript"] = "ts_ls"
langs_to_lsp["javascript"] ="eslint"
langs_to_lsp["python"] = "pyright"

---@type string[]
local required_langs = {
    "c",
    "vim", "vimdoc",
    "query",
    "markdown", "markdown_inline",
    "go"
}

---@type string[]
local required_lsp = {
    'jsonls'
}

for lang_name, lsp_name in pairs(langs_to_lsp) do
    table.insert(required_langs, lang_name)
    table.insert(required_lsp, lsp_name)
end

M.required_langs = required_langs
M.required_lsp = required_lsp

return M
