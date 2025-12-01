return {
  filetypes = { 'typescript', 'javascript', 'svelte', 'html', 'css' },
  on_attach = function (client)
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = { "*.js", "*.ts", "*.svelte" },
      callback = function(context)
        client.notify("$/onDidChangeTsOrJsFile", { uri = context.file })
      end,
    })
  end
}
