local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

--------------------------------------------
-- General settings 
--------------------------------------------
config.default_prog = { 'powershell.exe', '-NoLogo'}
config.color_scheme = 'Catppuccin Mocha'
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
disable_bell = true
--------------------------------------------

--------------------------------------------
-- Fonts 
--------------------------------------------
-- config.font = wezterm.font 'Hack Nerd Font'
config.font_size = 11.0
--------------------------------------------

--------------------------------------------
-- key maps
--------------------------------------------
config.leader = { key = 'f', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
    {
        key = 's',
        mods = 'ALT',
        action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'v',
        mods = 'ALT',
        action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'n',
        mods = 'LEADER',
        action = act.ActivateTabRelative(1)
    },
    {
        key = 'p',
        mods = 'LEADER',
        action = act.ActivateTabRelative(-1)
    },
    {
        key = 'l',
        mods = 'LEADER',
        action = act.ActivatePaneDirection 'Right',
    },
    {
        key = 'h',
        mods = 'LEADER',
        action = act.ActivatePaneDirection 'Left',
    },
    {
        key = 'k',
        mods = 'LEADER',
        action = act.ActivatePaneDirection 'Up',
    },
    {
        key = 'j',
        mods = 'LEADER',
        action = act.ActivatePaneDirection 'Down',
    },
    {
        key = 'h',
        mods = 'CTRL|ALT',
        action = act.AdjustPaneSize { 'Left', 5 },
    },
    {
        key = 'j',
        mods = 'CTRL|ALT',
        action = act.AdjustPaneSize { 'Down', 5 },
    },
    {
        key = 'k',
        mods = 'CTRL|ALT',
        action = act.AdjustPaneSize { 'Up', 5 }
    },
    {
        key = 'l',
        mods = 'CTRL|ALT',
        action = act.AdjustPaneSize { 'Right', 5 },
    },
    {
        key = 'n',
        mods = 'ALT',
        action = act.SpawnTab 'CurrentPaneDomain',
    },
    {
        key = 'w',
        mods = 'ALT',
        action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    {
        key = 't',
        mods = 'ALT',
        action = act.SpawnTab 'CurrentPaneDomain',
    }
}
--------------------------------------------
-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_id(tab_info)
    local id = tab_info.tab_index
    -- if the tab title is explicitly set, take that
    return id
end

wezterm.on(
    'format-tab-title',
    function(tab)
        local title = tab_id(tab)
        if tab.is_active then
            return {
                { Text = ' -' .. title .. '- ' },
            }
        end
        return '  ' .. title .. '  '
    end
)

return config
