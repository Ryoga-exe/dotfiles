# Encoding
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding
$env:LESSCHARSET = "utf-8"

# Prompt
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# Neovim
$env:XDG_CONFIG_HOME = "~/.config"

# Alias
Set-Alias -Name vim -Value nvim
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

