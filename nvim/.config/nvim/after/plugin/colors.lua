function ColorMyPencils(color)
    color = color or "kanagawa"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, 'LineNr', { fg = '#1560C0' })
    vim.api.nvim_set_hl(0, 'SignColumn', { fg = 'None', bg = 'None' })

    vim.api.nvim_set_hl(0, 'SignColumn', { bg = "none" })
    vim.api.nvim_set_hl(0, 'DiagnosticError', { bg = "none" })
    vim.api.nvim_set_hl(0, 'DiagnosticSignWarn', { bg = "none", fg = "orange" })
    vim.api.nvim_set_hl(0, 'DiagnosticSignError', { bg = "none", fg = "red" })
    vim.api.nvim_set_hl(0, 'DiagnosticSignInfo', { bg = "none", fg = "cyan" })
    vim.api.nvim_set_hl(0, 'DiagnosticSignHint', { bg = "none", fg = "green" })
end

ColorMyPencils()
