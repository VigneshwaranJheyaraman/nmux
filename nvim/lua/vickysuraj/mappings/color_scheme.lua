local M = {}

---@type string[]
local schemes = {
    "rose-pine",
    "tokyonight-night",
    "tokyonight-storm",
    "tokyonight-moon",
}

M.ColorMyBash = function (color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)
end

M.randomColorSchema = function ()
    M.ColorMyBash(schemes[math.random(#schemes)])
end

return M
