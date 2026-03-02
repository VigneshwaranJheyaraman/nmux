local snacks = require("snacks")

local M = {}

--- @class AskOptions
--- @field prompt string
--- @field on_confirm function

--- ask function which helps with prompting user and working on the same
--- @param opts AskOptions
--- @return nil
M.ask = function(opts)
  snacks.input({
    prompt = opts.prompt
  }, function(user_input)
    if user_input ~= nil and #user_input > 0 then
      opts.on_confirm(user_input)
    else
      print("No input provided:" .. user_input)
    end
  end)
end

return M
