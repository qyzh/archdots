-- Nonaktifkan netrw agar tidak bentrok dengan Neo-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			"s1n7ax/nvim-window-picker",
		},
		cmd = "Neotree",
		keys = {
			{ "<leader>j", "<cmd>Neotree toggle<cr>", desc = "Explorer (Neo-tree)" },
			{ "<leader>o", "<cmd>Neotree focus<cr>", desc = "Focus Neo-tree" },
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true,
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				default_component_configs = {
					indent = { padding = 0, with_markers = true },
					icon = { folder_closed = "", folder_open = "", default = "" },
					git_status = { symbols = { added = "✚", modified = "", deleted = "✖" } },
				},
				filesystem = {
					hijack_netrw_behavior = "open_default",
				},
				window = {
					width = 30,
					mappings = {
						["<cr>"] = "open_with_window_picker",
						["l"] = "open",
						["h"] = "close_node",
					},
				},
			})
		end,
	},

	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = { "nvim-neo-tree/neo-tree.nvim" },
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
}
