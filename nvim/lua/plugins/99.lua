return {
  {
    "VigneshwaranJheyaraman/99",
    branch = "support_llm_response_replace_with_ouput_window",
    main = "vickysuraj.setup.99",
    opts = {
      path = "/tmp",
      prompts_location = { require("config").get_config("prompt_path") }
    }
  }
}
