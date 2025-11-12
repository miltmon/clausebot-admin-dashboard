#!/bin/bash
# verify-all-secrets.sh
# Verification script - outputs ONLY non-sensitive data
# Safe to paste outputs into chat for verification

set -e

REPO="miltmon/clausebot-admin-dashboard"

echo "🔍 Verification Report - ClauseBot Admin Dashboard"
echo "==================================================="
echo ""
echo "📅 Date: $(date)"
echo ""

# 1. GitHub Secrets
echo "1️⃣ GitHub Secrets (names only, no values)"
echo "-------------------------------------------"
gh secret list --repo $REPO
echo ""

# 2. Git commit info
echo "2️⃣ Latest Git Commit"
echo "---------------------"
git log -1 --oneline
echo ""

# 3. Files in repo
echo "3️⃣ Key Files in Repository"
echo "----------------------------"
git ls-files | grep -E "(health|_document|LaunchMetrics|prevent-print|vercel.json)" || echo "No matching files found"
echo ""

# 4. Vercel environment variables (if VERCEL_TOKEN is set)
echo "4️⃣ Vercel Environment Variables"
echo "--------------------------------"
if command -v vercel &>/dev/null; then
  if vercel whoami &>/dev/null; then
    echo "Vercel CLI authenticated:"
    vercel env ls 2>/dev/null || echo "Run 'vercel env ls' manually to check"
  else
    echo "⚠️  Not logged in to Vercel CLI"
    echo "Run: vercel login"
  fi
else
  echo "⚠️  Vercel CLI not installed"
fi
echo ""

# 5. GitHub Actions workflows
echo "5️⃣ GitHub Actions Status"
echo "-------------------------"
gh run list --repo $REPO --limit 5 --json workflowName,status,conclusion,createdAt,htmlUrl | \
  jq -r '.[] | "\(.workflowName): \(.status) (\(.conclusion // "N/A")) - \(.htmlUrl)"' 2>/dev/null || \
  echo "No recent workflow runs or jq not installed"
echo ""

# 6. Health endpoint check (if deployed)
echo "6️⃣ Health Endpoint Check"
echo "-------------------------"
echo "Attempting to reach deployed health endpoint..."
VERCEL_URL=$(gh api repos/$REPO/deployments --jq '.[0].payload.web_url' 2>/dev/null || echo "")

if [ -n "$VERCEL_URL" ]; then
  echo "Testing: $VERCEL_URL/api/health"
  curl -sS "$VERCEL_URL/api/health" 2>/dev/null | jq . || echo "❌ Health endpoint not reachable yet"
else
  echo "⚠️  No deployment URL found yet"
  echo "After Vercel deployment, manually test:"
  echo "  curl https://your-vercel-url.vercel.app/api/health"
fi
echo ""

# 7. Repository status
echo "7️⃣ Repository Status"
echo "---------------------"
echo "Remote URL: $(git remote get-url origin)"
echo "Current branch: $(git branch --show-current)"
echo "Tracking: $(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null || echo 'Not tracking remote')"
echo ""

echo "✅ Verification complete!"
echo ""
echo "📋 SAFE TO PASTE ALL OUTPUT ABOVE INTO CHAT"
echo ""
echo "Next steps:"
echo "  1. Review output above for any missing secrets"
echo "  2. Deploy to Vercel: vercel --prod"
echo "  3. Test health endpoint after deployment"
echo "  4. Set up UptimeRobot monitoring"

