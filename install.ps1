Write-Host "Install dotfiles..."

Write-Host "Set location to ~\"
Set-Location $env:USERPROFILE

Write-Host "Create workspace directories..."
New-Item -ItemType "directory" -Path "$env:USERPROFILE\workspace" -Force | Out-Null
New-Item -ItemType "directory" -Path "$env:USERPROFILE\workspace\repos" -Force | Out-Null
New-Item -ItemType "directory" -Path "$env:USERPROFILE\workspace\research" -Force | Out-Null
New-Item -ItemType "directory" -Path "$env:USERPROFILE\workspace\sandbox" -Force | Out-Null
New-Item -ItemType "directory" -Path "$env:USERPROFILE\workspace\cp" -Force | Out-Null


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

$dotfilesDirectory = "$env:USERPROFILE\workspace\repos\dotfiles"

Write-Host "Clone dotfiles repository..."
git clone "https://github.com/Ryoga-exe/dotfiles.git" "$dotfilesDirectory"

Write-Host "Set Location to ~\workspace\repos\dotfiles"
Set-Location "$dotfilesDirectory"
