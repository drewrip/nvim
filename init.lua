-- neovim config file

vim.g.mapleaer = "," -- Make sure to set `mapleader` before lazy so your mappings are correct

vim.opt.number = true

-- [[ Filetypes ]]
vim.opt.encoding = 'utf8'            -- str:  String encoding to use
vim.opt.fileencoding = 'utf8'        -- str:  File encoding to use

-- [[ Theme ]]
vim.opt.syntax = "ON"                -- str:  Allow syntax highlighting
vim.opt.termguicolors = true         -- bool: If term supports ui color then enable

-- [[ Search ]]
vim.opt.incsearch = true             -- bool: Use incremental search
vim.opt.hlsearch = false             -- bool: Highlight search matches

-- [[ Whitespace ]]
vim.opt.expandtab = true             -- bool: Use spaces instead of tabs
vim.opt.shiftwidth = 4               -- num:  Size of an indent
vim.opt.softtabstop = 4              -- num:  Number of spaces tabs count for in insert mode
vim.opt.tabstop = 4

-- Setup Lazy package manager

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
	{ "ellisonleao/gruvbox.nvim", lazy = "false" },
	{ "nvim-lualine/lualine.nvim" },
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/nvim-cmp" },
})

vim.o.backgrund = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

require("lualine").setup({
    options = {
        theme = "gruvbox",
        icons_enabled = false,
        section_separators = "",
        component_separators = "",
    }
})

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "rust_analyzer", "pyright" },
})


local cmp = require("cmp")
cmp.setup({
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
    }, {
        { name = 'buffer' },
    })
})

local lspconfig = require("lspconfig")
lspconfig.pyright.setup {}
lspconfig.rust_analyzer.setup {
  settings = {
    ['rust-analyzer'] = {},
  },
}

