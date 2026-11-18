return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")

    ts.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    ts.install({ "python", "cpp", "c", "lua" })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "python", "cpp", "c", "lua" },
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
