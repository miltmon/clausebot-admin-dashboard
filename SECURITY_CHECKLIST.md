# 🔐 Security Provisioning Checklist

**Project:** ClauseBot Admin Dashboard  
**Date:** November 11, 2025  
**Repository:** https://github.com/miltmon/clausebot-admin-dashboard

---

## ⚠️ CRITICAL SECURITY RULES

1. **NEVER paste secrets into chat or Slack**
2. **NEVER commit secrets to git**
3. **ALWAYS use encrypted secret managers** (GitHub Secrets, Vercel Env Vars)
4. **ROTATE tokens immediately** if exposed
5. **USE 2FA** on all accounts

---

## 📋 Pre-Provisioning Steps

### 1. Create/Rotate All Tokens (Do This First)

**Before running provisioning scripts**, create fresh tokens:

#### Vercel Token
1. Go to: https://vercel.com/account/tokens
2. Click "Create Token"
3. Name: `clausebot-automation`
4. Scope: Full Access (or limit to specific projects)
5. **Copy token** → Save to secure clipboard (do NOT paste in chat)

#### Render API Token
1. Go to: https://dashboard.render.com/u/settings/api-keys
2. Click "Create API Key"
3. Name: `clausebot-automation`
4. **Copy token** → Save to secure clipboard

#### Airtable API Token
1. Go to: https://airtable.com/create/tokens
2. Click "Create new token"
3. Name: `clausebot-dashboard`
4. Scopes: `data.records:read`, `data.records:write`
5. Add bases: Select your ClauseBot bases
6. **Copy token** → Save to secure clipboard

#### Wix MCP Key
1. Go to: https://manage.wix.com/account/api-keys
2. Create new API key
3. Name: `clausebot-mcp`
4. Permissions: As needed for your integration
5. **Copy key** → Save to secure clipboard

#### Slack Webhook URL
1. Go to: https://api.slack.com/apps
2. Select your app (or create new)
3. Features → Incoming Webhooks → Activate
4. Add New Webhook to Workspace
5. Select channel: `#clausebot-alerts`
6. **Copy webhook URL** → Save to secure clipboard

#### Google Analytics 4 ID
1. Go to: https://analytics.google.com/
2. Admin → Data Streams → Web
3. Copy Measurement ID (format: `G-XXXXXXXXXX`)
4. This is public-safe, but still store securely

---

### 2. Revoke Old Tokens (CRITICAL)

**Before provisioning new tokens**, revoke any old/exposed tokens:

#### Wix Token (from `WIX TOKEN.txt`)
```bash
# Delete local file
rm "C:\Users\miltm\MiltmonNDT_Workspace\WIX TOKEN.txt"

# Revoke in Wix console
# Go to: https://manage.wix.com/account/api-keys
# Find old key → Revoke
```

#### Airtable Token (from `airtable_token.txt`)
```bash
# Delete local files
rm "C:\Users\miltm\MiltmonNDT_Workspace\airtable_token.txt"
rm "C:\Users\miltm\MiltmonNDT_Workspace\scripts\airtable_token.txt"

# Revoke in Airtable
# Go to: https://airtable.com/create/tokens
# Find old token → Revoke
```

---

## 🚀 Provisioning Steps

### Step 1: Set GitHub Secrets (5 minutes)

**Run locally:**
```bash
cd C:\Users\miltm\MiltmonNDT_Workspace\clausebot-admin-dashboard
bash set-github-secrets.sh
```

**What it does:**
- Prompts for each secret value interactively
- Sends directly to GitHub encrypted
- Nothing stored locally

**Verification:**
```bash
gh secret list --repo miltmon/clausebot-admin-dashboard
```

Expected output: List of secret names (no values shown)

---

### Step 2: Set Vercel Environment Variables (5 minutes)

**Run locally:**
```bash
bash set-vercel-envs.sh
```

**What it does:**
- Uses Vercel CLI interactive prompts
- Stores values encrypted in Vercel
- Separates public vs secret variables

**Verification:**
```bash
vercel env ls
```

Expected output: List of variable names with target environments

---

### Step 3: Deploy to Vercel (2 minutes)

```bash
vercel --prod
```

**What it does:**
- Builds Next.js app
- Deploys to production
- Applies all environment variables

**Save the deployment URL** for health checks.

---

### Step 4: Verify Deployment (1 minute)

```bash
# Test health endpoint
curl https://your-vercel-url.vercel.app/api/health

# Expected output:
# {
#   "status": "ok",
#   "timestamp": "2025-11-11T...",
#   "version": "v10",
#   "uptime": 123
# }
```

---

### Step 5: Set Up Monitoring (10 minutes)

#### UptimeRobot Monitor
1. Go to: https://uptimerobot.com
2. Add New Monitor:
   - **Type:** HTTP(s)
   - **URL:** `https://your-vercel-url.vercel.app/api/health`
   - **Monitoring Interval:** 5 minutes
   - **Alert Contacts:** Add email + Slack webhook

#### GitHub Actions Monitoring
```bash
# Enable workflows
gh workflow enable prevent-print-secrets.yml --repo miltmon/clausebot-admin-dashboard

# Trigger a test run
gh workflow run prevent-print-secrets.yml --repo miltmon/clausebot-admin-dashboard

# Check status
gh run list --repo miltmon/clausebot-admin-dashboard --limit 3
```

---

## ✅ Final Verification

Run the verification script:

```bash
bash verify-all-secrets.sh > verification-report.txt
```

**This output is SAFE to share** - it contains no secret values.

**Paste into chat for review:**
- GitHub secret names ✅
- Git commit info ✅
- File listings ✅
- Workflow status ✅
- Health endpoint response ✅

---

## 🛡️ Security Hardening (After Deployment)

### 1. Branch Protection
```bash
# Enable branch protection via GitHub CLI
gh api repos/miltmon/clausebot-admin-dashboard/branches/main/protection \
  -X PUT \
  -F required_status_checks='{"strict":true,"contexts":["Prevent Printed Secrets"]}' \
  -F enforce_admins=true \
  -F required_pull_request_reviews='{"required_approving_review_count":1}'
```

### 2. Enable Dependabot
1. Go to: https://github.com/miltmon/clausebot-admin-dashboard/settings/security_analysis
2. Enable:
   - ✅ Dependency graph
   - ✅ Dependabot alerts
   - ✅ Dependabot security updates

### 3. Secret Scanning
1. Go to: https://github.com/miltmon/clausebot-admin-dashboard/settings/security_analysis
2. Enable:
   - ✅ Secret scanning
   - ✅ Push protection

### 4. Enable 2FA on All Accounts
- [ ] GitHub 2FA enabled
- [ ] Vercel 2FA enabled
- [ ] Render 2FA enabled
- [ ] Airtable 2FA enabled
- [ ] Wix 2FA enabled

---

## 🚨 Incident Response

### If Token is Exposed:

1. **Immediate:**
   ```bash
   # Revoke token in service UI immediately
   # Then rotate:
   gh secret set TOKEN_NAME --repo miltmon/clausebot-admin-dashboard
   ```

2. **Within 1 hour:**
   - Check audit logs for unauthorized access
   - Rotate all related secrets
   - Review recent commits/deployments
   - Notify team

3. **Within 24 hours:**
   - Complete security incident report
   - Update documentation
   - Review and improve processes

---

## 📞 Support Contacts

| Service | Support URL | Emergency |
|---------|-------------|-----------|
| GitHub | https://support.github.com | Security tab |
| Vercel | https://vercel.com/support | Dashboard incidents |
| Render | https://render.com/support | Service logs |

---

## 📊 Checklist Summary

**Pre-Provisioning:**
- [ ] Create all fresh tokens
- [ ] Revoke old tokens from files
- [ ] Delete token files locally
- [ ] Enable 2FA on all accounts

**Provisioning:**
- [ ] Run `set-github-secrets.sh`
- [ ] Run `set-vercel-envs.sh`
- [ ] Deploy to Vercel
- [ ] Verify health endpoint

**Post-Provisioning:**
- [ ] Set up UptimeRobot
- [ ] Enable GitHub Actions
- [ ] Configure branch protection
- [ ] Enable Dependabot
- [ ] Enable secret scanning
- [ ] Run `verify-all-secrets.sh`
- [ ] Share verification report (safe outputs only)

**Ongoing:**
- [ ] Monitor UptimeRobot alerts
- [ ] Review GitHub Actions runs weekly
- [ ] Rotate tokens quarterly
- [ ] Audit access logs monthly

---

**Last Updated:** November 11, 2025  
**Status:** Ready for provisioning  
**Next Review:** February 11, 2026

