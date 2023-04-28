# Encoding
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding
$env:LESSCHARSET = "utf-8"

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar

# Completion
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -PredictionSource History

# History
Set-PSReadLineOption -HistoryNoDuplicates

# Terminal Icons
Import-Module -Name Terminal-Icons -ErrorAction SilentlyContinue
if (!$?) {
    Write-Warning 'Terminal-Icons is not installed, try "Install-Module -Name Terminal-Icons -Repository PSGallery"'
}

# Fzf
Import-Module -Name PSFzf -ErrorAction SilentlyContinue
if ($?) {
    Enable-PsFzfAliases
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
}
else {
    Write-Warning 'PSFzf is not installed, try "scoop install fzf; Install-Module -Name PSFzf -Scope CurrentUser"'
}

# fnm
fnm env --use-on-cd | Out-String | Invoke-Expression

# Starship
$env:STARSHIP_CONFIG = "$env:XDG_CONFIG_HOME\starship.toml"
Invoke-Expression (&starship init powershell) -ErrorAction SilentlyContinue
if (!$?) {
    Write-Warning 'Starship is not installed, try "winget install -e --id Starship.Starship"'
}
# Enable-TransientPrompt

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
if (Test-Path -Path "$($(Get-Item $(Get-Command scoop.ps1).Path).Directory.Parent.FullName)\modules\scoop-completion") {
    Import-Module "$($(Get-Item $(Get-Command scoop.ps1).Path).Directory.Parent.FullName)\modules\scoop-completion"
}

# Git
$env:GIT_SSH = "C:\Windows\System32\OpenSSH\ssh.exe"

# Alias
Set-Alias vim nvim
Set-Alias grep findstr
Set-Alias ll Get-ChildItem
Set-Alias tig 'C:\Program Files\Git\user\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\user\bin\less.exe'
Set-Alias cd. cdgitroot

# ZLocation
Import-Module -Name ZLocation -ErrorAction SilentlyContinue
if (!$?) {
    Write-Warning 'ZLocation is not installed, try "Install-Module -Name ZLocation -Repository PSGallery -Scope CurrentUser"'
}

# Utilities
function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function cdgitroot {
    Set-Location $(git rev-parse --show-toplevel)
}
