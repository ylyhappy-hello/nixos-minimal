local status_ok, dashboard = pcall(require, "dashboard-nvim")
if not status_ok then
	return
end

dashboard.setup({
  theme = 'hyper',
  disable_move = true,
  shortcut_type = 'letter',
  change_to_vcs_root = true,
  config = {},    --  config used for theme
  hide = {
    statusline = false,    -- hide statusline default is true
    tabline    = false,    -- hide the tabline
    winbar     = false,    -- hide winbar
  }, preview = { },
})
