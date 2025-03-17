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
