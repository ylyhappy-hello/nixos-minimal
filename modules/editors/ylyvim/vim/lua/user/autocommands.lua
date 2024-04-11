local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    print("nvim-tree not work")
    return
end
-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end
-- some useful autocmd

-- while leave insert mode change input method to en
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    pattern = { "*" },
    callback = function()
        local input_status = tonumber(vim.fn.system({"fcitx5-remote"}))
        if input_status == 2 then
            vim.fn.system("fcitx5-remote -c")
        end
    end,
})
-- detect filetype use diff tab spaces
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "java", "xml" },
    callback = function()
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4
    end,
})


-- detect filetype use diff nvim-tree width size
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "cpp" },
    callback = function()
--    vim.cmd("NvimTreeResize -30");
    end,
})
