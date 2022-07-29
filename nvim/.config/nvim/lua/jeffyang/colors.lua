vim.g.jeffyang_colorscheme = "tokyonight"

function ColorMyPencils()
    vim.g.tokyonight_transparent_sidebar = true
    vim.g.tokyonight_transparent = true
    vim.g.gruvbox_contrast_dark = "hard"
    vim.g.gruvbox_invert_selection = "0"
    vim.opt.background = "dark"
    vim.opt.termguicolors = true

    vim.cmd("colorscheme " .. vim.g.jeffyang_colorscheme)
    vim.cmd("hi Normal guibg=none")

    local hl = function(thing, opts)
        vim.api.nvim_set_hl(0, thing, opts)
    end

    hl("SignColumn", {
        bg = "none",
    })

    hl("ColorColumn", {
        ctermbg = 0,
        bg = "#555555",
    })

    hl("CursorLineNR", {
        bg = "None"
    })

    hl("Visual", {
        ctermfg = "none",
        bg = "#474747",
    })

    hl("LineNr", {
        fg = "#5eacd3"
    })

    hl("netrwDir", {
        fg = "#5eacd3"
    })

    hl("Comment", {
        ctermbg = 0,
        fg = "#707073"
    })

    hl("WinSeperator", {
        bg = "none"
    })

    hl("GitSignsAdd", {
        ctermbg = "none",
        fg = "green"
    })

    hl("GitSignsChange", {
        ctermbg = "none",
        fg = "blue"
    })

    hl("GitSignsDelete", {
        ctermbg = "none",
        fg = "red"
    })

    hl("DiagnosticError", {
        ctermbg = "none",
        fg = "red"
    })

    hl("DiagnosticSignError", {
        ctermbg = "none"
    })

    hl("DiagnosticSignWarn", {
        ctermbg = "none"
    })

    hl("DiagnosticSignHint", {
        ctermbg = "none"
    })

    hl("DiagnosticSignInfo", {
        ctermbg = "none"
    })

end

ColorMyPencils()

