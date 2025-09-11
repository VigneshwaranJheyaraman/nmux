local function setup_lua_ls()
  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")
  local lua_opts = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      }
    }
  }
  return {
    settings = lua_opts,
  }
end

return setup_lua_ls()
