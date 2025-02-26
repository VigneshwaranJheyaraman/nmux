local function checkout_master (opts)
    opts = opts or {}
    local branch_name = opts.branch_name
    if branch_name == nil or branch_name == ""
        then
            branch_name = "master"
    end
    vim.cmd("silent! Git checkout " .. branch_name)
end

-- get the status
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>gwho", function()
    vim.cmd.Git("blame")
end)

-- checkout master
vim.keymap.set("n", "<leader>gcm", checkout_master)
-- pull origin master
vim.keymap.set("n", "<leader>gpom", function ()
    checkout_master()
    vim.cmd.Git("pull origin master")
end)
-- checkout branch
vim.keymap.set("n", "<leader>gch", function()
    local branch_name = vim.fn.input{
        prompt = "branch name:"
    }
    checkout_master {
        branch_name = branch_name
    }
end)
