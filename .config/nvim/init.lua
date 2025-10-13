if vim.loader then
	vim.loader.enable()
end

vim.g.copilot_filetypes = {
	["*"] = true,
	["markdown"] = false,
}
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.g.loaded_netrwPlugin = 1
require("config.lazy")
