# Verify-AllSecrets.ps1
# Verification script - outputs ONLY non-sensitive data
# Safe to paste outputs into chat for verification

$ErrorActionPreference = "Continue"

$REPO = "miltmon/clausebot-admin-dashboard"
$PROJECT_ID = "prj_wxNX4Xf1kLSmeKJTTK7bhcPAJ6rL"
$SERVICE_ID = "srv-d44q383ipnbc73apcb00"

Write-Host "[*] Verification Report - ClauseBot Admin Dashboard" -ForegroundColor Cyan
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Date: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Write-Host ""

# 1. GitHub Secrets
Write-Host "1. GitHub Secrets (names only, no values)" -ForegroundColor Yellow
Write-Host "-------------------------------------------"
gh secret list --repo $REPO
Write-Host ""

# 2. Git commit info
Write-Host "2. Latest Git Commit" -ForegroundColor Yellow
Write-Host "---------------------"
git log -1 --oneline
Write-Host ""

# 3. Files in repo
Write-Host "3. Key Files in Repository" -ForegroundColor Yellow
Write-Host "----------------------------"
git ls-files | Select-String -Pattern "(health|_document|LaunchMetrics|prevent-print|vercel.json)"
Write-Host ""

# 4. Vercel environment variables (if VERCEL_TOKEN is set)
Write-Host "4. Vercel Environment Variables" -ForegroundColor Yellow
Write-Host "--------------------------------"
try {
    vercel whoami | Out-Null
    Write-Host "Vercel CLI authenticated:"
    vercel env ls 2>$null
} catch {
    Write-Host "[!] Not logged in to Vercel CLI" -ForegroundColor Yellow
    Write-Host "Run: vercel login"
}
Write-Host ""

# 5. GitHub Actions workflows
Write-Host "5. GitHub Actions Status" -ForegroundColor Yellow
Write-Host "-------------------------"
try {
    $runs = gh run list --repo $REPO --limit 5 --json workflowName,status,conclusion,createdAt,htmlUrl | ConvertFrom-Json
    foreach ($run in $runs) {
        $conclusion = if ($run.conclusion) { $run.conclusion } else { "N/A" }
        Write-Host "$($run.workflowName): $($run.status) ($conclusion) - $($run.htmlUrl)"
    }
} catch {
    Write-Host "No recent workflow runs or error fetching" -ForegroundColor Yellow
}
Write-Host ""

# 6. Health endpoint check (if deployed)
Write-Host "6. Health Endpoint Check" -ForegroundColor Yellow
Write-Host "-------------------------"
Write-Host "Attempting to reach deployed health endpoint..."
try {
    $deployments = gh api repos/$REPO/deployments | ConvertFrom-Json
    if ($deployments.Count -gt 0) {
        $VERCEL_URL = $deployments[0].payload.web_url
        if ($VERCEL_URL) {
            Write-Host "Testing: $VERCEL_URL/api/health"
            $health = Invoke-RestMethod -Uri "$VERCEL_URL/api/health" -ErrorAction Stop
            $health | ConvertTo-Json -Depth 5
        } else {
            Write-Host "[!] No deployment URL found in payload" -ForegroundColor Yellow
        }
    } else {
        Write-Host "[!] No deployments found yet" -ForegroundColor Yellow
    }
} catch {
    Write-Host "[!] No deployment URL found yet or health endpoint not reachable" -ForegroundColor Yellow
    Write-Host "After Vercel deployment, manually test:"
    Write-Host "  Invoke-RestMethod https://your-vercel-url.vercel.app/api/health | ConvertTo-Json"
}
Write-Host ""

# 7. Repository status
Write-Host "7. Repository Status" -ForegroundColor Yellow
Write-Host "---------------------"
Write-Host "Remote URL: $(git remote get-url origin)"
Write-Host "Current branch: $(git branch --show-current)"
try {
    Write-Host "Tracking: $(git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>$null)"
} catch {
    Write-Host "Tracking: Not tracking remote"
}
Write-Host ""

Write-Host "[SUCCESS] Verification complete!" -ForegroundColor Green
Write-Host ""
Write-Host "SAFE TO PASTE ALL OUTPUT ABOVE INTO CHAT" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Review output above for any missing secrets"
Write-Host "  2. Deploy to Vercel: vercel --prod"
Write-Host "  3. Test health endpoint after deployment"
Write-Host "  4. Set up UptimeRobot monitoring"
