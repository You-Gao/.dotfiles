-- Philosophy: personally have used every keymap and know what they do
-- Every under personal is personal, the rest are sane defaults for the plugin, other plugins bindings are in their own windows.
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- PERSONAL
map('n', '<C-d>', '<Cmd>BufferDelete<CR>', opts)
map('n', '<C-s>', ':w<CR>', opts)
map('n', '<ESC>', '<Cmd>:q<CR>', opts)

map('n', 'cd', ':cd %:p:h<CR>', opts)
map('n', 'bo', ':browse oldfiles<CR>', opts)

map('n', '<leader>t', ':NvimTreeToggle<CR>', opts)
map('n', '<leader>o', '<Cmd>Telescope find_files<cr>', opts)
map('n', '<leader>a', ':AerialToggle<CR>', opts)
map('n', '<leader>s', '<Cmd>lua require("spectre").toggle()<CR>', opts)

-- BARBAR
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)

map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)

map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

-- LuaSnip
local ls = require("luasnip")
map({"i"}, "<C-k>", function() ls.expand() end, opts)
map({"i", "s"}, "<C-z>", function() ls.jump( 1) end, opts)
map({"i", "s"}, "<C-x>", function() ls.jump(-1) end, opts)
map({"i", "s"}, "<C-e>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, opts)

-- Spectre
map('n', '<leader>sr', '<Cmd>lua require("spectre.actions").run_replace()<CR>', opts)

-- Treewalker
vim.keymap.set({ 'n', 'v' }, '<C-k>', '<Cmd>Treewalker Up<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-j>', '<Cmd>Treewalker Down<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-h>', '<Cmd>Treewalker Left<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-l>', '<Cmd>Treewalker Right<cr>', { silent = true })

vim.keymap.set('n', '<C-A-k>', '<Cmd>Treewalker SwapUp<cr>', { silent = true })
vim.keymap.set('n', '<C-A-j>', '<Cmd>Treewalker SwapDown<cr>', { silent = true })
vim.keymap.set('n', '<C-A-h>', '<Cmd>Treewalker SwapLeft<cr>', { silent = true })
vim.keymap.set('n', '<C-A-l>', '<Cmd>Treewalker SwapRight<cr>', { silent = true })

-- Ufo
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

