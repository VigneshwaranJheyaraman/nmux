local is_opencode_visible = false

-- copied from https://github.com/nickjvandyke/opencode.nvim/blob/v0.3.0/lua/opencode/provider/tmux.lua
local Tmux = {}
Tmux.__index = Tmux
Tmux.name = "tmux"

function Tmux.new(opts)
  local self = setmetatable({}, Tmux)
  self.opts = opts or {}
  self.pane_id = nil
  self.cmd = "opencode --port"
  return self
end

---Check if we're running in a `tmux` session.
function Tmux.health()
  if vim.fn.executable("tmux") ~= 1 then
    return "`tmux` executable not found in `$PATH`.", {
      "Install `tmux` and ensure it's in your `$PATH`.",
    }
  end

  if not vim.env.TMUX then
    return "Not running in a `tmux` session.", {
      "Launch Neovim in a `tmux` session.",
    }
  end

  return true
end

---Get the `tmux` pane ID where we started `opencode`, if it still exists.
---Ideally we'd find existing panes by title or command, but `tmux` doesn't make that straightforward.
---@return string|nil pane_id
function Tmux:get_pane_id()
  local ok = self.health()
  if ok ~= true then
    error(ok, 0)
  end

  if self.pane_id then
    -- Confirm it still exists
    if vim.fn.system("tmux list-panes -t " .. self.pane_id):match("can't find pane") then
      self.pane_id = nil
    end
  end

  return self.pane_id
end

---Start `opencode` in pane.
function Tmux:start()
  local pane_id = self:get_pane_id()
  if not pane_id then
    -- Create new pane
    local detach_flag = self.opts.focus and "" or "-d"
    self.pane_id = vim.fn.system(
      string.format("tmux split-window -c %q -h %s -P -F '#{pane_id}' %s '%s'", vim.fn.getcwd(), detach_flag,
        self.opts.options or "", self.cmd)
    )
    local disable_passthrough = self.opts.allow_passthrough ~= true -- default true (disable passthrough)
    if disable_passthrough and self.pane_id and self.pane_id ~= "" then
      vim.fn.system(string.format("tmux set-option -t %s -p allow-passthrough off", vim.trim(self.pane_id)))
    end
  end
end

---Kill the `opencode` pane.
function Tmux:stop()
  local pane_id = self:get_pane_id()
  if pane_id then
    vim.fn.system("tmux kill-pane -t " .. pane_id)
    self.pane_id = nil
  end
end

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


function Tmux:toggle()
  local pane_id = self:get_pane_id()
  if pane_id then
    view_opencode_fullscreen(pane_id)
  else
    self:start()
    view_opencode_fullscreen(self:get_pane_id())
  end
end

return Tmux
