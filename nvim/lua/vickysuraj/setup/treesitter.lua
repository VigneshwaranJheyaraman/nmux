local commons = require("vickysuraj.utils.lsp")
local file_utils = require("vickysuraj.utils.file")

local M = {}

local function get_parser_file_extension()
  local sys = vim.uv.os_uname().sysname
  return sys:match("Windows") and ".dll" or sys:match("Darwin") and ".dylib" or ".so"
end

local function setup_shortcuts()
  require("vickysuraj.shortcuts.utils").shortcuts_table_TO_keymaps {
    shortcuts = {
      {
        shortcut = "<leader>tsit",
        mapper_cmd_OR_function = ":TSManager<CR>",
        mode = { "n" },
        desc = "open tresitter language manager"
      }
    }
  }
end

local function setup_commands()
  --- filetype start treesitter to higlight
  vim.api.nvim_create_autocmd('FileType', {
    pattern = commons.required_langs,
    callback = function(event)
      local bufnr = event.buf or vim.api.nvim_get_current_buf()
      if not file_utils.is_huge_file(bufnr) then
        local ok, result = pcall(vim.treesitter.start, bufnr)
        if not ok then
          print(vim.inspect(result))
        end
      end
    end,
  })
end

M.setup = function(treesitter_opts)
  local treesitter_config = require("tree-sitter-manager")
  treesitter_opts = vim.tbl_extend("force", treesitter_opts, {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = commons.required_langs,

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
    highlight = {

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
      enable = false,
      -- disable for huge files
      disable = function(lang, buf)
        if lang == nil then
          return true
        else
          return file_utils.is_huge_file(buf)
        end
      end
    }
  })
  treesitter_config.setup(treesitter_opts)
  for _, lang in ipairs(commons.required_langs) do
    local lang_parser_installed_path = (
      vim.fn.stdpath("data") ..
      "/site/parser" .. "/" .. lang .. get_parser_file_extension()
    )
    if not vim.uv.fs_stat(lang_parser_installed_path) then
      pcall(treesitter_config._install_single, lang)
    end
  end
  setup_commands()
  setup_shortcuts()
end

return M
