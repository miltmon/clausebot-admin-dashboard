# Deploy-ToVercel.ps1
# Deploy ClauseBot Admin Dashboard to Vercel
# Requires: vercel CLI installed and logged in

$ErrorActionPreference = "Stop"

Write-Host "[*] Deploying to Vercel" -ForegroundColor Cyan
Write-Host "======================" -ForegroundColor Cyan
Write-Host ""

# Check login
Write-Host "[*] Checking Vercel login status..." -ForegroundColor Yellow
try {
    $whoami = vercel whoami 2>&1
    Write-Host "[OK] Logged in as: $whoami" -ForegroundColor Green
} catch {
    Write-Host "[!] Not logged in. Running vercel login..." -ForegroundColor Red
    vercel login
}

Write-Host ""
Write-Host "[*] Starting production deployment..." -ForegroundColor Cyan
Write-Host ""

# Deploy to production
try {
    vercel --prod --yes
    Write-Host ""
    Write-Host "[SUCCESS] Deployment complete!" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Deployment failed: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Troubleshooting tips:" -ForegroundColor Yellow
    Write-Host "  1. Check build logs above for errors"
    Write-Host "  2. Verify all environment variables are set: vercel env ls"
    Write-Host "  3. Try deploying manually: vercel --prod"
    Write-Host "  4. Check Vercel dashboard for more details"
    exit 1
}

Write-Host ""
Write-Host "[*] Deployment Info:" -ForegroundColor Cyan
Write-Host "-------------------"

# Get deployment URL
try {
    $deployments = gh api repos/miltmon/clausebot-admin-dashboard/deployments | ConvertFrom-Json
    if ($deployments.Count -gt 0) {
        $url = $deployments[0].payload.web_url
        if ($url) {
            Write-Host "URL: $url" -ForegroundColor Green
            Write-Host ""
            Write-Host "[*] Testing health endpoint..." -ForegroundColor Cyan
            try {
                $health = Invoke-RestMethod -Uri "$url/api/health"
                Write-Host "[OK] Health check passed!" -ForegroundColor Green
                $health | ConvertTo-Json -Depth 5
            } catch {
                Write-Host "[!] Health endpoint not responding yet (may take a minute)" -ForegroundColor Yellow
            }
        }
    }
} catch {
    Write-Host "[!] Could not fetch deployment URL automatically" -ForegroundColor Yellow
    Write-Host "Check Vercel dashboard: https://vercel.com/miltmonllc/clausebot-admin-dashboard"
}

Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. Visit your deployment URL"
Write-Host "  2. Test the /api/health endpoint"
Write-Host "  3. Set up UptimeRobot monitoring"
Write-Host "  4. Run: .\Verify-AllSecrets.ps1"
