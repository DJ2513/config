local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")

vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        vim.keymap.set("n", "<leader>ee", function()
            -- Define the boilerplate lines
            local lines = {
                "if err != nil {",
                "\tpanic(err)",
                "}"
            }
            -- Get current cursor position
            local r, c = unpack(vim.api.nvim_win_get_cursor(0))
            -- Insert the lines into the buffer
            vim.api.nvim_buf_set_lines(0, r, r, false, lines)
        end, { buffer = true, desc = "Insert Go error panic" })
    end
})
