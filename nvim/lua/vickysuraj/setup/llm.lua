local prompts = require("vickysuraj.setup.llm.prompts")
local prompt_dir = require("config").get_config("prompt_path")

if prompt_dir ~= nil then
  prompts.setup {
    dir = prompt_dir
  }
end
