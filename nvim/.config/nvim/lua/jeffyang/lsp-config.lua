local Remap = require("jeffyang.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

local M = {}
local api = vim.api
local lsp = vim.lsp

-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

function M.show_line_diagnostics()
    local opts = {
        focusable = false,
        close_events = {"BufLeave", "CursorMoved", "InsertEnter", "FocusLost"},
        border = "rounded",
        source = "always", -- show source in diagnostic popup window
        prefix = " "
    }
    vim.diagnostic.open_float(nil, opts)
end

local capabilities = lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = capabilities

local function on_attach()
    nnoremap(
        "gd",
        function()
            vim.lsp.buf.definition()
        end
    )
    nnoremap(
        "K",
        function()
            vim.lsp.buf.hover()
        end
    )
    nnoremap(
        "<leader>q",
        function()
            vim.diagnostic.setqflist({open = true})
        end
    )
    nnoremap(
        "<leader>vd",
        function()
            vim.diagnostic.open_float()
        end
    )
    nnoremap(
        "[d",
        function()
            vim.diagnostic.goto_prev()
        end
    )
    nnoremap(
        "]d",
        function()
            vim.diagnostic.goto_next()
        end
    )
    nnoremap(
        "<leader>ca",
        function()
            vim.lsp.buf.code_action()
        end
    )
    nnoremap(
        "<leader>gr",
        function()
            vim.lsp.buf.references()
        end
    )
    nnoremap(
        "<leader>r",
        function()
            vim.lsp.buf.rename()
        end
    )
    inoremap(
        "<C-h>",
        function()
            vim.lsp.buf.signature_help()
        end
    )
end

local function config(_config)
    return vim.tbl_deep_extend(
        "force",
        {
            capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
            on_attach = on_attach
        },
        _config or {}
    )
end

M.on_attach = on_attach
M.config = config

local lsp_config = require("lspconfig")

if vim.g.is_mac then
    lsp_config.tsserver.setup(config())

    lsp_config.ccls.setup(config())

    lsp_config.jedi_language_server.setup(config())

    lsp_config.cssls.setup(config())

    lsp_config.gopls.setup(
        config(
            {
                cmd = {"gopls", "serve"},
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true
                        },
                        staticcheck = true
                    }
                }
            }
        )
    )

    lsp_config.rust_analyzer.setup(
        config(
            {
                cmd = {"rustup", "run", "nightly", "rust-analyzer"}
            }
        )
    )
end

local sumneko_root_path = os.getenv("HOME") .. "/.config/lua-language-server"
if vim.g.is_mac or vim.g.is_linux and sumneko_root_path ~= "" then
    local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    lsp_config.sumneko_lua.setup(
        {
            on_attach = on_attach,
            cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = "LuaJIT",
                        -- Setup your lua path
                        path = runtime_path
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = {"vim"}
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = api.nvim_get_runtime_file("", true)
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {enable = false}
                }
            },
            capabilities = capabilities
        }
    )
end

local signs = {
    {name = "DiagnosticSignError", text = "Ε"},
    {name = "DiagnosticSignWarn", text = "W"},
    {name = "DiagnosticSignHint", text = "H"},
    {name = "DiagnosticSignInfo", text = "I"}
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, {texthl = sign.name, text = sign.text, numhl = ""})
end

local diagnostics_config = {
    virtual_text = {spacing = 1, prefix = "⚈ "},
    -- show signs
    signs = {active = signs},
    update_in_insert = true,
    underline = false,
    severity_sort = true,
    float = {
        focus = false,
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = ""
    }
}

vim.diagnostic.config(diagnostics_config)

return M
