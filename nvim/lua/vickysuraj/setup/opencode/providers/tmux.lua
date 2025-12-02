local M = {}
local is_opencode_visible = false
local Tmux = require("opencode.provider.tmux")

local update_opencode_visibility = function(opencode_pane_id)
  local tmux_active_pane = vim.fn.getenv("TMUX_PANE");
  is_opencode_visible = tmux_active_pane == opencode_pane_id
  return is_opencode_visible
end

local view_opencode_fullscreen = function(pane_id)
  if not update_opencode_visibility(pane_id) then
    vim.fn.system("tmux select-pane -t " .. pane_id)
    vim.fn.system("tmux resize-pane -Z")
  end
end

M.enabled = "tmux";

--- @type self opencode.Provider
function Tmux:toggle()
  M.s = self
  local pane_id = self:get_pane_id()
  if pane_id then
    view_opencode_fullscreen(pane_id)
  else
    self:start()
    view_opencode_fullscreen(self:get_pane_id())
  end
end

return M
