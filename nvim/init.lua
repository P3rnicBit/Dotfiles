-- =========================================================
-- General stuff
-- =========================================================

-- Map leader
vim.g.mapleader = " "

-- Disabling swap files and enabling autowrite
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true -- persistent undo history even without swap

vim.opt.autowrite = true -- saves when switching buffers/running commands
vim.opt.autowriteall = true -- saves in more situations

-- System-wide clipboard
vim.g.clipboard = {
	name = "clip",
	copy = {
		["+"] = "wl-copy",
		["*"] = "wl-copy",
	},
	paste = {
		["+"] = "wl-paste --no-newline",
		["*"] = "wl-paste --no-newline",
	},
	cache_enabled = 0,
}

vim.opt.clipboard = "unnamedplus"

-- UI numbering and scrolloff
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.termguicolors = true

vim.opt.scrolloff = 12
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Case insesitivity when searching
vim.opt.ignorecase = true -- case insensitive by default
vim.opt.smartcase = true -- switches to case sensitive if you type a capital

-- =========================================================
-- LAZY.NVIM BOOTSTRAP
-- =========================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- =========================================================
-- PLUGINS
-- =========================================================

require("lazy").setup({

	-- =======================================================
	-- FILE TREE - A file explorer in NeoVim
	-- =======================================================

	{
		"nvim-tree/nvim-tree.lua",

		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		config = function()
			require("nvim-tree").setup()
		end,
	},

	-- =======================================================
	-- GITSIGNS - Shows Git indicators of what changed since last version
	-- =======================================================

	{
		"lewis6991/gitsigns.nvim",

		config = function()
			require("gitsigns").setup()
		end,
	},

	-- =======================================================
	-- TREESITTER - Syntax highlighting and code structurization
	-- =======================================================

	{
		"nvim-treesitter/nvim-treesitter",

		lazy = false,

		build = ":TSUpdate",

		config = function()
			require("nvim-treesitter").setup({
				ensure_installed = {
					-- Configurations
					"lua",
					"vim",
					"vimdoc",
					"bash",
					-- Websites
					"css",
					"html",
					"javascript",
					"typescript",
					-- Logic code
					"go",
					"c_sharp",
					"typescript",
					-- Save files or texts
					"json",
					"markdown",
				},

				highlight = {
					enable = true,
				},

				indent = {
					enable = true,
				},
			})
		end,
	},

	-- =======================================================
	-- LSP - Nvim's LSP server connection
	-- =======================================================

	{
		"neovim/nvim-lspconfig",
	},

	-- =======================================================
	-- MASON - LSP server installer
	-- =======================================================

	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- =======================================================
	-- Bridging MASON and LSP config
	-- =======================================================
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		config = function()
			local mason_lsp = require("mason-lspconfig")
			local lspconfig = require("lspconfig")
			mason_lsp.setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"html",
					"cssls",
					"bashls",
					"gopls",
					"pyright",
					"omnisharp",
				},
				handlers = {
					function(server_name)
						lspconfig[server_name].setup({})
					end,
				},
			})
		end,
	},

	-- =======================================================
	-- CMP - Code completion engine
	-- =======================================================

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP suggestions
			"hrsh7th/cmp-buffer", -- words from open buffers
			"hrsh7th/cmp-path", -- file path completion
			"L3MON4D3/LuaSnip", -- snippet engine (required)
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},

	-- =======================================================
	-- MATCHUP - Jumping between brackets
	-- =======================================================

	{
		"andymass/vim-matchup",
		event = "VeryLazy",
	},

	-- =======================================================
	-- INDENT SCOPE - Animated indent scope line showing the current block's depth
	-- =======================================================

	{
		"echasnovski/mini.indentscope",
		version = false,

		config = function()
			local indentscope = require("mini.indentscope")

			indentscope.setup({

				symbol = "▏",

				options = {
					try_as_border = true,
				},

				draw = {
					delay = 25,

					animation = indentscope.gen_animation.quadratic({
						easing = "out",
						duration = 80,
						unit = "step",
					}),
				},
			})
		end,
	},

	-- =======================================================
	-- TELESCOPE = Fzf for live grep, buffers, files, and more
	-- =======================================================

	{
		"nvim-telescope/telescope.nvim",

		dependencies = {
			"nvim-lua/plenary.nvim",
		},

		config = function()
			require("telescope").setup({

				defaults = {
					layout_strategy = "horizontal",
					sorting_strategy = "ascending",

					layout_config = {
						prompt_position = "top",
					},

					winblend = 10,
				},

				pickers = {

					find_files = {
						hidden = true,
						no_ignore = false,
					},

					live_grep = {
						additional_args = function()
							return { "--hidden" }
						end,
					},
				},
			})

			pcall(require("telescope").load_extension, "fzf")
		end,
	},

	-- =======================================================
	-- FZF NATIVE - Faster fzf
	-- =======================================================

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},

	-- =======================================================
	-- THEME
	-- =======================================================

	{
		dir = "~/.config/nvim/colors",
		name = "ElderSpectre",
		config = function()
			vim.cmd("colorscheme ElderSpectre")
		end,
	},

	-- =======================================================
	-- CONFORM - Smart code formatting
	-- =======================================================

	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					python = { "black" },
					go = { "goimports" },
					sh = { "shfmt" },
				},
				format_on_save = { timeout_ms = 500 }, -- optional: auto-format on save
			})
		end,
	},

	-- =========================================================
	-- BUFFERLINE - Shows and saves the buffer better
	-- =========================================================

	{
		"akinsho/bufferline.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("bufferline").setup()
		end,
	},

	-- =========================================================
	-- NEOCLIP - FzF through the register
	-- =========================================================

	{
		"AckslD/nvim-neoclip.lua",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("neoclip").setup()
		end,
	},

	-- =========================================================
	-- AUTOPAIRS = Automatically adds the 2nd pair for pairs
	-- =========================================================

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},

	-- =======================================================
	-- COMMENT - gcc to toggle line, gc in visual for block
	-- =======================================================

	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	-- =======================================================
	-- TODO COMMENTS - Highlights TODO, FIXME, NOTE, etc.
	-- =======================================================

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
	},

	-- =======================================================
	-- WHICH KEY - Shows available keybinds on leader press
	-- =======================================================

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup()
		end,
	},

	-- =======================================================
	-- LUALINE - Statusline showing mode, file, git, diagnostics
	-- =======================================================
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = vim.g.elderspectre_lualine,
					component_separators = { left = "│", right = "│" },
					section_separators = { left = "", right = "" },
					globalstatus = true,
				},
				sections = {
					lualine_a = { "location" },
					lualine_b = { "mode" },
					lualine_c = { "branch" },
					lualine_x = { "diff" },
					lualine_y = { { "filename", path = 1 }, "filesize" },
					lualine_z = { "progress" },
				},
			})
		end,
	},

	-- =========================================================
	-- YAZI - Integration of Yazi into NeoVim
	-- =========================================================

	{
		"mikavilpas/yazi.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("yazi").setup()
		end,
	},
})

-- =========================================================
-- KEYMAPS
-- =========================================================

-- nvim tree
vim.keymap.set("n", "<C-e>", ":NvimTreeToggle<CR>")

-- telescope
local builtin = require("telescope.builtin")

-- Fzf
vim.keymap.set("n", "<leader>fzf", builtin.find_files)
vim.keymap.set("n", "<leader>fzg", builtin.live_grep)

-- Formatting
vim.keymap.set("n", "<leader>f", function()
	require("conform").format()
end)

-- Adding plain lines without going into INSERT mode immediately
vim.keymap.set("n", "<leader>o", "o<Esc>")
vim.keymap.set("n", "<leader>O", "O<Esc>")

-- Cycling through the buffer
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")

-- Register cycling + searching
vim.keymap.set("n", "<leader>r", ":Telescope neoclip<CR>")

-- Opening Yazi
vim.keymap.set("n", "<leader>y", ":Yazi<CR>")
