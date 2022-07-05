local meta = require("meta")
local null_ls = require("null-ls")

local sources = {
    meta.null_ls.diagnostics.arclint,
    -- meta.null_ls.formatting.arclint,
}

null_ls.setup({
    sources = sources,
})
