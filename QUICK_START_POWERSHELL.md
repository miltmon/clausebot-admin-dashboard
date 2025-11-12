# 🚀 Quick Start - PowerShell Native

**15-Minute Setup Guide for Windows PowerShell**

---

## ⚡ One-Command Execution

```powershell
cd C:\Users\miltm\MiltmonNDT_Workspace\clausebot-admin-dashboard

# Step 1: Set GitHub secrets (prompts for each)
.\Set-GitHubSecrets.ps1

# Step 2: Set Vercel environment variables (prompts for each)
.\Set-VercelEnvs.ps1

# Step 3: Deploy to Vercel
.\Deploy-ToVercel.ps1

# Step 4: Verify everything
.\Verify-AllSecrets.ps1
```

---

## 📋 What You'll Need

Before running scripts, have these ready:

1. **WIX_MCP_KEY** - From https://manage.wix.com/account/api-keys
2. **AIRTABLE_TOKEN** - From https://airtable.com/create/tokens
3. **SLACK_WEBHOOK_URL** - From https://api.slack.com/apps
4. **GA4 Measurement ID** - From https://analytics.google.com (format: `G-XXXXXXXXXX`)
5. **Stripe Checkout URL** - Your payment link
6. **API URL** - Usually `https://api.miltmonndt.com`

**Keep these in a secure password manager - DO NOT paste into chat!**

---

## 🔐 Security Features

- ✅ Scripts prompt interactively for secrets
- ✅ Values sent directly to encrypted APIs
- ✅ Nothing logged or stored locally
- ✅ Verification output is safe to share

---

## 📊 Verification Output

After running `Verify-AllSecrets.ps1`, you'll see:

```
🔍 Verification Report - ClauseBot Admin Dashboard
===================================================

1️⃣ GitHub Secrets (names only, no values)
-------------------------------------------
WIX_MCP_KEY                Updated 2025-11-11
AIRTABLE_TOKEN             Updated 2025-11-11
SLACK_WEBHOOK_URL          Updated 2025-11-11

2️⃣ Latest Git Commit
---------------------
a1052ac chore(launch): add health endpoint...

6️⃣ Health Endpoint Check
-------------------------
{
  "status": "ok",
  "version": "v10",
  "timestamp": "2025-11-11T..."
}

✅ Verification complete!
```

**This output is 100% safe to paste into chat for review!**

---

## 🛠️ Prerequisites

```powershell
# Check required tools
Get-Command git
Get-Command gh
Get-Command vercel
Get-Command node

# Install missing tools
# GitHub CLI: winget install GitHub.cli
# Vercel CLI: npm i -g vercel
# Node.js: winget install OpenJS.NodeJS

# Login
gh auth login
vercel login
```

---

## ⏱️ Time Breakdown

- Gather tokens: **5 minutes**
- GitHub secrets: **3 minutes**
- Vercel env vars: **3 minutes**
- Deploy: **2 minutes**
- Verify: **1 minute**

**Total: 14 minutes**

---

## 🚨 Troubleshooting

### "Execution Policy" Error
```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

### "gh: not found"
```powershell
winget install GitHub.cli
gh auth login
```

### "vercel: not found"
```powershell
npm i -g vercel
vercel login
```

---

## 📞 Need Help?

1. Check script output for specific error messages
2. Run `.\Verify-AllSecrets.ps1` to see current state
3. Check Vercel dashboard: https://vercel.com/dashboard
4. Check GitHub repo: https://github.com/miltmon/clausebot-admin-dashboard

---

## ✅ Success Checklist

After running all scripts:

- [ ] GitHub secrets exist (`gh secret list`)
- [ ] Vercel env vars set (`vercel env ls`)
- [ ] Site deployed (visit Vercel URL)
- [ ] Health endpoint works (`/api/health`)
- [ ] No errors in verification output

---

**Ready? Run the 4 commands above and you're done!** 🎉

