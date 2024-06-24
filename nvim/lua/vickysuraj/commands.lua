vim.api.nvim_create_user_command("StartDb", function()
    pcall(function()
        vim.api.nvim_set_current_dir(os.getenv("db_dir") or "/tmp")
        vim.cmd("DBUI")
    end)
end, {})