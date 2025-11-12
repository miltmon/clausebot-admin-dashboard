# 🚀 Quick Start - ClauseBot Admin Dashboard

**30-Minute Setup Guide**

---

## ⚡ Fast Track (Copy-Paste Commands)

### Prerequisites Check
```bash
# Check required tools
command -v git && echo "✅ git" || echo "❌ git missing"
command -v gh && echo "✅ gh" || echo "❌ gh missing"
command -v vercel && echo "✅ vercel" || echo "❌ vercel missing"
command -v node && echo "✅ node" || echo "❌ node missing"
```

### Install Missing Tools
```bash
# GitHub CLI
# Windows: winget install GitHub.cli
# Mac: brew install gh

# Vercel CLI
npm i -g vercel

# Login to both
gh auth login
vercel login
```

---

## 📋 3-Step Setup

### **Step 1: Provision Secrets (10 min)**

```bash
cd C:\Users\miltm\MiltmonNDT_Workspace\clausebot-admin-dashboard

# Make scripts executable (Git Bash/WSL)
chmod +x *.sh

# Run GitHub secrets provisioning
bash set-github-secrets.sh

# Run Vercel env vars provisioning
bash set-vercel-envs.sh
```

**You'll be prompted for:**
- WIX_MCP_KEY
- AIRTABLE_TOKEN
- SLACK_WEBHOOK_URL
- NEXT_PUBLIC_GA_ID
- Other environment variables

**See `SECURITY_CHECKLIST.md`** for where to get these values.

---

### **Step 2: Deploy to Vercel (2 min)**

```bash
# Deploy to production
vercel --prod

# Save the deployment URL shown in output
```

---

### **Step 3: Verify (1 min)**

```bash
# Run verification script
bash verify-all-secrets.sh

# Test health endpoint (replace URL)
curl https://your-vercel-url.vercel.app/api/health
```

**Expected health response:**
```json
{
  "status": "ok",
  "timestamp": "2025-11-11T...",
  "version": "v10",
  "uptime": 123
}
```

---

## 🎯 What's Next?

### Set Up Monitoring (10 min)

**UptimeRobot:**
1. Go to: https://uptimerobot.com
2. Create monitor for your `/api/health` endpoint
3. Set interval: 5 minutes
4. Add Slack alert

**GitHub Actions:**
```bash
# Enable workflows
gh workflow enable prevent-print-secrets.yml

# Test run
gh workflow run prevent-print-secrets.yml

# Check status
gh run list --limit 3
```

---

## 📊 Verification Checklist

After setup, verify these:

- [ ] GitHub secrets exist: `gh secret list`
- [ ] Vercel env vars exist: `vercel env ls`
- [ ] Site deployed: Visit Vercel URL
- [ ] Health endpoint works: `curl .../api/health`
- [ ] GitHub Actions enabled
- [ ] UptimeRobot monitoring active

---

## 🛠️ Troubleshooting

### "gh: command not found"
```bash
# Windows
winget install GitHub.cli

# Mac
brew install gh

# Then login
gh auth login
```

### "vercel: command not found"
```bash
npm i -g vercel
vercel login
```

### "Permission denied" on .sh files
```bash
# Git Bash/WSL
chmod +x *.sh

# PowerShell (run scripts with bash)
bash set-github-secrets.sh
```

### Health endpoint returns 404
- Wait 2-3 minutes for deployment to complete
- Check Vercel dashboard for build errors
- Verify `/pages/api/health.js` exists in repo

---

## 📞 Need Help?

1. Check **`SECURITY_CHECKLIST.md`** for detailed steps
2. Check **`README_DEPLOY.md`** for deployment guide
3. Run **`verify-all-secrets.sh`** and share output (safe)
4. Check Vercel logs: `vercel logs`

---

## 🎉 You're Done!

Your ClauseBot Admin Dashboard is now:
- ✅ Deployed to Vercel
- ✅ Secrets secured
- ✅ Health endpoint active
- ✅ Ready for monitoring

**Share your verification report** (from `verify-all-secrets.sh`) for review!

---

**Time to complete:** 30 minutes  
**Difficulty:** Intermediate  
**Prerequisites:** Git, GitHub CLI, Vercel CLI

