function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function cdgitroot {
    Set-Location $(git rev-parse --show-toplevel)
}
