vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind
	if name == 'nvim-treesitter' and kind == 'update' then
		if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
		vim.cmd('TSUpdate')
	end
end })

-- Language 
vim.pack.add({
	-- LSP/Treesitter
	'neovim/nvim-lspconfig',
	'nvim-treesitter/nvim-treesitter',

	-- GoToPreview
	'https://github.com/nvim-telescope/telescope.nvim',
	'https://github.com/rmagatti/logger.nvim',
	'https://github.com/rmagatti/goto-preview',

	-- Sidebar
	'https://github.com/stevearc/aerial.nvim',

	-- Diagnostics
	'https://github.com/rachartier/tiny-inline-diagnostic.nvim',

	-- Linter
	'https://github.com/mfussenegger/nvim-lint'

})

vim.api.nvim_create_autocmd("FileType", { -- Ensure treesitter parser starts
  pattern = { "python", "lua", "markdown" },
  callback = function()
    vim.treesitter.start()
  end,
})

vim.diagnostic.config({ virtual_text = false }) -- Setting for tiny-inline-diagnostic

vim.api.nvim_create_autocmd({ "BufWritePost" }, { -- Autocommand for Linting
  callback = function()
    require("lint").try_lint()
  end,
})


--CMP
vim.pack.add({
	"rafamadriz/friendly-snippets",
	"https://github.com/L3MON4D3/LuaSnip",
	"saghen/blink.cmp"
})

-- Developer Tools
vim.pack.add({
	-- Telescope
	"https://github.com/nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",

	-- Git
	"https://github.com/NeogitOrg/neogit",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/sindrets/diffview.nvim",
})

-- Navigation/Power Tools
vim.pack.add({
	-- "https://github.com/tris203/precognition.nvim",
	"https://github.com/aaronik/Treewalker.nvim",
	"https://github.com/folke/flash.nvim",
	"https://github.com/nvim-pack/nvim-spectre",
	"https://github.com/gelguy/wilder.nvim",
    "https://github.com/kevinhwang91/nvim-ufo",
    "https://github.com/kevinhwang91/promise-async",
	-- "https://github.com/mbbill/undotree",
	-- "https://github.com/akinsho/toggleterm.nvim",
	-- "https://github.com/folke/which-key.nvim"
})

-- UI
vim.pack.add({
	"https://github.com/oskarnurm/koda.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/RRethy/vim-illuminate",
	"https://github.com/nvimdev/dashboard-nvim",
	"https://github.com/nvim-tree/nvim-tree.lua",

	-- Bar
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/romgrk/barbar.nvim"
})

require('options')
require('keybinds')

vim.cmd.colorscheme('koda')

local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.enable({ 'lua_ls' }, { capabilities = capabilities})
vim.lsp.enable({ 'pyright' }, { capabilities = capabilities})
vim.lsp.enable({ 'marksman' }, { capabilities = capabilities})


