local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local highlight_dimmed = {
    "RainbowRedDimmed",
    "RainbowYellowDimmed",
    "RainbowBlueDimmed",
    "RainbowOrangeDimmed",
    "RainbowGreenDimmed",
    "RainbowVioletDimmed",
    "RainbowCyanDimmed",
}

local hooks = require("ibl.hooks")
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })

    -- divided by 4
    vim.api.nvim_set_hl(0, "RainbowRedDimmed", { fg = "#381b1d" })
    vim.api.nvim_set_hl(0, "RainbowYellowDimmed", { fg = "#39301e" })
    vim.api.nvim_set_hl(0, "RainbowBlueDimmed", { fg = "#182b3b" })
    vim.api.nvim_set_hl(0, "RainbowOrangeDimmed", { fg = "#342619" })
    vim.api.nvim_set_hl(0, "RainbowGreenDimmed", { fg = "#26301e" })
    vim.api.nvim_set_hl(0, "RainbowVioletDimmed", { fg = "#311e37" })
    vim.api.nvim_set_hl(0, "RainbowCyanDimmed", { fg = "#152d30" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup {
    scope = {
        enabled = false;
        highlight = highlight;
        show_start = false;
        show_end = false;
    };
    indent = { highlight = highlight_dimmed }
}

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
