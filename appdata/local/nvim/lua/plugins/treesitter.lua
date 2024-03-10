------------------------------------------------------------------------------
-- Treesitter
---------------------------------------------------------------------------------
return {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    build = ":TSUpdate",
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("nvim-treesitter.configs").setup {
            ensure_installed = {
                "vim",
                "lua",
                "c",
                "go",
                -- "rust",
                -- "javascript",
                -- "typescript",
                -- "html"
            },
            highlight = { enable = true }
        }
    end
}
