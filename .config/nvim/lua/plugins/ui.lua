return {

	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				--	compile = true, -- enable compiling the colorscheme
				undercurl = true, -- enable undercurls
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				typeStyle = {},
				variablebuiltinStyle = { italic = true },
				specialReturn = true, -- special highlight for the return keyword
				specialException = true, -- special highlight for exception handling keywords
				transparent = false, -- do not set background color
				dimInactive = false, -- dim inactive window `:h hl-NormalNC`
				globalStatus = false, -- adjust window separators highlight for laststatus=3
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				colors = { -- add/modify theme and palette colors
					palette = {},
					theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
				},
				overrides = function(colors) -- add/modify highlights
					return {}
				end,
				theme = "wave", -- Load "wave" theme when 'background' option is not set
				background = { -- map the value of 'background' option to a theme
					dark = "dragon", -- try "dragon" !
					light = "lotus",
				},
			})
			vim.cmd("colorscheme kanagawa")
		end,
	},
	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			opts.options.theme = "kanagawa"
		end,
	},
	-- Icons
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		opts = {
			options = {
				diagnostics = "nvim_lsp",
			},
		},
	},
	-- Indent Guides
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "┊",
				tab_char = "┊",
				highlight = { "LineNr" },
			},
			scope = {
				enabled = false,
				show_start = false,
				show_end = false,
			},
		},
	},
	-- Notify
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 10000,
		},
	},

	-- Discord Status
	{
		"vyfor/cord.nvim",
		build = ":Cord update",
		config = function()
			require("cord").setup({
				enable = true,
				log_level = vim.log.levels.OFF,
				text = {
					workspace = function(opts)
						local hour = tonumber(os.date("%H"))
						local status = hour >= 22 and "🌙 Late night coding"
							or hour >= 18 and "🌆 Evening session"
							or hour >= 12 and "☀️ Afternoon coding"
							or hour >= 5 and "🌅 Morning productivity"
							or "🌙 Midnight hacking"

						return string.format("%s: %s", status, opts.filename)
					end,
				},
				editor = {
					client = "neovim",
					tooltip = "The Superior Text Editor",
					icon = "nil",
				},
				idle = {
					details = function(opts)
						return string.format("Taking a break from %s", opts.workspace)
					end,
				},
			})
		end,
	},

	-- Snacks
	{
		"folke/snacks.nvim",
		opts = {
			dashboard = {
				preset = {
					header = [[
			
                                             __----~~~~~~~~~~~------___
                                  .  .   ~~//====......          __--~ ~~
                  -.            \_|//     |||\\  ~~~~~~::::... /~
               ___-==_       _-~o~  \/    |||  \\            _/~~-
       __---~~~.==~||\=_    -_--~/_-~|-   |\\   \\        _/~
   _-~~     .=~    |  \\-_    '-~7  /-   /  ||    \      /
 .~       .~       |   \\ -_    /  /-   /   ||      \   /
/  ____  /         |     \\ ~-_/  /|- _/   .||       \ /
|~~    ~~|--~~~~--_ \     ~==-/   | \~--===~~        .\
         '         ~-|      /|    |-~\~~       __--~~
                     |-~~-_/ |    |   ~\_   _-~            /\
                          /  \     \__   \/~                \__
                      _--~ _/ | .-~~____--~-/                  ~~==.
                     ((->/~   '.|||' -_|    ~~-/ ,              . _||
                                -_     ~\      ~~---l__i__i__i--~~_/
                                _-~-__   ~)  \--______________--~~
                              //.-~~~-~_--~- |-------~~~~~~~~
                                     //.-~~~--\

          ]],
				},
			},
		},
	},
}
