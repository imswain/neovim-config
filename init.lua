vim.g.mapleader = ' '
vim.g. maplocalleader = ' '
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.splitright = true
vim.o.splitbelow = true
vim.cmd('filetype plugin indent on')
vim.opt.list = true
vim.opt.listchars = { leadmultispace = '|···', tab = '| ', trail = '·' }
vim.o.scrolloff = 10
vim.o.cursorline = true
vim.o.confirm = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.showmode = false

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<leader>wh', '<C-W>h')
vim.keymap.set('n', '<leader>wj', '<C-W>j')
vim.keymap.set('n', '<leader>wk', '<C-W>k')
vim.keymap.set('n', '<leader>wl', '<C-W>l')

vim.pack.add ( {
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/mason-org/mason.nvim',
	'https://github.com/mason-org/mason-lspconfig.nvim',
} )
require('mason').setup {}
require('mason-lspconfig').setup {
	ensure_installed = { "lua_ls" }
}

vim.pack.add { { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' } }
vim.cmd.colorscheme 'catppuccin-nvim'
require('catppuccin').setup({
	flavour = 'mocha',
	auto_integrations = true
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.pack.add ( {
	'https://github.com/nvim-tree/nvim-tree.lua',
	'https://github.com/nvim-tree/nvim-web-devicons'
} )
require('nvim-tree').setup({
	diagnostics = {
		enable = true,
		show_on_dirs = true,
	},
	filters = {
		enable = false,
	}

})
vim.keymap.set( 'n', '<leader>b', '<cmd>NvimTreeOpen<CR>')

vim.pack.add { { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' } }
require('nvim-treesitter').install({ 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown',
  'markdown_inline', 'query', 'vim', 'vimdoc' })

vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })
require('mini.icons').setup({
	style = 'ascii'
})
require('mini.pick').setup()
require('mini.pairs').setup()
require('mini.statusline').setup()
require('mini.surround').setup()
vim.keymap.set('n', '<leader>sf', require('mini.pick').builtin.files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('mini.pick').builtin.help, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sb', require('mini.pick').builtin.buffers, { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>sg', function() require('mini.pick').builtin.files({ tool='git' }) end, { desc = '[S]earch [G]it Files' })

vim.pack.add({ 'https://github.com/lewis6991/gitsigns.nvim' })
local gitsigns =require('gitsigns')
gitsigns.setup({
	attach_to_untracked = true,
	current_line_blame = true,
	watch_gitdir = {
		follow_files = true
	},
	signs = {
		add = { text = '+' }, ---@diagnostic disable-line: missing-fields
		change = { text = '~' }, ---@diagnostic disable-line: missing-fields
		delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
		topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
		changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
	},
	-- gitsigns.nvim's recommended keymaps:
	on_attach = function(bufnr)
		-- Navigation
		vim.keymap.set('n', ']c', function()
		if vim.wo.diff then
		  vim.cmd.normal { ']c', bang = true }
		else
		  gitsigns.nav_hunk 'next'
		end
		end, { desc = 'Jump to next git [c]hange', buf = bufnr })

		vim.keymap.set('n', '[c', function()
		if vim.wo.diff then
		  vim.cmd.normal { '[c', bang = true }
		else
		  gitsigns.nav_hunk 'prev'
		end
		end, { desc = 'Jump to previous git [c]hange', buf = bufnr })

		-- Visual mode actions
		vim.keymap.set('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'git [s]tage hunk', buf = bufnr })
		vim.keymap.set('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'git [r]eset hunk', buf = bufnr })
		-- Normal mode actions
		vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk', buf = bufnr })
		vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk', buf = bufnr })
		vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer', buf = bufnr })
		vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer', buf = bufnr })
		vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk', buf = bufnr })
		vim.keymap.set('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'git preview hunk [i]nline', buf = bufnr })
		vim.keymap.set('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = 'git [b]lame line', buf = bufnr })
		vim.keymap.set('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index', buf = bufnr })
		vim.keymap.set('n', '<leader>hD', function() gitsigns.diffthis '~' end, { desc = 'git [D]iff against last commit', buf = bufnr })
		vim.keymap.set('n', '<leader>hQ', function() gitsigns.setqflist 'all' end, { desc = 'git hunk [Q]uickfix list (all files in repo)', buf = bufnr })
		vim.keymap.set('n', '<leader>hq', gitsigns.setqflist, { desc = 'git hunk [q]uickfix list (all changes in this file)', buf = bufnr })
		-- Toggles
		vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line', buf = bufnr })
		vim.keymap.set('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = '[T]oggle git intra-line [w]ord diff', buf = bufnr })
		-- Text object
		vim.keymap.set({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'text object [i]nside [h]unk', buf = bufnr })
	end
})

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(ev)
		local name = ev.data.spec.name
		if name == 'nvim-treesitter' then
			if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
			vim.cmd 'TSUpdate'
			return
		end
	end
})

local available_parsers = require('nvim-treesitter').get_available()
vim.api.nvim_create_autocmd('FileType', {
	callback = function(args)
		local buf, filetype = args.buf, args.match
		local language = vim.treesitter.language.get_lang(filetype)
		if not language then return end

		local function treesitter_try_attach()
			if not vim.treesitter.language.add(language) then return end
			if not vim.api.nvim_buf_is_valid(buf) then return end
			vim.treesitter.start(buf, language)
			-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
			-- vim.wo.foldmethod = 'expr'
			local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil
			if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
		end

		local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

		if vim.tbl_contains(installed_parsers, language) then
			treesitter_try_attach()
		elseif vim.tbl_contains(available_parsers, language) then
			require('nvim-treesitter').install(language):await(function() treesitter_try_attach() end)
		else
			treesitter_try_attach()
		end
	end
})

vim.api.nvim_create_user_command('Git', function(opts)
	local command = vim.trim('git ' .. opts.args)
	print(command)
	print(vim.fn.system(command))
	require('gitsigns').refresh()
end, { nargs = '*' })

 -- Diagnostic Config & Keymaps
 --  See `:help vim.diagnostic.Opts`
 vim.diagnostic.config {
	 update_in_insert = false,
	 severity_sort = true,
	 float = { border = 'rounded', source = 'if_many' },
	 underline = { severity = { min = vim.diagnostic.severity.WARN } },

	 -- Can switch between these as you prefer
	 virtual_text = true, -- Text shows up at the end of the line
	 virtual_lines = false, -- Text shows up underneath the line, with virtual lines

	 -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
	 jump = {
		 on_jump = function(_, bufnr)
			 vim.diagnostic.open_float {
				 bufnr = bufnr,
				 scope = 'cursor',
				 focus = false,
			 }
		 end,
	 },
 }

 vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
