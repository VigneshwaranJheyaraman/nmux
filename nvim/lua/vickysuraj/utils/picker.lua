local M = {}
-- telescope stuff
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

--- @class PickerList
--- @field label string
--- @field id string

--- @class PickerOptionIdx
--- @field idx table<string, string>
--- @field options string[]

--- @param options_fn fun():PickerList[] | string[]
--- @returns fun(): PickerOptionIdx
local function build_list_index(options_fn)
  --- @type PickerList[] | string[]
  local provided_options = options_fn()
  --- @type table<string, string>
  local opts_idx = {}
  --- @type string[]
  local all_opts = {}
  for _, option in ipairs(provided_options) do
    if type(option) == "table" then
      opts_idx[option.label] = option.id
      table.insert(all_opts, option.label)
    else
      opts_idx[option] = option
      table.insert(all_opts, option)
    end
  end
  return {
    idx = opts_idx,
    options = all_opts
  }
end

--- @class PickerOpts
--- @field options fun():string[]
--- @field on_select function
--- @field title string?

--- @param opts_idx table<string,string>
--- @param post_select function
--- @return function
local function on_select(opts_idx, post_select)
  return function(bufnr)
    local selected_value = action_state.get_selected_entry()
    if selected_value then
      selected_value = selected_value[1]
      actions.close(bufnr)
      post_select(opts_idx[selected_value] or selected_value)
    end
  end
end

--- @param opts PickerOpts
M.open_picker = function(opts)
  local picker_idx = build_list_index(opts.options)
  pickers.new(
    {
      layout_config = { height = 0.5, width = 0.5 }
    },
    {
      prompt_title = opts.title or "Select",
      finder = finders.new_table {
        results = picker_idx.options
      },
      sorter = conf.generic_sorter {},
      attach_mappings = function()
        actions.select_default:replace(on_select(picker_idx.idx, opts.on_select))
        return true
      end

    }):find()
end

return M
