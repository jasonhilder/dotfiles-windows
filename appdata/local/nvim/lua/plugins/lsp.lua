return {
    {
        -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        lazy = true,
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { "williamboman/mason.nvim", config = true },
            'williamboman/mason-lspconfig.nvim',
            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            {
                'j-hui/fidget.nvim',
                config = function()
                    require("fidget").setup {}
                end,
            }
        }
    },
    {
        -- virtual text hints
        "ray-x/lsp_signature.nvim",
        lazy = true,
        event = "VeryLazy",
        opts = {
            floating_window = false,
            floating_window_above_cur_line = false,
        },
        config = function(_, opts) require'lsp_signature'.setup(opts) end
    },
    {
        -- Better placed diagnostic messages
        'dgagn/diagflow.nvim',
        event = 'LspAttach',
        opts = {}
    },
    -- auto completion
    {
        "hrsh7th/nvim-cmp",
        lazy = true,
        version = false, -- last release is way too old
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            'L3MON4D3/LuaSnip',
            -- "saadparwaiz1/cmp_luasnip",
            -- Adds a number of user-friendly snippets
            -- 'rafamadriz/friendly-snippets'
        },
        opts = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            require('luasnip.loaders.from_vscode').lazy_load()
            luasnip.config.setup {}

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert {
                    -- Select the [n]ext item
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    -- Select the [p]revious item
                    ['<C-p>'] = cmp.mapping.select_prev_item(),

                    -- Accept ([y]es) the completion.
                    --  This will auto-import if your LSP supports it.
                    --  This will expand snippets if the LSP sent a snippet.
                    ['<CR>'] = cmp.mapping.confirm { select = true },

                    -- Manually trigger a completion from nvim-cmp.
                    --  Generally you don't need this, because nvim-cmp will display
                    --  completions whenever it has completion options available.
                    ['<C-Space>'] = cmp.mapping.complete {},

                    -- Think of <c-l> as moving to the right of your snippet expansion.
                    --  So if you have a snippet that's like:
                    --  function $name($args)
                    --    $body
                    --  end
                    --
                    -- <c-l> will move you to the right of each of the expansion locations.
                    -- <c-h> is similar, except moving you backwards.
                    ['<C-l>'] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { 'i', 's' }),
                    ['<C-h>'] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { 'i', 's' }),

                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }
            }
        end
    }
}
