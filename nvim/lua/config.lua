local M = {}

local function env_exists(var)
  local env_val = os.getenv(var)
  return env_val ~= nil and string.gsub(env_val, "%s+", "") ~= ""
end

--- checks if ollama exists and then return a default model
--- else returns nil
--- @return string|nil
local function get_default_local_model()
  if vim.fn.executable("ollama") == 1 then
    return "ministral-3"
  else
    return nil
  end
end

local state = {
  copilot = env_exists("COPILOT") or false,
  arrow_keys = false,
  have_swap_file = false,
  shell = os.getenv("SHELL") or "/bin/zsh",
  mouse = false,
  default_theme = "rose-pine-moon",
  local_model = get_default_local_model()
}

local function hasKeyInMap(map, key)
  return vim.tbl_contains(vim.tbl_keys(map), key)
end

--- @param configName string
--- @deprecated
local function change_config(configName, configValue)
  if hasKeyInMap(state, configName) then
    state[configName] = configValue
  end
end

--- @return any|nil
M.get_config = function(configName)
  if hasKeyInMap(state, configName) then
    return state[configName]
  else
    return nil
  end
end

return M
