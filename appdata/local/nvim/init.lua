---------------------------------------------------------------------------------
-- Bootstrap Package Manager
-- https://github.com/folke/lazy.nvim `:help lazy.nvim.txt` for more info
---------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)
---------------------------------------------------------------------------------
-- [[ AUTOCMDS ]]
---------------------------------------------------------------------------------
-- Highlight on Yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})
vim.cmd[[autocmd FileType help wincmd L]]
---------------------------------------------------------------------------------
-- [[ OPTIONS ]]
---------------------------------------------------------------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.mouse = 'a'
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.updatetime = 50
vim.o.breakindent = true
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
vim.o.showmode = false
---------------------------------------------------------------------------------
-- [[ KEYMAPS ]]
---------------------------------------------------------------------------------
vim.g.mapleader = " ";
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("i", "jj", "<Esc>")
-- clear search highlights
vim.keymap.set("n", "<leader>nh", ":noh<CR>", { desc = "Clear highlights" })
-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Window management
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Resize split up" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Resize split down" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize split left" })
vim.keymap.set("n", "<C-Right", "<cmd>vertical resize +2<CR>", { desc = "Resize split left" })
-- Buffer management
vim.keymap.set("n", "<leader>bl", "<cmd>b#<CR>", { desc = "Last edited buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<S-h>", "<cmd>bp<CR>", { desc = "previous buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bn<CR>", { desc = "next buffer" })
-- Stay in indent mode
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "unindent line" })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "indent line" })
-- Move selection and format
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selection up" })
-- Search for highlighted text in visual mode
vim.keymap.set("v", "/", "y/<C-R>\"<CR>N", { desc = "Search highlighted text" })
-- LSP binds
vim.keymap.set("n", "<leader>cr", ":lua vim.lsp.buf.rename() <CR>", { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>cf", ":lua vim.lsp.buf.format() <CR>", { desc = "Format code" })
-- Notes management
vim.keymap.set("n", "<leader>nd", ":exe 'r!date \"+\\%A, \\%Y-\\%m-\\%d\"' <CR>", { desc = "Insert Date" })
---------------------------------------------------------------------------------
-- [[ PLUGIN CONFIGS ]]
---------------------------------------------------------------------------------
require('lazy').setup({ { import = 'plugins' } })
------------------------------------------------------------------------------
-- LSP CONFIG
------------------------------------------------------------------------------
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}
--capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
end

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function()
        -- Create your keybindings here...
        local nmap = function(keys, func, desc)
            if desc then
                desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>cr', vim.lsp.buf.rename, 'Rename Symbol')
        -- nmap('<leader>ca', require('fzf-lua').lsp_code_actions, 'Code Actions')
        -- nmap('<leader>cs', require('fzf-lua').lsp_document_symbols, 'Document Symbols')

        -- nmap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
        -- nmap('gr', require('fzf-lua').lsp_definitions, 'Goto [R]eferences')
        nmap('gd', vim.lsp.buf.definition, 'Goto Definition')
        nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
        nmap('gi', vim.lsp.buf.implementation, 'Goto Implementation')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    end
})

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup {
    ensure_installed = {
        'lua_ls',
        -- 'intelephense',
        -- 'tsserver',
        -- 'rust_analyzer',
        -- 'gopls',
        -- 'zig????'
    },
}

local lspconfig = require "lspconfig"
vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
    { "┌", "FloatBorder" },
    { "─", "FloatBorder" },
    { "┐", "FloatBorder" },
    { "│", "FloatBorder" },
    { "┘", "FloatBorder" },
    { "─", "FloatBorder" },
    { "└", "FloatBorder" },
    { "│", "FloatBorder" },
}
-- LSP settings (for overriding per client)
local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}
------------------------------------------------------------------------------
-- SERVERS: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- RUST
------------------------------------------------------------------------------
-- lspconfig.rust_analyzer.setup {
--     handlers = handlers,
--     on_attach = on_attach,
--     capabilities = capabilities,
--     filetypes = { "rust" },
--     root_dir = lspconfig.util.root_pattern("Cargo.toml")
-- }
------------------------------------------------------------------------------
-- Golang
------------------------------------------------------------------------------
-- lspconfig.gopls.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
-- }
------------------------------------------------------------------------------
-- Javascript/Typescript
------------------------------------------------------------------------------
-- lspconfig.tsserver.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
-- }
------------------------------------------------------------------------------
-- LUA
------------------------------------------------------------------------------
lspconfig.lua_ls.setup {
    handlers = handlers,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}
------------------------------------------------------------------------------
-- C 
------------------------------------------------------------------------------
lspconfig.clangd.setup{
    handlers = handlers
}
