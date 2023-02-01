local Plug = require 'usermod.vimplug'
local plugin_path = vim.fn.stdpath('data') .. '/plugged'
local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

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

-- hjkl movement in INSERT mode with Alt
keymap("i", "<A-h>", "<C-o>h",default_opts)
keymap("i", "<A-j>", "<C-o>j",default_opts)
keymap("i", "<A-k>", "<C-o>k",default_opts)
keymap("i", "<A-l>", "<C-o>l",default_opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', default_opts)
-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", default_opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", default_opts)
-- Better movement
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)
-- Ctrl-S saves
keymap("n","<C-s>",":w<CR>",{ noremap = true})
-- Ctrl-Q quits
keymap("n","<C-q>",":q<CR>",{ noremap = true })
-- Ctrl-N next buffer
keymap("n","<C-n>",":bn<CR>",{ noremap = false })
-- Ctrl-P previous buffer
keymap("n","<C-p>",":bp<CR>",{ noremap = false })
-- Map , to :
keymap("n",",",":",{ noremap = true })
-- Copy-Paste with Ctrl-C/V/X
keymap("","<C-V>",'"+gP',{ noremap = false })
keymap("v","<C-X>",'"+x',{ noremap = true })
keymap("v","<C-C>",'"+y',{ noremap = true })

vim.g.better_escape_interval = 200
vim.g.better_escape_shortcut = 'jj'

vim.notify = require("notify")
require('lualine').setup()
-- Trouble setup + keys
require('trouble').setup {
	position = "bottom",
	auto_open = true,
	auto_close = true
}
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
  {silent = true, noremap = true}
)
-- require'lspconfig'.gopls.setup{}

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'gopls','pylsp' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- lastplace
vim.g.lastplace_ignore_buftype = "quickfix,nofile,help"
vim.g.lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit"

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
