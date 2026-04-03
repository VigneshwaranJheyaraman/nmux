local M = {}

M.get_setup_opts = function()
  return {
    -- typst = true,
    -- latex = true,
    github = {
      output = function(ctx)
        return '/tmp/' .. vim.fn.fnamemodify(ctx.file, ':t:r') .. '.html'
      end,
    }
  }
end

return M
