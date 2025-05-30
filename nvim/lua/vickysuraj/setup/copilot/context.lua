local async = require("plenary.async")

-- copied from CopilotChat/utils.lua
local async_system_call = async.wrap(function(cmd, callback)
  vim.system(cmd, { text = true }, callback)
end, 2)

local custom_context = {
  revu = {
    description = [[Requires `git` inorder to handles files changes amongs different iteration / version, you can input the the branch name which will inturn add the context #url:<branch-link> to the prompt there by including more information
    ]],
    input = function(callback)
      vim.ui.input(
        {
          prompt = 'Enter review context either PR number or branch name>'
        },
        callback
      )
    end,
    resolve = function(input, source)
      local LOCAL_CHANGES = 'HEAD'
      if input == nil or input == '' then
        input = LOCAL_CHANGES
      end
      if input ~= 'HEAD' then
        local fetch_origin_cmd = {
          'git',
          '-C',
          source.cwd(),
          'fetch',
          '--prune',
          'origin'
        }
        local fetch_output = async_system_call(fetch_origin_cmd)
        if fetch_output.code ~= 0 then
          return {
            {
              content = 'Failed to fetch origin: ' .. fetch_output.stdout,
              filename = 'git_fetch_error',
              filetype = 'text',
            }
          }
        end
      end
      local cmd = {
        'git',
        '-C',
        source.cwd(),
        'diff',
        '--no-color',
        '--no-ext-diff',
        'master',
        'origin/' .. input
      }
      local content = async_system_call(cmd).stdout
      return {
        {
          content = content,
          filename = 'revu_out_' .. input,
          filetype = 'diff'
        }
      }
    end
  }
}

return custom_context
