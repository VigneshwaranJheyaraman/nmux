return {
  {
    "David-Kunz/gen.nvim",
    cond=require("config").get_config("local_model"),
    config = function()
      require("vickysuraj.setup.local_ollama").setup()
    end
  }
};
