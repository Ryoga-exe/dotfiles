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

# eza
function ezals ($path) {
    eza --icons $path
}
function ezall ($path) {
    eza -aahl --icons --group-directories-first $path
}
function ezalt ($path) {
    eza -T -L 3 -a -I "node_modules|.git|.cache" --icons --group-directories-first $path
}
function ezaltl ($path) {
    eza -T -L 3 -a -I "node_modules|.git|.cache" -l --icons --group-directories-first $path
}
