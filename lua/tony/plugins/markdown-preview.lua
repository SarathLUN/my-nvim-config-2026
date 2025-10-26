return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    ft = { "markdown" },
    init = function()
        -- Theme options: "dark", "light", or "" (follows OS/system preferences)
        -- Set to dark by default to match Catppuccin Mocha
        vim.g.mkdp_theme = "dark"

        -- Browser auto-open settings
        vim.g.mkdp_auto_start = 0  -- Don't auto-start on markdown files
        vim.g.mkdp_auto_close = 1  -- Auto-close when leaving markdown buffer
        vim.g.mkdp_refresh_slow = 0  -- Fast refresh
        vim.g.mkdp_open_to_the_world = 0  -- Only accessible from localhost
        vim.g.mkdp_browser = ""  -- Use system default browser
    end,
    config = function()
        -- Create user commands to switch markdown preview theme
        vim.api.nvim_create_user_command("MarkdownPreviewDark", function()
            vim.g.mkdp_theme = "dark"
            print("Markdown preview theme set to dark (restart preview to apply)")
        end, { desc = "Set markdown preview to dark theme" })

        vim.api.nvim_create_user_command("MarkdownPreviewLight", function()
            vim.g.mkdp_theme = "light"
            print("Markdown preview theme set to light (restart preview to apply)")
        end, { desc = "Set markdown preview to light theme" })

        vim.api.nvim_create_user_command("MarkdownPreviewAuto", function()
            vim.g.mkdp_theme = ""
            print("Markdown preview theme set to auto (follows OS theme, restart preview to apply)")
        end, { desc = "Set markdown preview to auto-detect OS theme" })
    end,
}
