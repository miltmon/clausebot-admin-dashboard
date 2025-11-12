# Set-GitHubSecrets.ps1
# Interactive GitHub secrets provisioning for clausebot-admin-dashboard
# Run this locally - it will prompt for each secret value securely

$ErrorActionPreference = "Stop"

$REPO = "miltmon/clausebot-admin-dashboard"

Write-Host "[*] GitHub Secrets Provisioning for $REPO" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "SECURITY NOTICE:" -ForegroundColor Yellow
Write-Host "    - This script will prompt for secret values"
Write-Host "    - Values are sent directly to GitHub encrypted"
Write-Host "    - Nothing is stored locally or logged"
Write-Host ""
Write-Host "Press Enter to continue..."
$null = Read-Host

# Core secrets (prompts for input)
Write-Host "[+] Setting WIX_MCP_KEY..." -ForegroundColor Green
gh secret set WIX_MCP_KEY --repo $REPO

Write-Host "[+] Setting AIRTABLE_TOKEN..." -ForegroundColor Green
gh secret set AIRTABLE_TOKEN --repo $REPO

Write-Host "[+] Setting SLACK_WEBHOOK_URL..." -ForegroundColor Green
gh secret set SLACK_WEBHOOK_URL --repo $REPO

# Public values (can be set directly)
Write-Host "[+] Setting NEXT_PUBLIC_STRIPE_CHECKOUT_URL..." -ForegroundColor Green
$checkoutUrl = Read-Host "Enter Stripe Checkout URL"
gh secret set NEXT_PUBLIC_STRIPE_CHECKOUT_URL --body $checkoutUrl --repo $REPO

Write-Host "[+] Setting NEXT_PUBLIC_GA_ID..." -ForegroundColor Green
gh secret set NEXT_PUBLIC_GA_ID --repo $REPO

Write-Host "[+] Setting NEXT_PUBLIC_API_URL..." -ForegroundColor Green
$apiUrl = Read-Host "Enter API URL (default: https://api.miltmonndt.com)"
if ([string]::IsNullOrWhiteSpace($apiUrl)) {
    $apiUrl = "https://api.miltmonndt.com"
}
gh secret set NEXT_PUBLIC_API_URL --body $apiUrl --repo $REPO

Write-Host "[+] Setting NEXT_PUBLIC_VERSION..." -ForegroundColor Green
gh secret set NEXT_PUBLIC_VERSION --body "v10" --repo $REPO

# Optional: Vercel automation tokens
Write-Host ""
$response = Read-Host "Do you want to set Vercel automation tokens? (y/n)"
if ($response -eq 'y' -or $response -eq 'Y') {
    Write-Host "[+] Setting VERCEL_TOKEN..." -ForegroundColor Green
    gh secret set VERCEL_TOKEN --repo $REPO
    
    Write-Host "[+] Setting VERCEL_PROJECT_ID..." -ForegroundColor Green
    gh secret set VERCEL_PROJECT_ID --body "prj_wxNX4Xf1kLSmeKJTTK7bhcPAJ6rL" --repo $REPO
}

# Optional: Render automation tokens
Write-Host ""
$response = Read-Host "Do you want to set Render automation tokens? (y/n)"
if ($response -eq 'y' -or $response -eq 'Y') {
    Write-Host "[+] Setting RENDER_API_TOKEN..." -ForegroundColor Green
    gh secret set RENDER_API_TOKEN --repo $REPO
    
    Write-Host "[+] Setting RENDER_SERVICE_ID..." -ForegroundColor Green
    gh secret set RENDER_SERVICE_ID --body "srv-d44q383ipnbc73apcb00" --repo $REPO
}

Write-Host ""
Write-Host "[SUCCESS] GitHub secrets provisioning complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Verify with: gh secret list --repo $REPO" -ForegroundColor Cyan
