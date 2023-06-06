require('ryoga-exe.plugins.setup')
require('ryoga-exe.core.options')
require('ryoga-exe.core.keymaps')
require('ryoga-exe.core.colorscheme')

local has = vim.fn.has
local is_mac = has "macunix"
local is_win = has "win32"
local is_wsl = has "wsl"

if is_mac == 1 then
    require('ryoga-exe.platform.macos')
end
if is_win == 1 then
    require('ryoga-exe.platform.windows')
end
if is_wsl == 1 then
    require('ryoga-exe.platform.wsl')
end
