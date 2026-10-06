<#
.SYNOPSIS
    Automated script to sync portfolio changes with GitHub.
#>

param(
    [string]$Message = ""
)

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "        Shijin P S Portfolio - GitHub Auto-Sync" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan

Set-Location $PSScriptRoot

Write-Host "`n[1/3] Checking working directory changes..." -ForegroundColor Yellow
git status --short

if ([string]::IsNullOrWhiteSpace($Message)) {
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    $inputMsg = Read-Host "Enter commit message (Press Enter for default: 'Update portfolio - $timestamp')"
    if ([string]::IsNullOrWhiteSpace($inputMsg)) {
        $Message = "Update portfolio - $timestamp"
    } else {
        $Message = $inputMsg
    }
}

Write-Host "`n[2/3] Staging and committing changes..." -ForegroundColor Yellow
git add -A

# Check if there is anything to commit
$gitStatus = git status --porcelain
if ($gitStatus) {
    git commit -m "$Message"
} else {
    Write-Host "No new changes to commit. Proceeding to push..." -ForegroundColor Gray
}

Write-Host "`n[3/3] Pushing to GitHub (origin/main)..." -ForegroundColor Yellow
git push origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n========================================================" -ForegroundColor Green
    Write-Host " SUCCESS: Portfolio successfully updated on GitHub! " -ForegroundColor Green
    Write-Host "========================================================" -ForegroundColor Green
} else {
    Write-Host "`n========================================================" -ForegroundColor Red
    Write-Host " NOTICE: Push encountered an issue." -ForegroundColor Red
    Write-Host " If not logged in yet, sign in to your GitHub account." -ForegroundColor Red
    Write-Host "========================================================" -ForegroundColor Red
}
