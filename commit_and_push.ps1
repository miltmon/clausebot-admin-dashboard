# commit_and_push.ps1
# Quick script to commit all Step A files and push to GitHub

Write-Host "🚀 STEP A: Committing all files..." -ForegroundColor Cyan

# Navigate to repo
Set-Location "C:\Users\miltm\MiltmonNDT_Workspace\clausebot-admin-dashboard"

# Stage all new files
Write-Host "📦 Staging files..." -ForegroundColor Yellow
git add pages/api/health.js
git add pages/_document.js
git add components/LaunchMetrics.jsx
git add .github/workflows/prevent-print-secrets.yml
git add unzip_and_push.ps1
git add vercel.json
git add README_DEPLOY.md
git add STEP_A_COMPLETE.md
git add commit_and_push.ps1

# Show status
Write-Host "`n📋 Files to be committed:" -ForegroundColor Yellow
git status --short

# Commit
Write-Host "`n💾 Creating commit..." -ForegroundColor Cyan
git commit -m "chore(launch): add health endpoint, GA4, launch metrics, and deployment config

- Add /api/health endpoint for uptime monitoring
- Add GA4 analytics integration in _document.js
- Add LaunchMetrics component for dashboard
- Add secret-prevention GitHub workflow
- Add vercel.json with security headers
- Add complete deployment guide (README_DEPLOY.md)
- Add unzip_and_push.ps1 for repo extraction

All files ready for production deployment. No secrets included."

# Push
Write-Host "`n🚢 Pushing to GitHub..." -ForegroundColor Cyan
git push origin main

Write-Host "`n✅ STEP A COMPLETE!" -ForegroundColor Green
Write-Host "Next: Run 'vercel --prod' to deploy" -ForegroundColor Yellow

