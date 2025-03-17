require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "rust", "lua", "vim", "vimdoc", "query", "python", "javascript", "typescript", "markdown", "markdown_inline", "html", "css" },

  sync_install = false,

  auto_install = true,

  ignore_install = { }, -- Nothing ignored now

  highlight = {
    enable = true,

    disable = {}, -- Specific to the user's preference

    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    additional_vim_regex_highlighting = { "markdown" },
  },
  
  indent = {
    enable = true,
    disable = { "yaml" }, -- Adjust this based on your needs
  },
  
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
}
