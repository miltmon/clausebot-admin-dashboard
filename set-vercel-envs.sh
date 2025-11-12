#!/bin/bash
# set-vercel-envs.sh
# Set Vercel environment variables via CLI (interactive)
# Requires: vercel CLI installed and logged in

set -e

echo "🚀 Vercel Environment Variables Setup"
echo "======================================"
echo ""
echo "⚠️  SECURITY NOTICE:"
echo "    - This script uses Vercel CLI prompts"
echo "    - You will be asked to paste values interactively"
echo "    - Values are encrypted in Vercel"
echo ""
echo "Press Enter to continue..."
read

# Login check
echo "🔑 Checking Vercel login status..."
if ! vercel whoami &>/dev/null; then
  echo "❌ Not logged in to Vercel. Running 'vercel login'..."
  vercel login
fi

echo "✅ Logged in to Vercel"
echo ""

# Public environment variables
echo "📝 Setting NEXT_PUBLIC_GA_ID (production)..."
vercel env add NEXT_PUBLIC_GA_ID production

echo "📝 Setting NEXT_PUBLIC_STRIPE_CHECKOUT_URL (production)..."
vercel env add NEXT_PUBLIC_STRIPE_CHECKOUT_URL production

echo "📝 Setting NEXT_PUBLIC_API_URL (production)..."
vercel env add NEXT_PUBLIC_API_URL production

echo "📝 Setting NEXT_PUBLIC_VERSION (production)..."
vercel env add NEXT_PUBLIC_VERSION production

# Secrets (encrypted)
echo ""
echo "🔐 Setting encrypted secrets..."

echo "📝 Setting WIX_MCP_KEY (production, encrypted)..."
vercel env add WIX_MCP_KEY production

echo "📝 Setting AIRTABLE_TOKEN (production, encrypted)..."
vercel env add AIRTABLE_TOKEN production

echo "📝 Setting SLACK_WEBHOOK_URL (production, encrypted)..."
vercel env add SLACK_WEBHOOK_URL production

echo ""
echo "✅ Vercel environment variables set!"
echo ""
echo "📊 Verify with: vercel env ls"
echo ""
echo "🔄 Redeploy to apply: vercel --prod"

