local theme = require("vickysuraj.setup.color_scheme")
-- require commands to register
require("vickysuraj.commands")

-- setup theme
theme.setup {
}

-- require snancks.input for better input ui
require("snacks")
-- setup llm prompts
require("vickysuraj.setup.llm")
