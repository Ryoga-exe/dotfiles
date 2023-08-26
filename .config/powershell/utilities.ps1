# Utilities
function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function cdgitroot {
    Set-Location $(git rev-parse --show-toplevel)
}

function open ($path) {
    if ([string]::IsNullOrEmpty($path)) {
        Invoke-Expression "explorer ."
    }
    elseif ((Test-Path -Path $path) -and ((Get-Item $path).PSIsContainer)) {
        Invoke-Expression "explorer $path"
    }
    else {
        Write-Error -Message "Error: $path does not exist or is not a directory." -Category InvalidArgument
    }
}

function take ($path) {
    if ([string]::IsNullOrEmpty($path)) {
        Write-Error -Message "Error: missing path." -Category InvalidArgument
    }
    else {
        New-Item -Path . -Nam $path -ItemType "directory"
        Set-Location -Path $path
    }
}
