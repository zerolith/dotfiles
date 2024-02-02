return {
  'folke/zen-mode.nvim',
  dependencies = { "folke/twilight.nvim" },
  config = function()
    vim.api.nvim_set_keymap("n", "tw", ":Twilight<enter>", {noremap=false})
    vim.api.nvim_set_keymap("n", "ZZ", ":ZenMode<enter>", {noremap=false})
  end,
}