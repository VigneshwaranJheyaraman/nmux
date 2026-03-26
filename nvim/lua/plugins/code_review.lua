return {
  {
    --"afewyards/codereview.nvim",
    "VigneshwaranJheyaraman/codereview.nvim",
    branch = "support_prompt_building",
    dependencies = { "nvim-lua/plenary.nvim", lazy = true },
    keys = {
      "<leader>revu",
      "<leader>revuai"
    },
    cmd = {
      "CodeReview",
      "CodeReviewAI",
      "CodeReviewAIFile",
      "CodeReviewStart",
      "CodeReviewSubmit",
      "CodeReviewApprove",
      "CodeReviewOpen",
      "CodeReviewPipeline",
      "CodeReviewComments",
      "CodeReviewFiles",
      "CodeReviewToggleScroll",
      "CodeReviewCommits",
    },
    main = "vickysuraj.setup.git.code_review",
    opts = {
      model = "github-copilot/claude-haiku-4.5"
    },
  }
}
