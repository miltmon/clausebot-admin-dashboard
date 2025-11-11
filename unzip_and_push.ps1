param(
  [string]$ZipPath = "C:\Users\miltm\Downloads\clausebot-admin-dashboard-complete.zip",
  [string]$TargetDir = "C:\Users\miltm\Workspace\clausebot-admin-dashboard",
  [string]$RemoteRepo = "git@github.com:miltmon/clausebot-admin-dashboard.git"
)

Write-Host "Starting unzip_and_push..." -ForegroundColor Cyan

# 1. extract
if (Test-Path $TargetDir) {
  Write-Host "Cleaning existing target dir: $TargetDir" -ForegroundColor Yellow
  Remove-Item -Recurse -Force $TargetDir -ErrorAction SilentlyContinue
}
Expand-Archive -Path $ZipPath -DestinationPath $TargetDir -Force
Write-Host "Extracted ZIP to $TargetDir" -ForegroundColor Green

# 2. git init / push
Push-Location $TargetDir
if (!(Test-Path ".git")) {
  git init
  git remote add origin $RemoteRepo
  Write-Host "Initialized git and added remote $RemoteRepo" -ForegroundColor Green
} else {
  Write-Host "Repo already has .git — will commit to existing repo" -ForegroundColor Yellow
}

git add -A
git commit -m "chore(import): clausebot admin dashboard v10 - zip import" -q
git branch -M main
Write-Host "Pushing to origin main (force)..." -ForegroundColor Yellow
git push -u origin main --force

Pop-Location
Write-Host "Done. Repo pushed to $RemoteRepo" -ForegroundColor Cyan

