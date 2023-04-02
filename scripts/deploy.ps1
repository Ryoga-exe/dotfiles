function New-SymbolicLink {
    param (
        [string]$from,
        [string]$to
    )
    New-Item -ItemType SymbolicLink -Path $to -Value $from -Force | Out-Null
    Write-Host "Created Symbolic Link: " -NoNewline
    Write-Host $from.Replace($HOME, '~') " -> " $to.Replace($HOME, '~') -ForegroundColor Cyan
}

function New-DirectoryIfNotExist {
    param (
        [string]$target
    )
    if (!(Test-Path -Path $target)) {
        New-Item -ItemType "directory" -Path $target | Out-Null
        Write-Host "Created Directory: " -NoNewline
        Write-Host $target.Replace($HOME, '~') -ForegroundColor Cyan
    }
}

if ($PSVersionTable.PSVersion.Major -gt 4) {
    if (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {

        $currentPath = (Get-Location).Path

        if ($currentPath -eq (Convert-Path $PSScriptRoot\..)) {

            Write-Host "Create Symbolic Links" -ForegroundColor Yellow
            
            # profile.ps1 -> $PROFILE
            New-DirectoryIfNotExist -target (Join-Path $HOME Documents\PowerShell)
            New-SymbolicLink -from (Get-Item .\profile.ps1).FullName -to (Join-Path $HOME Document\PowerShell\Microsoft.PowerShell_profile.ps1)
            
            # .config -> $HOME\.config
            $itemList = Get-ChildItem .\.config -Recurse
            foreach ($item in $itemList) {
                $target = (Join-Path $HOME ($item.FullName).Substring($currentPath.Length))
                if ($item.PSIsContainer) {
                    New-DirectoryIfNotExist -target $target
                }
                else {
                    New-SymbolicLink -from $item.FullName -to $target
                }
            }

            # AppData -> $HOME\AppData
            $itemList = Get-ChildItem .\AppData -Recurse
            foreach ($item in $itemList) {
                $target = (Join-Path $HOME ($item.FullName).Substring($currentPath.Length))
                if ($item.PSIsContainer) {
                    New-DirectoryIfNotExist -target $target
                }
                else {
                    New-SymbolicLink -from $item.FullName -to $target
                }
            }
        }
        else {
            Write-Warning "This script must be run from root directory on Git repository."
        }
    }
    else {
        Write-Warning "This script requires administrator privileges."
    }
}
else {
    Write-Warning "PowerShell version does not meet the requirements."
}
