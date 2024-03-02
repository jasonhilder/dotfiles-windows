return {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
        -- Change the default shell. Can be a string or a function returning a string
        shell = vim.o.shell,
        open_mapping = [[<c-j>]],
        direction = 'tab'
    }
}
