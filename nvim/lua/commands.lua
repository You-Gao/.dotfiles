local neoscroll_commands = {
              "NeoscrollEnablePM",
              "NeoscrollDisablePM",
              "NeoscrollEnableBufferPM",
              "NeoscrollDisableBufferPM",
              "NeoscrollEnableGlobalPM",
              "NeoscrollDisableGlobalePM",
              "NeoscrollDisablGlobalePM",
            }

            for _, cmd in ipairs(neoscroll_commands) do
              vim.api.nvim_del_user_command(cmd)
            end

vim.api.nvim_create_autocmd('WinClosed', {
  callback = function(tbl)
     vim.cmd('silent! bdelete' .. tbl.buf) 
  end,
})

vim.api.nvim_set_keymap('n', '<C-Tab>', ':bn<CR>', { noremap = true, silent = true })

-- Delete current buffer with Ctrl+w
vim.api.nvim_set_keymap('n', '<C-w>', ':bd<CR>', { noremap = true, silent = true })

-- Open NeoTree with Ctrl+Shift+e
vim.api.nvim_set_keymap('n', '<C-S-e>', ':Neotree toggle<CR>', { noremap = true, silent = true })

-- Save current buffer with Ctrl+s
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })

