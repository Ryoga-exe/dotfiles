if ($PSVersionTable.PSVersion.Major -gt 4) {
    if (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        
    }
    else {
        Write-Warning "This script requires administrator privileges."
    }
}
else {
    Write-Warning "PowerShell version does not meet the requirements."
}

