return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.code_actions.shellcheck,
        
				null_ls.builtins.diagnostics.erb_lint,
				null_ls.builtins.diagnostics.eslint_d,
				null_ls.builtins.diagnostics.rubocop,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.zsh,
        null_ls.builtins.diagnostics.dotenv_linter,
        null_ls.builtins.diagnostics.jsonlint,
        null_ls.builtins.diagnostics.yamllint,
        
				null_ls.builtins.formatting.rubocop,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.yamlfmt,
        null_ls.builtins.formatting.beautysh,
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
