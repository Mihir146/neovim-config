vim.keymap.set({'n', 'x'}, 'gy', '"+y')--copy to clip using gy 
vim.keymap.set({'n', 'x'}, 'gp', '"+p')--paste from clip using gp
--delete text w/o changing the registers
vim.keymap.set({'n', 'x'}, 'x', '"_x')
vim.keymap.set({'n', 'x'}, 'X', '"_d')

--some useful keymaps

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set({"n", "x"}, "1", "$", { desc = "Go to end of line" })

--for opening split terminal
vim.keymap.set("n", "<leader>t", ":sp | terminal<CR>" ,{ desc = "Toggle horizontal terminal" })
