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

---@param toggleValue boolean
local function toggleHighlightAndIncrementSearch(toggleValue)
  vim.opt.hlsearch = toggleValue
  vim.opt.incsearch = toggleValue
 end

local searchGroup = vim.api.nvim_create_augroup("search-highlight", {clear=true})
local searchPattern= "/,\\?"

-- for enabling highlight search on command line entry i.e., <ESC>/
vim.api.nvim_create_autocmd("CmdlineEnter", {
  desc= "i handle search highlight toggling",
  pattern=searchPattern,
  group= searchGroup,
  callback= function ()
    toggleHighlightAndIncrementSearch(true)
  end
})
vim.api.nvim_create_autocmd("InsertEnter", {
  desc= "i handle search highlight toggling",
  group= searchGroup,
  callback= function ()
    toggleHighlightAndIncrementSearch(false)
  end
})
-- always set relative number and number
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  desc= "i make sure we always have relative number and number set",
  pattern={ "*" },
  callback= function ()
    --numbering
    local fileType =vim.bo.filetype;
    local enableNumbr = (
      fileType ~= "" and
      (string.find(fileType, "^Telescope*") == nil)
    );
    vim.opt.number = enableNumbr;
    vim.opt.relativenumber = enableNumbr;
  end
})
