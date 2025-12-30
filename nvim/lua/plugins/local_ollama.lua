return {
  {
    -- working on the opensource contribution
    -- "David-Kunz/gen.nvim",
    dir = "/Users/vjheya862/Desktop/VJ/personal-contrib/gen.nvim",
    cond = require("config").get_config("local_model"),
    keys = { "<leader>lama", "<leader>rama" },
    config = function()
      require("vickysuraj.setup.local_ollama").setup()
    end
  }
};
