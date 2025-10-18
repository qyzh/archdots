-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

-- Leader keys
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{
			"LazyVim/LazyVim",
			import = "lazyvim.plugins",
			opts = {
				news = { lazyvim = true, neovim = true },
			},
		},
		{ import = "lazyvim.plugins.extras.ui.edgy" },
		{ import = "lazyvim.plugins.extras.ui.mini-animate" },
		{ import = "lazyvim.plugins.extras.dap.core" },
		{ import = "lazyvim.plugins.extras.dap.nlua" },
		{ import = "lazyvim.plugins.extras.lang.json" },
		{ import = "lazyvim.plugins.extras.lang.typescript" },
		{ import = "lazyvim.plugins.extras.lang.tailwind" },
		{ import = "lazyvim.plugins.extras.formatting.prettier" },
		{ import = "plugins" },
	},
	defaults = {
		lazy = false,
		version = false, -- ganti "*" kalau mau pakai release stable
	},
	install = { colorscheme = { "kanagawa" } },
	checker = { enabled = true },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
