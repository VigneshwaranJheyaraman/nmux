vim.api.nvim_create_user_command("StartDb", function()
  vim.api.nvim_set_current_dir(os.getenv("db_dir") or "/tmp")
  vim.cmd("DBUI")
end, {})

-- selection color on Yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "I highlight the yanked content",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end
})

-- for repl stuff
vim.api.nvim_create_autocmd("TermOpen", {
  desc = "I remove some editor opts on terminal mode",
  group = vim.api.nvim_create_augroup("cleanup-term-mode", { clear = true }),
  callback = function()
    vim.opt.relativenumber = false
    vim.opt.number = false
  end
})

-- for enabling highlight search on command line entry i.e., <ESC>/
---@param toggleValue boolean
local function toggleHighlightAndIncrementSearch(toggleValue)
  vim.opt.hlsearch = toggleValue
  vim.opt.incsearch = toggleValue
end
local searchGroup = vim.api.nvim_create_augroup("search-highlight", { clear = true })
local searchPattern = "/,\\?"
vim.api.nvim_create_autocmd("CmdlineEnter", {
  desc = "i handle search highlight toggling",
  pattern = searchPattern,
  group = searchGroup,
  callback = function()
    toggleHighlightAndIncrementSearch(true)
  end
})
vim.api.nvim_create_autocmd("InsertEnter", {
  desc = "i handle search highlight toggling",
  group = searchGroup,
  callback = function()
    toggleHighlightAndIncrementSearch(false)
  end
})

-- always set relative number and number
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  desc = "i make sure we always have relative number and number set",
  pattern = { "*" },
  callback = function()
    --numbering
    local fileType = vim.bo.filetype;
    local enableNumbr = (
      fileType ~= "" and
      (string.find(fileType, "^Telescope*") == nil)
    );
    vim.opt.number = enableNumbr;
    vim.opt.relativenumber = enableNumbr;
  end
})

-- LSP progress thanks reddit u/heymanh
vim.api.nvim_create_autocmd('LspProgress', {
  callback = function(ev)
    local value = ev.data.params.value or {}
    local msg = value.message or "done"

    -- rust analyszer in particular has really long LSP messages so truncate them
    if #msg > 40 then
      msg = msg:sub(1, 37) .. "..."
    end

    vim.api.nvim_echo({ { msg or 'done' } }, false, {
      id = 'lsp.' .. ev.data.client_id,
      kind = 'progress',
      source = 'vim.lsp',
      title = value.title,
      status = value.kind ~= 'end' and 'running' or 'success',
      percent = value.percentage,
    })
  end,
})
