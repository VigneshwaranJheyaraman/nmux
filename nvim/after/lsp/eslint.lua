return {
  on_attach = function(_, buffer)
    -- make sure before saving a file eslint fix all
    if vim.fn.exists(":EslintFixAll") ~= 0 then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = buffer,
        command = "EslintFixAll"
      })
    end
  end
}
