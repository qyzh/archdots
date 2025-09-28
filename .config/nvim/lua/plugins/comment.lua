return {
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			local comment = require("Comment")
			local ts_context = require("ts_context_commentstring.integrations.comment_nvim")

			comment.setup({
				---Add a space b/w comment and the line
				padding = true,

				---Whether cursor should stay at its position
				sticky = true,

				---Lines to ignore while commenting
				ignore = "^$", -- regex untuk skip empty lines

				---LHS of toggle mappings in NORMAL + VISUAL mode
				toggler = {
					line = "gcc", -- line-comment
					block = "gbc", -- block-comment
				},

				---LHS of operator-pending mappings in NORMAL + VISUAL mode
				opleader = {
					line = "gc", -- e.g. `gcw` comment word
					block = "gb", -- e.g. `gb2j` comment 2 lines with block
				},

				---LHS of extra mappings
				extra = {
					above = "gcO", -- add comment above
					below = "gco", -- add comment below
					eol = "gcA", -- add comment at end of line
				},

				---Enable keybindings
				mappings = {
					basic = true,
					extra = true,
				},

				---Hooks
				pre_hook = ts_context.create_pre_hook(),
				post_hook = nil,
			})
		end,
	},
}
