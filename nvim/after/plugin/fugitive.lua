-- get the status
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- checkout master
vim.keymap.set("n", "<leader>gcm", function ()
    vim.cmd.Git("checkout master")
end)
-- pull origin master
vim.keymap.set("n", "<leader>gpom", function ()
    vim.cmd("<leader>gcm")
    vim.cmd.Git("pull origin master")
end)
