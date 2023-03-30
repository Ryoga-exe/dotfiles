param (
    [string]$dotfilesDir = "$env:USERPROFILE\workspace\repos\dotfiles",
    [string]$workspaceDir = "$env:USERPROFILE\workspace"
)

Write-Host "Install dotfiles..."

Write-Host "Set location to ~\"
Set-Location $env:USERPROFILE

Write-Host "Create workspace directories..."
New-Item -ItemType "directory" -Path "$workspaceDir" -Force | Out-Null
New-Item -ItemType "directory" -Path "$workspaceDir\repos" -Force | Out-Null
New-Item -ItemType "directory" -Path "$workspaceDir\research" -Force | Out-Null
New-Item -ItemType "directory" -Path "$workspaceDir\sandbox" -Force | Out-Null
New-Item -ItemType "directory" -Path "$workspaceDir\cp" -Force | Out-Null


if (!(Get-Command -Name winget -ErrorAction SilentlyContinue)) {
    Write-Warning "This script needs winget to install packages, please install winget."
    exit
}

if (!(Get-Command -Name git -ErrorAction SilentlyContinue)) {
    Write-Host "Install git..."
    winget install -e --id Git.Git -h --accept-package-agreements --accept-source-agreements
}

if (!(Get-Command -Name scoop -ErrorAction SilentlyContinue)) {
    Write-Host "Install scoop..."
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
}

Write-Host "Clone dotfiles repository..."
git clone "https://github.com/Ryoga-exe/dotfiles.git" "$dotfilesDir"

Write-Host "Set Location to ~\workspace\repos\dotfiles"
Set-Location "$dotfilesDir"
