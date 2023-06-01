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
