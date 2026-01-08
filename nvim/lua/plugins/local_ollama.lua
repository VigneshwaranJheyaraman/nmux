local default_local_model = require("config").get_config("local_model");
return {
  {
    -- working on the opensource contribution
    -- "David-Kunz/gen.nvim",
    dir = "/Users/vjheya862/Desktop/VJ/personal-contrib/gen.nvim",
    cond = default_local_model ~= nil,
    keys = { "<leader>lai" },
    config = function()
      require("vickysuraj.setup.local_ollama").setup {
        model = default_local_model
      }
    end
  }
};
