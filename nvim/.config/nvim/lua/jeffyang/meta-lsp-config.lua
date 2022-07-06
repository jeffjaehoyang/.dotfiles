require("meta.lsp")
local servers = {
    "rusty@meta",
    "pyls@meta",
    "pyre@meta",
    "thriftlsp@meta",
    "cppls@meta",
    "eslint@meta",
    "prettier@meta"
}
local lsp_config = require("lspconfig")
local lsp_settings = require("jeffyang.lsp-config")

for _, lsp in ipairs(servers) do
    lsp_config[lsp].setup(lsp_settings.config())
end

lsp_config["flow"].setup(
    lsp_settings.config(
        {
            cmd = {"flow", "lsp"}
        }
    )
)

lsp_config["hhvm"].setup(lsp_settings.config())
