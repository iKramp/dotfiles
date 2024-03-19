local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.toggle_file, { desc = 'harpoon add file' })
--vim.keymap.set("n", "<leader>r", mark.remove_file, { desc = 'harpoon remove file' })
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, {desc = 'toggle harpoon' })
