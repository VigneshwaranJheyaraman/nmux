local M = {}

local state = {
  floating = {
    buf = -1,
    win = -1,
  }
}

local function create_floating_window(opts)
  opts = opts or {}
  assert(opts.mode, "Missing mode")
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Calculate the position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  -- Define window configuration
  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal", -- No borders or extra UI elements
    border = "rounded",
  }

  -- Create the floating window
  local win= vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

M.hide_window = function()
    vim.api.nvim_win_hide(state.floating.win)
end

M.open_window = function (opts)
  opts = opts or {}
  local window_mode = opts.mode
  assert(opts.mode, "toggling missing mode")
  assert(opts.on_open, "toggling window missing on_open function")
  state.floating = create_floating_window { buf = state.floating.buf, mode = window_mode }
  if vim.bo[state.floating.buf].buftype ~= opts.mode then
    opts.on_open()
  end
end

M.toggle_window = function(opts)
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    M.open_window(opts)
  else
    M.hide_window()
  end
end

local function popluate_terminal_options (opts)
  opts = opts or {}
  local term_opts = {
    mode = "terminal",
    on_open = function ()
      if opts.cmd then
        vim.cmd.terminal(opts.cmd)
      else
        vim.cmd.terminal()
      end
      if opts.on_term_enter ~= nil and type(opts.on_term_enter) == "function" then
        opts.on_term_enter {
          bufnr = state.floating.buf
        }
      end
    end
  }

  for ki, val_u in pairs(opts) do
    term_opts[ki] = val_u
  end
  return term_opts
end

M.toggle_terminal = function (opts)
  M.toggle_window(popluate_terminal_options(opts))
end

M.open_terminal = function (opts)
  M.open_window(popluate_terminal_options(opts))
end

return M
