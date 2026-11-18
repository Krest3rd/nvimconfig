return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
    })

    vim.lsp.enable({
      "lua_ls",
      "pyright",
      "clangd",
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        if client:supports_method("textDocument/inlayHint") then
          vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end

	if client:supports_method("textDocument/completion") then
      	    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    	end

        local opts = { buffer = args.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      end,
    })
  end,
}
