-- =============================================================
-- specter.lua — a neovim colorscheme
-- Derived from the Waybar / Wofi / Neo system palette:
--   deep near-black purple background, muted mauve UI,
--   Monokai-style syntax contrast (green strings, amber
--   numbers, cyan types, hot-pink keywords, lavender funcs)
--
-- Install: copy to ~/.config/nvim/colors/specter.lua
-- Apply:   vim.cmd("colorscheme specter")  (add to your config)
-- =============================================================

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end
vim.g.colors_name = "specter"
vim.o.background = "dark"

local hi = function(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
end

-- =============================================================
-- PALETTE
-- =============================================================

local c = {
	-- ── Backgrounds ──────────────────────────────────────────
	bg = "#080407", -- near-black, main canvas
	bg_dim = "#0c080b", -- inactive splits / tree
	bg_hl = "#160e13", -- cursorline, subtle accent
	bg_visual = "#221429", -- visual selection
	bg_search = "#3d1f2f", -- search highlight bg
	bg_popup = "#100a0e", -- float / telescope bg
	bg_match = "#2a1520", -- lsp reference, matchparen bg

	-- ── Structural UI ─────────────────────────────────────────
	border = "#3e2c36", -- panels, separators (from waybar)
	border_hi = "#7f5a6e", -- hovered / active borders
	fold = "#4d3040", -- fold column, indent ghost
	line_nr = "#3e2c36",

	-- ── Text ──────────────────────────────────────────────────
	fg = "#d4c8d0", -- main foreground
	fg_muted = "#8c6880", -- dimmed text, inactive
	fg_subtle = "#79566a", -- very dim UI chrome
	fg_bright = "#e8dde4", -- selected / active text
	comment = "#4d3040", -- comments: dark, readable

	-- ── Syntax — high-contrast against the purple-dark bg ─────
	--   Hot pink / magenta → keywords, control flow
	keyword = "#d4609a",
	--   Soft lavender → function names / calls
	func = "#b87fd4",
	--   Muted sage green → strings  (biggest contrast shift)
	string = "#8ab87a",
	--   Bright lime → escape sequences inside strings
	escape = "#b4e88a",
	--   Warm amber / orange → numbers, booleans
	number = "#d4906a",
	--   Desaturated cyan → types, classes
	type = "#6ab4c4",
	--   Warm pale gold → constants, enum members
	const = "#c8b07a",
	--   Light mauve → variables, identifiers (neutral)
	variable = "#c4b0c0",
	--   Pale lavender → function parameters
	param = "#d4bce0",
	--   Mid purple-pink → operators
	operator = "#a07890",
	--   Muted mauve → punctuation / brackets
	punct = "#79566a",
	--   Pale blue-grey → object properties / members
	property = "#a8c4d4",
	--   Gold → HTML/JSX attributes
	attr = "#c8b07a",
	--   Pink → HTML/JSX tag names
	tag = "#d4609a",
	--   Lavender → preprocessor, decorators, imports
	preproc = "#b87fd4",
	--   Pink → macros
	macro = "#d4609a",
	--   Cyan → built-in functions / values
	builtin = "#6ab4c4",
	--   Purple → links
	link = "#9880c4",
	--   Accent (from active workspace colour)
	accent = "#ffe9fc",

	-- ── Diagnostics ───────────────────────────────────────────
	error = "#c45a5a", -- matches waybar critical red
	warning = "#c4906a",
	info = "#6ab4c4",
	hint = "#8c6880",

	-- ── Git ───────────────────────────────────────────────────
	git_add = "#6a9860",
	git_del = "#a84848",
	git_chg = "#7878b8",

	none = "NONE",
}

-- =============================================================
-- EDITOR
-- =============================================================

hi("Normal", { fg = c.fg, bg = c.bg })
hi("NormalNC", { fg = c.fg, bg = c.bg_dim })
hi("NormalFloat", { fg = c.fg, bg = c.bg_popup })
hi("FloatBorder", { fg = c.border, bg = c.bg_popup })
hi("FloatTitle", { fg = c.fg_muted, bg = c.bg_popup, bold = true })

hi("Cursor", { fg = c.bg, bg = c.fg_bright })
hi("CursorIM", { fg = c.bg, bg = c.fg_bright })
hi("CursorLine", { bg = c.bg_hl })
hi("CursorColumn", { bg = c.bg_hl })
hi("CursorLineNr", { fg = c.fg_muted, bold = true })

hi("LineNr", { fg = c.line_nr })
hi("SignColumn", { fg = c.border, bg = c.none })
hi("ColorColumn", { bg = c.bg_dim })
hi("FoldColumn", { fg = c.fold, bg = c.none })
hi("Folded", { fg = c.fg_muted, bg = c.bg_hl })

hi("StatusLine", { fg = c.fg_muted, bg = c.bg_dim })
hi("StatusLineNC", { fg = c.fold, bg = c.bg_dim })
hi("WinBar", { fg = c.fg_subtle, bg = c.none })
hi("WinBarNC", { fg = c.fold, bg = c.none })
hi("WinSeparator", { fg = c.border })

hi("TabLine", { fg = c.fg_muted, bg = c.bg_dim })
hi("TabLineFill", { bg = c.bg_dim })
hi("TabLineSel", { fg = c.fg_bright, bg = c.bg, bold = true })

hi("Pmenu", { fg = c.fg, bg = c.bg_popup })
hi("PmenuSel", { fg = c.fg_bright, bg = c.bg_search, bold = true })
hi("PmenuSbar", { bg = c.bg_dim })
hi("PmenuThumb", { bg = c.border })
hi("PmenuExtra", { fg = c.fg_subtle, bg = c.bg_popup })

hi("Visual", { bg = c.bg_visual })
hi("VisualNOS", { bg = c.bg_visual })
hi("Search", { fg = c.fg_bright, bg = c.bg_search })
hi("CurSearch", { fg = c.bg, bg = c.keyword, bold = true })
hi("IncSearch", { fg = c.bg, bg = c.keyword })
hi("Substitute", { fg = c.bg, bg = c.string })

hi("MatchParen", { fg = c.accent, bg = c.bg_match, bold = true })

hi("NonText", { fg = c.fold })
hi("Whitespace", { fg = c.border })
hi("SpecialKey", { fg = c.fold })
hi("EndOfBuffer", { fg = c.border })
hi("Conceal", { fg = c.fg_subtle })

hi("Directory", { fg = c.type, bold = true })
hi("Title", { fg = c.keyword, bold = true })
hi("Question", { fg = c.string })
hi("MoreMsg", { fg = c.string })
hi("ModeMsg", { fg = c.fg_muted })
hi("MsgArea", { fg = c.fg })
hi("MsgSeparator", { fg = c.border })
hi("ErrorMsg", { fg = c.error })
hi("WarningMsg", { fg = c.warning })

hi("SpellBad", { sp = c.error, undercurl = true })
hi("SpellCap", { sp = c.warning, undercurl = true })
hi("SpellLocal", { sp = c.info, undercurl = true })
hi("SpellRare", { sp = c.hint, undercurl = true })

hi("QuickFixLine", { fg = c.fg_bright, bg = c.bg_search })
hi("qfLineNr", { fg = c.fg_subtle })
hi("qfFileName", { fg = c.type })

-- =============================================================
-- SYNTAX (classic Vim groups — fallback for non-TS)
-- =============================================================

hi("Comment", { fg = c.comment, italic = true })
hi("String", { fg = c.string })
hi("Character", { fg = c.string })
hi("Number", { fg = c.number })
hi("Float", { fg = c.number })
hi("Boolean", { fg = c.number })
hi("Constant", { fg = c.const })

hi("Identifier", { fg = c.variable })
hi("Function", { fg = c.func })

hi("Statement", { fg = c.keyword })
hi("Conditional", { fg = c.keyword })
hi("Repeat", { fg = c.keyword })
hi("Label", { fg = c.keyword })
hi("Operator", { fg = c.operator })
hi("Keyword", { fg = c.keyword })
hi("Exception", { fg = c.keyword })

hi("PreProc", { fg = c.preproc })
hi("Include", { fg = c.preproc })
hi("Define", { fg = c.preproc })
hi("Macro", { fg = c.macro })
hi("PreCondit", { fg = c.preproc })

hi("Type", { fg = c.type })
hi("StorageClass", { fg = c.keyword })
hi("Structure", { fg = c.type })
hi("Typedef", { fg = c.type })

hi("Special", { fg = c.escape })
hi("SpecialChar", { fg = c.escape })
hi("Tag", { fg = c.tag })
hi("Delimiter", { fg = c.punct })
hi("SpecialComment", { fg = c.fg_subtle, italic = true })
hi("Debug", { fg = c.warning })

hi("Underlined", { fg = c.link, underline = true })
hi("Ignore", { fg = c.fold })
hi("Error", { fg = c.error })
hi("Todo", { fg = c.bg, bg = c.warning, bold = true })

-- =============================================================
-- TREESITTER
-- =============================================================

-- Literals
hi("@string", { fg = c.string })
hi("@string.escape", { fg = c.escape })
hi("@string.special", { fg = c.escape })
hi("@string.regex", { fg = c.escape })
hi("@character", { fg = c.string })
hi("@character.special", { fg = c.escape })
hi("@number", { fg = c.number })
hi("@number.float", { fg = c.number })
hi("@float", { fg = c.number })
hi("@boolean", { fg = c.number })

-- Variables & identifiers
hi("@variable", { fg = c.variable })
hi("@variable.builtin", { fg = c.builtin })
hi("@variable.parameter", { fg = c.param })
hi("@variable.member", { fg = c.property })

-- Constants
hi("@constant", { fg = c.const })
hi("@constant.builtin", { fg = c.builtin })
hi("@constant.macro", { fg = c.macro })

-- Functions
hi("@function", { fg = c.func })
hi("@function.call", { fg = c.func })
hi("@function.builtin", { fg = c.builtin })
hi("@function.macro", { fg = c.macro })
hi("@function.method", { fg = c.func })
hi("@function.method.call", { fg = c.func })
hi("@constructor", { fg = c.type })

-- Keywords
hi("@keyword", { fg = c.keyword })
hi("@keyword.function", { fg = c.keyword })
hi("@keyword.operator", { fg = c.operator })
hi("@keyword.import", { fg = c.preproc })
hi("@keyword.return", { fg = c.keyword })
hi("@keyword.exception", { fg = c.keyword })
hi("@keyword.conditional", { fg = c.keyword })
hi("@keyword.repeat", { fg = c.keyword })
hi("@keyword.directive", { fg = c.preproc })
hi("@keyword.coroutine", { fg = c.keyword })

-- Types
hi("@type", { fg = c.type })
hi("@type.builtin", { fg = c.builtin })
hi("@type.definition", { fg = c.type })
hi("@type.qualifier", { fg = c.keyword })

-- Properties / namespaces
hi("@property", { fg = c.property })
hi("@attribute", { fg = c.attr })
hi("@namespace", { fg = c.type })
hi("@module", { fg = c.type })
hi("@module.builtin", { fg = c.builtin })

-- Operators & punctuation
hi("@operator", { fg = c.operator })
hi("@punctuation.bracket", { fg = c.punct })
hi("@punctuation.delimiter", { fg = c.punct })
hi("@punctuation.special", { fg = c.escape })

-- Labels / misc
hi("@label", { fg = c.keyword })
hi("@none", { fg = c.fg })
hi("@conceal", { fg = c.fg_subtle })
hi("@error", { fg = c.error })

-- Comments
hi("@comment", { fg = c.comment, italic = true })
hi("@comment.todo", { fg = c.bg, bg = c.warning, bold = true })
hi("@comment.note", { fg = c.bg, bg = c.info, bold = true })
hi("@comment.warning", { fg = c.bg, bg = c.warning, bold = true })
hi("@comment.error", { fg = c.bg, bg = c.error, bold = true })

-- HTML / JSX tags
hi("@tag", { fg = c.tag })
hi("@tag.attribute", { fg = c.attr })
hi("@tag.delimiter", { fg = c.punct })
hi("@tag.builtin", { fg = c.builtin })

-- Markup (markdown etc.)
hi("@markup.heading", { fg = c.keyword, bold = true })
hi("@markup.heading.1", { fg = c.keyword, bold = true })
hi("@markup.heading.2", { fg = c.func, bold = true })
hi("@markup.heading.3", { fg = c.type, bold = true })
hi("@markup.heading.4", { fg = c.string, bold = true })
hi("@markup.heading.5", { fg = c.const, bold = true })
hi("@markup.heading.6", { fg = c.fg_muted, bold = true })
hi("@markup.link", { fg = c.link, underline = true })
hi("@markup.link.url", { fg = c.link, underline = true })
hi("@markup.raw", { fg = c.string })
hi("@markup.raw.block", { fg = c.string })
hi("@markup.italic", { fg = c.param, italic = true })
hi("@markup.strong", { fg = c.fg_bright, bold = true })
hi("@markup.strikethrough", { fg = c.fg_subtle, strikethrough = true })
hi("@markup.list", { fg = c.operator })
hi("@markup.list.checked", { fg = c.string })
hi("@markup.list.unchecked", { fg = c.fg_subtle })

-- Diff
hi("@diff.plus", { fg = c.git_add })
hi("@diff.minus", { fg = c.git_del })
hi("@diff.delta", { fg = c.git_chg })

-- =============================================================
-- LSP DIAGNOSTICS
-- =============================================================

hi("DiagnosticError", { fg = c.error })
hi("DiagnosticWarn", { fg = c.warning })
hi("DiagnosticInfo", { fg = c.info })
hi("DiagnosticHint", { fg = c.hint })
hi("DiagnosticOk", { fg = c.string })

hi("DiagnosticUnderlineError", { sp = c.error, undercurl = true })
hi("DiagnosticUnderlineWarn", { sp = c.warning, undercurl = true })
hi("DiagnosticUnderlineInfo", { sp = c.info, undercurl = true })
hi("DiagnosticUnderlineHint", { sp = c.hint, undercurl = true })

hi("DiagnosticVirtualTextError", { fg = c.error, italic = true })
hi("DiagnosticVirtualTextWarn", { fg = c.warning, italic = true })
hi("DiagnosticVirtualTextInfo", { fg = c.info, italic = true })
hi("DiagnosticVirtualTextHint", { fg = c.hint, italic = true })

hi("DiagnosticFloatingError", { fg = c.error })
hi("DiagnosticFloatingWarn", { fg = c.warning })
hi("DiagnosticFloatingInfo", { fg = c.info })
hi("DiagnosticFloatingHint", { fg = c.hint })

hi("DiagnosticSignError", { fg = c.error })
hi("DiagnosticSignWarn", { fg = c.warning })
hi("DiagnosticSignInfo", { fg = c.info })
hi("DiagnosticSignHint", { fg = c.hint })

-- LSP tokens / misc
hi("LspReferenceText", { bg = c.bg_match })
hi("LspReferenceRead", { bg = c.bg_match })
hi("LspReferenceWrite", { bg = c.bg_match, bold = true })
hi("LspSignatureActiveParameter", { fg = c.accent, bold = true })
hi("LspCodeLens", { fg = c.comment, italic = true })
hi("LspInlayHint", { fg = c.fold, italic = true })

-- =============================================================
-- GITSIGNS
-- =============================================================

hi("GitSignsAdd", { fg = c.git_add })
hi("GitSignsChange", { fg = c.git_chg })
hi("GitSignsDelete", { fg = c.git_del })
hi("GitSignsAddLn", { bg = "#0d1e0d" })
hi("GitSignsChangeLn", { bg = "#0d0d1e" })
hi("GitSignsDeleteLn", { bg = "#1e0d0d" })
hi("GitSignsTopdelete", { fg = c.git_del })
hi("GitSignsChangedelete", { fg = c.git_del })
hi("GitSignsUntracked", { fg = c.git_add })

-- =============================================================
-- NVIM-TREE
-- =============================================================

hi("NvimTreeNormal", { fg = c.fg_muted, bg = c.bg_dim })
hi("NvimTreeNormalNC", { fg = c.fg_muted, bg = c.bg_dim })
hi("NvimTreeEndOfBuffer", { fg = c.bg_dim, bg = c.bg_dim })
hi("NvimTreeRootFolder", { fg = c.keyword, bold = true })
hi("NvimTreeFolderIcon", { fg = c.border_hi })
hi("NvimTreeFolderName", { fg = c.fg_muted })
hi("NvimTreeOpenedFolderName", { fg = c.fg, bold = true })
hi("NvimTreeEmptyFolderName", { fg = c.fold })
hi("NvimTreeFileName", { fg = c.fg })
hi("NvimTreeExecFile", { fg = c.string, bold = true })
hi("NvimTreeSpecialFile", { fg = c.escape, underline = true })
hi("NvimTreeSymlink", { fg = c.type })
hi("NvimTreeImageFile", { fg = c.property })
hi("NvimTreeGitDirty", { fg = c.warning })
hi("NvimTreeGitStaged", { fg = c.git_add })
hi("NvimTreeGitNew", { fg = c.git_add })
hi("NvimTreeGitDeleted", { fg = c.git_del })
hi("NvimTreeGitIgnored", { fg = c.fold })
hi("NvimTreeWinSeparator", { fg = c.border, bg = c.bg_dim })
hi("NvimTreeCursorLine", { bg = c.bg_hl })
hi("NvimTreeIndentMarker", { fg = c.border })
hi("NvimTreeLiveFilterPrefix", { fg = c.keyword })
hi("NvimTreeLiveFilterValue", { fg = c.fg })
hi("NvimTreeBookmark", { fg = c.keyword })

-- =============================================================
-- TELESCOPE
-- =============================================================

hi("TelescopeNormal", { fg = c.fg, bg = c.bg_popup })
hi("TelescopeBorder", { fg = c.border, bg = c.bg_popup })
hi("TelescopePromptBorder", { fg = c.border_hi, bg = c.bg_popup })
hi("TelescopePromptNormal", { fg = c.fg, bg = c.bg_popup })
hi("TelescopePromptPrefix", { fg = c.keyword, bg = c.bg_popup })
hi("TelescopePromptTitle", { fg = c.fg_subtle, bg = c.bg_popup, bold = true })
hi("TelescopeResultsNormal", { fg = c.fg, bg = c.bg_popup })
hi("TelescopeResultsBorder", { fg = c.border, bg = c.bg_popup })
hi("TelescopeResultsTitle", { fg = c.fg_subtle, bg = c.bg_popup })
hi("TelescopePreviewNormal", { fg = c.fg, bg = c.bg_popup })
hi("TelescopePreviewBorder", { fg = c.border, bg = c.bg_popup })
hi("TelescopePreviewTitle", { fg = c.fg_subtle, bg = c.bg_popup })
hi("TelescopeMatching", { fg = c.accent, bold = true })
hi("TelescopeSelection", { fg = c.fg_bright, bg = c.bg_search })
hi("TelescopeSelectionCaret", { fg = c.keyword, bg = c.bg_search })
hi("TelescopeMultiSelection", { fg = c.type, bg = c.bg_search })
hi("TelescopeMultiIcon", { fg = c.keyword })

-- =============================================================
-- MINI.INDENTSCOPE
-- =============================================================

hi("MiniIndentscopeSymbol", { fg = c.border_hi })
hi("MiniIndentscopePrefix", { nocombine = true })

-- =============================================================
-- FLASH
-- =============================================================

hi("FlashBackdrop", { fg = c.comment })
hi("FlashMatch", { fg = c.fg_bright, bg = c.bg_search })
hi("FlashCurrent", { fg = c.bg, bg = c.keyword, bold = true })
hi("FlashLabel", { fg = c.bg, bg = c.accent, bold = true })
hi("FlashPrompt", { fg = c.fg_muted })
hi("FlashCursor", { fg = c.bg, bg = c.fg_bright })

-- =============================================================
-- DIFF (built-in)
-- =============================================================

hi("DiffAdd", { fg = c.git_add, bg = "#0d1e0d" })
hi("DiffChange", { fg = c.git_chg, bg = "#0d0d1e" })
hi("DiffDelete", { fg = c.git_del, bg = "#1e0d0d" })
hi("DiffText", { fg = c.fg_bright, bg = "#1a1a38", bold = true })

-- =============================================================
-- LANGUAGE-SPECIFIC OVERRIDES
-- =============================================================

-- Lua: method calls on self share property colour
hi("@lsp.type.property.lua", { fg = c.property })

-- Go: type params
hi("@lsp.type.typeParameter", { fg = c.type, italic = true })

-- CSS / HTML: extra clarity
hi("@string.special.url", { fg = c.link, underline = true })
hi("@attribute.html", { fg = c.attr })

-- JSON keys deserve slightly more pop
hi("@property.json", { fg = c.property })
hi("@string.json", { fg = c.string })

-- Bash/shell: builtins stand out
hi("@function.builtin.bash", { fg = c.builtin })

-- =============================================================
-- LUALINE THEME
-- =============================================================

local lualine_theme = {
	normal = {
		a = { fg = c.bg, bg = c.keyword, gui = "bold" },
		b = { fg = c.fg, bg = c.border },
		c = { fg = c.fg_muted, bg = c.bg_dim },
	},
	insert = {
		a = { fg = c.bg, bg = c.string, gui = "bold" },
		b = { fg = c.fg, bg = c.border },
		c = { fg = c.fg_muted, bg = c.bg_dim },
	},
	visual = {
		a = { fg = c.bg, bg = c.warning, gui = "bold" },
		b = { fg = c.fg, bg = c.border },
		c = { fg = c.fg_muted, bg = c.bg_dim },
	},
	replace = {
		a = { fg = c.bg, bg = c.number, gui = "bold" },
		b = { fg = c.fg, bg = c.border },
		c = { fg = c.fg_muted, bg = c.bg_dim },
	},
	command = {
		a = { fg = c.bg, bg = c.type, gui = "bold" },
		b = { fg = c.fg, bg = c.border },
		c = { fg = c.fg_muted, bg = c.bg_dim },
	},
	inactive = {
		a = { fg = c.fg_subtle, bg = c.bg_dim },
		b = { fg = c.fg_subtle, bg = c.bg_dim },
		c = { fg = c.fg_subtle, bg = c.bg_dim },
	},
}

vim.g.elderspectre_lualine = lualine_theme
