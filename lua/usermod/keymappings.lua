-- Neovim keymappings, loaded from init.lua
local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- toggle for vimwiki list items
-- keymap("n", "<C-l>", "<Plug>VimwikiToggleListItem",default_opts)

-- hjkl movement in INSERT mode with Alt
keymap("i", "<A-h>", "<C-o>h",default_opts)
keymap("i", "<A-j>", "<C-o>gj",default_opts)
keymap("i", "<A-k>", "<C-o>gk",default_opts)
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

-- Trouble conf
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

