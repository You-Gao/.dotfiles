require('nvim-treesitter.config').setup {
    -- install_dir = vim.fn.stdpath('data') .. '/site',
    ensure_installed = { "python", "markdown", "html", "css", "javascript"}, -- List of parsers
    highlight = {
        enable = true,              -- This effectively "autostarts" highlighting
        additional_vim_regex_highlighting = false,
    },
}
