function New-SymbolicLink {
    param (
        [string]$from,
        [string]$to
    )
    if (Test-Path -Path $to) {
        # Remove-Item $to
    }
    Write-Host "Create Symbolic Link: " -NoNewline
    Write-Host "$from -> $to" -ForegroundColor Cyan
}

if ($PSVersionTable.PSVersion.Major -gt 4) {
    if (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        
        Write-Host "Create Symbolic Links" -ForegroundColor Yellow
        
        $currentPath = (Get-Location).Path
        
        # .config -> $HOME\.config
        $itemList = Get-ChildItem .\.config -Recurse
        foreach ($item in $itemList) {
            $target = (Join-Path $HOME ($item.FullName).Substring($currentPath.Length))
            if ($item.PSIsContainer) {
                if (!(Test-Path -Path $target)) {
                    [void](New-Item -ItemType "directory" -Path $target)
                    Write-Host "Created Directory: " -NoNewline
                    Write-Host "$target" -ForegroundColor Cyan
                }
            }
            else {
                New-SymbolicLink -from $item.FullName -to $target
            }
        }
    }
    else {
        Write-Warning "This script requires administrator privileges."
    }
}
else {
    Write-Warning "PowerShell version does not meet the requirements."
}
