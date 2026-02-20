return {
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                contrast = "soft", -- soft, medium, hard
                transparent_mode = false,
            })
            vim.cmd.colorscheme("gruvbox")
        end,
    },
}
