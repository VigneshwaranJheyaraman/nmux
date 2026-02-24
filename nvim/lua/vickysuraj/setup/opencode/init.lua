local M = {};
local keymap = require("vickysuraj.setup.opencode.keymap");
local contexts = require("vickysuraj.setup.opencode.context");
local Tmux = require("vickysuraj.setup.opencode.providers.tmux")
local tmux = Tmux:new()

M.contexts = {
  ["@staged"] = function(_) contexts:staged() end
}

M.prompts = {
  generate_commit_message = {
    prompt = [[ Given @@staged, Write commit message for the change with commitizen convention.
    Keep the title under 50 characters and wrap message at 500 characters. Format as a gitcommit code block.
    If user has COMMIT_EDITMSG opened, generate replacement block for whole buffer.
    Explain in more detail about what was changed and why in the commit message
    also include the changelog entry for the change and have them wrapped within gitcommit code block,
    ## Make sure that content is copied to clipboard
    ## DO NOT perform WRITE operation just output the commit message
    ]],
    submit = true
  }
}

M.setup = function(_)
  vim.g.opencode_opts = {
    -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
    prompts = M.prompts,
    contexts = M.contexts,
    server = {
      start = function()
        tmux:start()
      end,
      stop = function()
        tmux:stop()
      end,
      toggle = function()
        tmux:toggle()
      end
    }
  }

  -- Required for `opts.events.reload`.
  vim.o.autoread = true
  keymap.setup_keymap()
end

return M
