-- Setup nvim-cmp.
local cmp = require "cmp"
local lspkind = require "lspkind"

cmp.setup(
    {
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
            end
        },
        mapping = {
            ["<Tab>"] = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end,
            ["<S-Tab>"] = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end,
            -- ["<Esc>"] = cmp.mapping.close(),
            ["<CR>"] = cmp.mapping.confirm({select = true}),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4)
        },
        sources = {
            {name = "nvim_lsp"}, -- For nvim-lsp
            -- {name = "ultisnips"}, -- For ultisnips user.
            {name = "nvim_lua"}, -- for nvim lua function
            {name = "path"}, -- for path completion
            {name = "buffer", keyword_length = 4}, -- for buffer word completion
            {name = "emoji", insert = true} -- emoji completion
        },
        completion = {
            keyword_length = 1,
            completeopt = "menu,noselect"
        },
        view = {
            entries = "custom"
        },
        formatting = {
            format = lspkind.cmp_format(
                {
                    mode = "symbol_text",
                    menu = {
                        nvim_lsp = "[LSP]",
                        -- ultisnips = "[US]",
                        nvim_lua = "[Lua]",
                        path = "[Path]",
                        buffer = "[Buffer]",
                        emoji = "[Emoji]"
                    }
                }
            )
        }
    }
)

--  see https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
vim.cmd [[
  highlight! link CmpItemMenu Comment
  " gray
  highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
  " blue
  highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
  highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
  " light blue
  highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
  " pink
  highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
  highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
  " front
  highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
]]

-- LSP autocomplete
-- vim.opt.completeopt = {"menu", "menuone", "noselect"} -- setting vim values

-- Setup nvim-cmp.
-- local cmp = require "cmp"

-- cmp.setup(
--     {
--         snippet = {
--             expand = function(args)
--                 require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
--             end
--         },
--         mapping = {
--             ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
--             ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
--             ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
--             ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
--             ["<C-e>"] = cmp.mapping(
--                 {
--                     i = cmp.mapping.abort(),
--                     c = cmp.mapping.close()
--                 }
--             ),
--             ["<Tab>"] = cmp.mapping(
--                 function(fallback)
--                     if cmp.visible() then
--                         cmp.select_next_item()
--                     else
--                         fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
--                     end
--                 end,
--                 {"i", "s"}
--             ),
--             ["<S-Tab>"] = cmp.mapping(
--                 function()
--                     if cmp.visible() then
--                         cmp.select_prev_item()
--                     end
--                 end,
--                 {"i", "s"}
--             ),
--             ["<CR>"] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--         },
--         sources = cmp.config.sources(
--             {
--                 {name = "nvim_lsp"},
--                 {name = "luasnip"} -- For luasnip users.
--             },
--             {
--                 {name = "buffer"}
--             }
--         )
--     }
-- )
