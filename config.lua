-- general
lvim.log.level = "warn"
lvim.format_on_save = true
vim.cmd [[colorscheme darkplus]]
lvim.colorscheme = "darkplus"

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
vim.o.scrolloff = 0

-- Search / Find
keymap("n", "<Esc>", "<Cmd>noh<CR>", opts)
keymap("n", "?", "/", opts)
keymap("n", "/", "?", opts)
keymap("n", "<S-F>", "<Cmd>lua require('telescope.builtin').live_grep()<CR>", opts)
keymap("n", "f", "<Cmd>Telescope find_files<CR>", opts)

-- Commenting
keymap("n", "ö", "<Cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
keymap("v", "ö", "<Esc><Cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", opts)

-- Resize/Window
keymap("n", "<Up>", "<Cmd>resize +2<CR>", opts)
keymap("n", "<Down>", "<Cmd>resize -2<CR>", opts)
keymap("n", "<Left>", "<Cmd>vertical resize +2<CR>", opts)
keymap("n", "<Right>", "<Cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Copy/Paste
keymap("v", "p", '"_dP', opts)

-- Select/Delete/Rename
keymap("v", "w", "iw", opts)
keymap("v", '"', 'i"', opts)
keymap("n", "cw", "ciw", opts)
keymap("n", ",rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)

-- Plugins
require('hop').setup()
require('cinnamon').setup()
keymap("n", "s", "<Cmd>HopWord<CR>", opts)
keymap("n", "§", "<Cmd>BufferLineCycleNext<CR>", opts)

-- Navigation
lvim.keys.normal_mode["H"] = false
lvim.keys.normal_mode["M"] = false
lvim.keys.normal_mode["L"] = false
keymap("n", "<backspace>", '^', opts)
keymap("n", " ", '$', opts)

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = ","
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
vim.wo.relativenumber = true

-- Additional Plugins
lvim.plugins = {
  { "tpope/vim-surround" },
  { "phaazon/hop.nvim" },
  { "declancm/cinnamon.nvim" },
  { "alvan/vim-closetag" },
  { "martinsione/darkplus.nvim" }
}

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
-- lvim.builtin.nvimtree.show_icons.git = 1

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "css",
  "java",
  "javascript",
  "json",
  -- "c",
  -- "lua",
  -- "python",
  -- "rust",
  "tsx",
  "typescript",
  -- "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true


-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }


-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
