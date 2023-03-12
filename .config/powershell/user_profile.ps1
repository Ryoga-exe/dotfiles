# Encoding
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding
$env:LESSCHARSET = "utf-8"

# Completion
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# Terminal Icons
Import-Module -Name Terminal-Icons

# Starship
$env:STARSHIP_CONFIG = "$HOME\.config\starship.toml"
Invoke-Expression (&starship init powershell)

# Neovim
$env:XDG_CONFIG_HOME = "~/.config"

# winget
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
        [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
        $Local:word = $wordToComplete.Replace('"', '""')
        $Local:ast = $commandAst.ToString().Replace('"', '""')
        winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

# scoop
Import-Module "$($(Get-Item $(Get-Command scoop.ps1).Path).Directory.Parent.FullName)\modules\scoop-completion"

# Git
$env:GIT_SSH = "C:\Windows\System32\OpenSSH\ssh.exe"

# Alias
Set-Alias vim nvim
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\user\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\user\bin\less.exe'

# Utilities
function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
