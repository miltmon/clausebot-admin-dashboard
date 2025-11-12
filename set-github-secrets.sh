#!/bin/bash
# set-github-secrets.sh
# Interactive GitHub secrets provisioning for clausebot-admin-dashboard
# Run this locally - it will prompt for each secret value securely

set -e

REPO="miltmon/clausebot-admin-dashboard"

echo "🔐 GitHub Secrets Provisioning for $REPO"
echo "=========================================="
echo ""
echo "⚠️  SECURITY NOTICE:"
echo "    - This script will prompt for secret values"
echo "    - Values are sent directly to GitHub encrypted"
echo "    - Nothing is stored locally or logged"
echo ""
echo "Press Enter to continue..."
read

# Core secrets (prompts for input)
echo "📝 Setting WIX_MCP_KEY..."
gh secret set WIX_MCP_KEY --repo $REPO

echo "📝 Setting AIRTABLE_TOKEN..."
gh secret set AIRTABLE_TOKEN --repo $REPO

echo "📝 Setting SLACK_WEBHOOK_URL..."
gh secret set SLACK_WEBHOOK_URL --repo $REPO

# Public values (can be set directly)
echo "📝 Setting NEXT_PUBLIC_STRIPE_CHECKOUT_URL..."
gh secret set NEXT_PUBLIC_STRIPE_CHECKOUT_URL --body "https://buy.stripe.com/YOUR_CHECKOUT_URL" --repo $REPO

echo "📝 Setting NEXT_PUBLIC_GA_ID..."
gh secret set NEXT_PUBLIC_GA_ID --repo $REPO

echo "📝 Setting NEXT_PUBLIC_API_URL..."
gh secret set NEXT_PUBLIC_API_URL --body "https://api.miltmonndt.com" --repo $REPO

echo "📝 Setting NEXT_PUBLIC_VERSION..."
gh secret set NEXT_PUBLIC_VERSION --body "v10" --repo $REPO

# Optional: Vercel automation tokens
echo ""
echo "🤔 Do you want to set Vercel automation tokens? (y/n)"
read -r response
if [[ "$response" =~ ^[Yy]$ ]]; then
  echo "📝 Setting VERCEL_TOKEN..."
  gh secret set VERCEL_TOKEN --repo $REPO
  
  echo "📝 Setting VERCEL_PROJECT_ID..."
  gh secret set VERCEL_PROJECT_ID --body "prj_wxNX4Xf1kLSmeKJTTK7bhcPAJ6rL" --repo $REPO
fi

# Optional: Render automation tokens
echo ""
echo "🤔 Do you want to set Render automation tokens? (y/n)"
read -r response
if [[ "$response" =~ ^[Yy]$ ]]; then
  echo "📝 Setting RENDER_API_TOKEN..."
  gh secret set RENDER_API_TOKEN --repo $REPO
  
  echo "📝 Setting RENDER_SERVICE_ID..."
  gh secret set RENDER_SERVICE_ID --repo $REPO
fi

echo ""
echo "✅ GitHub secrets provisioning complete!"
echo ""
echo "📊 Verify with: gh secret list --repo $REPO"

