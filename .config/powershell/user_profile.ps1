# Encoding
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Env
. "$PSScriptRoot\env.ps1"

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar

# Completion
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -PredictionSource History
Import-Module posh-git

# History
Set-PSReadLineOption -HistoryNoDuplicates

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

# Alias
. "$PSScriptRoot\alias.ps1"

# Zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# Utilities
. "$PSScriptRoot\utilities.ps1"
