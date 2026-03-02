local M = {}
-- telescope stuff
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

--- @class PickerOpts
--- @field options function<table<string>>
--- @field on_select function
--- @field title string?

--- @param post_select function
--- @return function
local function on_select(post_select)
  return function(bufnr)
    local selected_value = action_state.get_selected_entry()
    if selected_value then
      actions.close(bufnr)
      post_select(selected_value[1])
    end
  end
end

--- @param opts PickerOpts
M.open_picker = function(opts)
  pickers.new(
    {
      layout_config = { height = 0.5, width = 0.5 }
    },
    {
      prompt_title = opts.title or "Select",
      finder = finders.new_table {
        results = opts.options()
      },
      sorter = conf.generic_sorter {},
      attach_mappings = function()
        actions.select_default:replace(on_select(opts.on_select))
        return true
      end

    }):find()
end

return M
