vim.api.nvim_create_user_command("StartDb", function()
    pcall(function()
        vim.api.nvim_set_current_dir(os.getenv("db_dir") or "/tmp")
        vim.cmd("DBUI")
    end)
end, {})

-- selection color on Yanking
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "I highlight the yanked content",
    group = vim.api.nvim_create_augroup("highlight-yank", {clear=true}),
    callback= function ()
        vim.highlight.on_yank()
    end
})

-- for repl stuff
vim.api.nvim_create_autocmd("TermOpen", {
    desc="I remove some editor opts on terminal mode",
    group=vim.api.nvim_create_augroup("cleanup-term-mode", {clear=true}),
    callback=function ()
        vim.opt.relativenumber=false
        vim.opt.number=false
    end
})
