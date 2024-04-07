$env:XDG_CONFIG_HOME = "$HOME\.config"
$env:XDG_CACHE_HOME = "$HOME\.cache"
$env:XDG_DATA_HOME = "$HOME\.local\share"
$env:XDG_STATE_HOME = "$HOME\.local\state"

. $env:XDG_CONFIG_HOME\powershell\user_profile.ps1
