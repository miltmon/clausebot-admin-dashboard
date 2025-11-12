# Use Vercel API to set environment variables directly
$headers = @{
    "Authorization" = "Bearer $env:VERCEL_TOKEN"
    "Content-Type" = "application/json"
}

$projectId = $env:VERCEL_PROJECT_ID
$teamId = $env:VERCEL_ORG_ID

Write-Host "`n[*] Setting Vercel Environment Variables via API" -ForegroundColor Cyan
Write-Host "Project: $projectId" -ForegroundColor Gray
Write-Host "Team: $teamId" -ForegroundColor Gray

# Function to add/update environment variable
function Set-VercelEnv {
    param($key, $value, $type = "encrypted")
    
    $body = @{
        key = $key
        value = $value
        target = @("production")
        type = $type
    } | ConvertTo-Json

    $url = "https://api.vercel.com/v10/projects/$projectId/env?teamId=$teamId"
    
    try {
        $response = Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $body
        Write-Host "  ✓ Set $key" -ForegroundColor Green
    } catch {
        if ($_.Exception.Response.StatusCode -eq 409) {
            Write-Host "  ⚠ $key already exists (skipping)" -ForegroundColor Yellow
        } else {
            Write-Host "  ✗ Failed to set $key : $($_.Exception.Message)" -ForegroundColor Red
        }
    }
}

# Set public environment variables with default values
Write-Host "`n[*] Setting public environment variables..." -ForegroundColor Cyan
Set-VercelEnv "NEXT_PUBLIC_GA_ID" "G-XXXXXXXXXX" "plain"
Set-VercelEnv "NEXT_PUBLIC_STRIPE_CHECKOUT_URL" "https://buy.stripe.com/8x28wPcu48CsekhbUC5sA00" "plain"
Set-VercelEnv "NEXT_PUBLIC_API_URL" "https://api.miltmonndt.com" "plain"
Set-VercelEnv "NEXT_PUBLIC_VERSION" "v10" "plain"

# Set encrypted secrets with prompts
Write-Host "`n[*] Setting encrypted secrets..." -ForegroundColor Cyan
Write-Host "Please enter the secret values when prompted (input will be hidden):" -ForegroundColor Yellow

$wixKey = Read-Host -Prompt "`nWIX_MCP_KEY" -AsSecureString
$wixKeyPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($wixKey))
Set-VercelEnv "WIX_MCP_KEY" $wixKeyPlain "encrypted"

$airtableToken = Read-Host -Prompt "AIRTABLE_TOKEN" -AsSecureString
$airtableTokenPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($airtableToken))
Set-VercelEnv "AIRTABLE_TOKEN" $airtableTokenPlain "encrypted"

$slackWebhook = Read-Host -Prompt "SLACK_WEBHOOK_URL" -AsSecureString
$slackWebhookPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($slackWebhook))
Set-VercelEnv "SLACK_WEBHOOK_URL" $slackWebhookPlain "encrypted"

Write-Host "`n[SUCCESS] All environment variables set via API!" -ForegroundColor Green
Write-Host "`nNext steps:" -ForegroundColor Cyan
Write-Host "  1. Verify: vercel env ls" -ForegroundColor Gray
Write-Host "  2. Deploy: vercel --prod" -ForegroundColor Gray
