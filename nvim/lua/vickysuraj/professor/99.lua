local professor = require("vickysuraj.professor.core")
local url = professor.url
local M = {}

M.make_provider = function()
  local lib_99_provider = require("99.providers")

  --- @class OpenCodeProvider : _99.Providers.BaseProvider
  local ProfessorProvider = setmetatable({}, { __index = lib_99_provider.BaseProvider })

  --- @param query string
  --- @param context table<string,string>
  --- @return table<string>
  function ProfessorProvider._build_command(_, query, context)
    local professor_cmd = professor.make_professor_ask(url, query, context.model)
    table.insert(professor_cmd.args, 1, professor_cmd.cmd)
    return professor_cmd.args
  end

  --- @return string
  function ProfessorProvider._get_provider_name()
    return "ProfessorProvider"
  end

  --- @return string
  function ProfessorProvider._get_default_model()
    return professor.default_model
  end

  function ProfessorProvider.fetch_models(callback)
    local model_cmd = professor.make_professor_supported_models(url)
    table.insert(model_cmd.args, 1, model_cmd)
    vim.system(model_cmd.args, { text = true }, function(obj)
      vim.schedule(function()
        if obj.code ~= 0 then
          callback(nil, "Failed to fetch models from opencode")
          return
        end
        local json_parsed = vim.cmd("!jq '.[].id <<<'" .. obj.stdout)
        local models = vim.split(json_parsed, "\n", { trimempty = true })
        callback(models, nil)
      end)
    end)
  end

  --- @param context table<string, any>
  function ProfessorProvider:_retrieve_response(context)
    local logger = context.logger:set_area(self:_get_provider_name())
    local success, result = pcall(function()
      return vim.fn.json_decode(context.provider_stdout)
    end)

    if not success then
      logger:error(
        "retrieve_results: failed to read professor response",
        "tmp_name",
        "error",
        result
      )
      return false, ""
    end

    local str = professor.get_professor_response(result)
    if vim.trim(str) == "" then
      str = context.provider_stdout
    end
    logger:debug("retrieve_results", "results", str)
    pcall(function()
      local file = io.open(context.tmp_file, "w")
      if file then
        file:write(str)
        file:close()
        logger:debug("saved prompt to file", "path", file)
      else
        logger:error("failed to save prompt", "path", file)
      end
    end)

    return true, str
  end

  return ProfessorProvider
end

return M
