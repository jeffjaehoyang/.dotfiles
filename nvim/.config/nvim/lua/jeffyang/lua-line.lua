local function Liverpool()
    return [[YNWA]]
end

require("lualine").setup {
    options = {
        icons_enabled = true,
        theme = "gruvbox-material",
        component_separators = {left = "❭", right = "❭"},
        section_separators = {left = "", right = ""},
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true
    },
    sections = {
        lualine_a = {"mode"},
        lualine_b = {"branch", "diagnostics"},
        lualine_c = {"diff", "filename"},
        lualine_x = {Liverpool, "encoding", "fileformat", "filetype"},
        lualine_y = {"hostname"},
        lualine_z = {"location"}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {"filename"},
        lualine_x = {"location"},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}
