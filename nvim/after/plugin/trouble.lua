require("trouble").setup {
    icons = false,
}
-- Lua
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
