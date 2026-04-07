require('blink.cmp').setup({
	keymap = { preset = "default",
	["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
	["<CR>"] = { "select_and_accept", "fallback" },
},
fuzzy = { implementation = "lua" }, -- figure out to build it in rust one day...
appearance = {
	nerd_font_variant = "mono"
},
snippets = { preset = "luasnip" },
completion = {
	accept = {
		auto_brackets = { enabled = true },
	},
	documentation = {
		auto_show = true
	},
	ghost_text = { enabled = true },
	list = { selection = { preselect = true, auto_insert = true } },
},
sources = {
	default = { "lsp", "path", "snippets", "buffer" },
},
cmdline = { enabled = false },
signature = { enabled = true },
})
