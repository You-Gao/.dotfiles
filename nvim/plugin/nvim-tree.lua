require('nvim-tree').setup({
    filesystem_watchers = {
        enable = true,
        ignore_dirs = { "roblox" } -- Crazy memory usage for game caches
    },
})
