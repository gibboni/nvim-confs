local Plug = require 'usermod.vimplug'
local plugin_path = vim.fn.stdpath('data') .. '/plugged'
local ORGMODE_LOADED = false

if file_exists(vim.fn.stdpath('data') .. '/LOAD_ORGMODE') then
	Plug ('nvim-treesitter/nvim-treesitter')
	Plug ('nvim-orgmode/orgmode')
end

Plug.begin(plugin_path)
Plug ('tpope/vim-fugitive')
Plug ('catppuccin/nvim', {as= 'catppuccin'})
Plug ('nvim-lualine/lualine.nvim')
Plug ('kyazdani42/nvim-web-devicons')
Plug ('nvim-zh/better-escape.vim')
Plug ('rcarriga/nvim-notify')
Plug ('neovim/nvim-lspconfig')
Plug ('hrsh7th/nvim-cmp')
Plug ('hrsh7th/cmp-nvim-lsp')
Plug ('saadparwaiz1/cmp_luasnip')
Plug ('L3MON4D3/LuaSnip')
Plug ('folke/lsp-colors.nvim')
Plug ('folke/trouble.nvim')
Plug ('farmergreg/vim-lastplace')
if file_exists(vim.fn.stdpath('data') .. '/LOAD_ORGMODE') then
	Plug ('nvim-treesitter/nvim-treesitter')
	Plug ('nvim-orgmode/orgmode')
	ORGMODE_LOADED = true
end
Plug.ends()

vim.opt.termguicolors = true
vim.opt.number = true
vim.g.mapleader = "."
vim.opt.encoding="utf-8"
vim.opt.wrap = true
vim.opt.linebreak=true
vim.opt.textwidth=0
vim.opt.wrapmargin=0
vim.cmd('set formatoptions-=t')
vim.opt.cmdheight=2
vim.opt.showmode=false
vim.cmd('colorscheme catppuccin')
vim.opt.hidden=true

require('usermod.keymappings')

if ORGMODE_LOADED then
	require('usermod.orgmodeconf')
end

vim.notify = require("notify")
require('lualine').setup()
-- Trouble setup + keys
require('trouble').setup {
	position = "right",
	auto_open = true,
	auto_close = false
}

-- luasnip setup
local luasnip = require 'luasnip'

-- lastplace
vim.g.lastplace_ignore_buftype = "quickfix,nofile,help"
vim.g.lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit"

-- lsp configs
require('usermod.lspconfs')

-- Neovide, if used
if vim.g.neovide then
	vim.o.guifont = "Iosevka Nerd Font:h14"
end

