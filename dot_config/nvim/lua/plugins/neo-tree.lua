return {
	"nvim-neo-tree/neo-tree.nvim",
	--branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_by_name = {

          },
          hide_by_pattern = {},
          always_show = {
            '.gitignore',
            '.github',
            '.dockerignore',
            '.gitignore',
            '.envrc',
            '.htaccess',
            '.ruby-version',
          },
          never_show = {
            '.git',
            '.ruby-lsp',
            '.DS_Store',
            'node_modules',
            '.jekyll-cache',
            '.cache',
          },
          never_show_by_pattern = {},
        },
      }
    })
		-- vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
		-- vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
	end,
}
