local status_ok, catppuccin = pcall(require, "catppuccin")

if not status_ok then
    return
end

catppuccin.setup({
    transparent_background = false,
    term_colors = true,
    styles = {
        comments = "NONE",
        functions = "NONE",
        keywords = "NONE",
        strings = "NONE",
        variables = "NONE",
    },
    integrations = {
        treesitter = true,
        native_lsp = {
            enabled = true,
            underlines = {
                errors = "undercurl",
                hints = "undercurl",
                warnings = "undercurl",
                information = "undercurl",
            },
        },
        lsp_trouble = true,
        cmp = true,
        gitsigns = true,
        telescope = true,
        nvimtree = {
            enabled = true,
            transparent_panel = false,
        },
        bufferline = true,
        ts_rainbow = true,
    },
})

local config = require("catppuccin.config").options
local nvimtree = config.integrations.nvimtree
local colors = require("catppuccin.api.colors").get_colors()

catppuccin.remap({
    bashTSFuncBuiltin = { style = "NONE" },
    bashTSParameter = { style = "NONE" },
    cssTSProperty = { style = "NONE" },
    ErrorMsg = { style = "NONE" },
    NormalFloat = { bg = colors.black2 },
    NvimTreeStatusLine = {
        bg = nvimtree.enabled and colors.black1 or "none",
        fg = nvimtree.enabled and colors.black1 or "none",
    },
    NvimTreeStatuslineNc = {
        bg = nvimtree.enabled and colors.black1 or "none",
        fg = nvimtree.enabled and colors.black1 or "none",
    },
    NvimTreeVertSplit = { bg = nvimtree.enabled and colors.black1 or "NONE" },
    TSProperty = { style = "NONE" },
    TSInclude = { style = "italic" },
    TSOperator = { style = "NONE" },
    TSKeywordOperator = { style = "NONE" },
    TSPunctSpecial = { style = "NONE" },
    TSFloat = { style = "NONE" },
    TSNumber = { style = "NONE" },
    TSBoolean = { style = "italic" },
    TSConditional = { style = "italic" },
    TSRepeat = { style = "italic" },
    TSException = { style = "NONE" },
    TSConstBuiltin = { style = "italic" },
    TSFuncBuiltin = { style = "italic" },
    TSTypeBuiltin = { style = "italic" },
    TSVariableBuiltin = { style = "italic" },
    TSFunction = { style = "NONE" },
    TSParameter = { style = "NONE" },
    TSKeywordFunction = { style = "italic" },
    TSKeyword = { style = "italic" },
    TSKeywordReturn = { style = "italic" },
    TSMethod = { style = "italic" },
    TSNamespace = { style = "NONE" },
    TSStringRegex = { style = "NONE" },
    TSVariable = { style = "NONE" },
    TSTagAttribute = { style = "NONE" },
    TSURI = { style = "underline" },
    TSLiteral = { style = "italic" },
    TSEmphasis = { style = "NONE" },
    TSStringEscape = { style = "NONE" },
    typescriptTSProperty = { style = "NONE" },
})

vim.cmd([[colorscheme catppuccin]])
