local M = {}

---@type string[]
local schemes_available = vim.api.nvim_get_runtime_file("colors/*", true)
local color_schemes = {}

for _, fullpath in pairs(schemes_available) do
  table.insert(color_schemes, vim.fn.fnamemodify(fullpath, ":t:r"))
end

M.ColorMyBash = function (color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)
end

M.randomColorSchema = function ()
    M.ColorMyBash(color_schemes[math.random(#color_schemes)])
end

return M
