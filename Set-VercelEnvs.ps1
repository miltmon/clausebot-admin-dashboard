# Set-VercelEnvs.ps1
# Set Vercel environment variables via CLI (interactive)
# Requires: vercel CLI installed and logged in

$ErrorActionPreference = "Stop"

Write-Host "[*] Vercel Environment Variables Setup" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "SECURITY NOTICE:" -ForegroundColor Yellow
Write-Host "    - This script uses Vercel CLI prompts"
Write-Host "    - You will be asked to paste values interactively"
Write-Host "    - Values are encrypted in Vercel"
Write-Host ""
Write-Host "Press Enter to continue..."
$null = Read-Host

# Login check
Write-Host "[*] Checking Vercel login status..." -ForegroundColor Yellow
try {
    vercel whoami | Out-Null
    Write-Host "[OK] Logged in to Vercel" -ForegroundColor Green
} catch {
    Write-Host "[!] Not logged in to Vercel. Running vercel login..." -ForegroundColor Red
    vercel login
}

Write-Host ""

# Public environment variables
Write-Host "[+] Setting NEXT_PUBLIC_GA_ID (production)..." -ForegroundColor Green
vercel env add NEXT_PUBLIC_GA_ID production

Write-Host "[+] Setting NEXT_PUBLIC_STRIPE_CHECKOUT_URL (production)..." -ForegroundColor Green
vercel env add NEXT_PUBLIC_STRIPE_CHECKOUT_URL production

Write-Host "[+] Setting NEXT_PUBLIC_API_URL (production)..." -ForegroundColor Green
vercel env add NEXT_PUBLIC_API_URL production

Write-Host "[+] Setting NEXT_PUBLIC_VERSION (production)..." -ForegroundColor Green
vercel env add NEXT_PUBLIC_VERSION production

# Secrets (encrypted)
Write-Host ""
Write-Host "[*] Setting encrypted secrets..." -ForegroundColor Cyan

Write-Host "[+] Setting WIX_MCP_KEY (production, encrypted)..." -ForegroundColor Green
vercel env add WIX_MCP_KEY production

Write-Host "[+] Setting AIRTABLE_TOKEN (production, encrypted)..." -ForegroundColor Green
vercel env add AIRTABLE_TOKEN production

Write-Host "[+] Setting SLACK_WEBHOOK_URL (production, encrypted)..." -ForegroundColor Green
vercel env add SLACK_WEBHOOK_URL production

Write-Host ""
Write-Host "[SUCCESS] Vercel environment variables set!" -ForegroundColor Green
Write-Host ""
Write-Host "Verify with: vercel env ls" -ForegroundColor Cyan
Write-Host ""
Write-Host "Redeploy to apply: vercel --prod" -ForegroundColor Cyan
