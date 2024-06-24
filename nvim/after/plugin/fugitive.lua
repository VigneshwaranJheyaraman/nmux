-- get the status
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

local function checkout_master ()
    vim.cmd("silent! Git checkout master")
end

-- checkout master
vim.keymap.set("n", "<leader>gcm", checkout_master)
-- pull origin master
vim.keymap.set("n", "<leader>gpom", function ()
    checkout_master()
    vim.cmd.Git("pull origin master")
end)
