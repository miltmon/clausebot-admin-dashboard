# ClauseBot Admin Dashboard - Deployment Guide

## 🎯 Quick Deploy (5 minutes)

### Prerequisites
- Node.js 18+ or Bun
- Vercel account (free tier OK)
- GitHub repo access

### Step 1: Install Vercel CLI
```bash
npm i -g vercel
```

### Step 2: Deploy
```bash
cd clausebot-admin-dashboard
vercel login
vercel --prod --confirm
```

### Step 3: Add Environment Variables
Go to Vercel Dashboard → Project → Settings → Environment Variables

---

## 🔐 Environment Variables

### Required (Add in Vercel UI)

| Variable | Type | Where to Get | Required For |
|----------|------|--------------|--------------|
| `NEXT_PUBLIC_GA_ID` | Public | Google Analytics 4 | Analytics tracking |
| `NEXT_PUBLIC_STRIPE_CHECKOUT_URL` | Public | Stripe Dashboard | Payment links |
| `WIX_MCP_KEY` | **Secret** | Wix API Console | Wix integrations |
| `AIRTABLE_TOKEN` | **Secret** | Airtable Account Settings | Airtable sync |
| `SLACK_WEBHOOK_URL` | **Secret** | Slack App Settings | Notifications |

### Optional

| Variable | Type | Default | Purpose |
|----------|------|---------|---------|
| `NEXT_PUBLIC_API_URL` | Public | `https://api.miltmonndt.com` | Backend API endpoint |
| `NEXT_PUBLIC_ENV` | Public | `production` | Environment identifier |
| `NEXT_PUBLIC_VERSION` | Public | `v10` | Version display |

---

## 📊 Post-Deploy Verification

### 1. Health Check
```bash
curl https://your-vercel-url.vercel.app/health
# Expected: {"status":"ok","timestamp":"...","version":"v10"}
```

### 2. Test Pages
- ✅ Homepage: `https://your-vercel-url.vercel.app/`
- ✅ Dashboard: `https://your-vercel-url.vercel.app/dashboard`
- ✅ Health: `https://your-vercel-url.vercel.app/health`

### 3. Verify Analytics
- Open app in browser
- Check browser console for GA4 tracking: `gtag` should be defined
- Visit Google Analytics Real-time view

---

## 🚨 Monitoring Setup

### UptimeRobot (5 min)
1. Create account: https://uptimerobot.com
2. Add Monitor:
   - Type: HTTP(s)
   - URL: `https://your-vercel-url.vercel.app/health`
   - Interval: 5 minutes
   - Alert: Email or Slack webhook
3. Expected response: `{"status":"ok"}`

### Slack Alerts (10 min)
1. Create Slack app: https://api.slack.com/apps
2. Enable Incoming Webhooks
3. Copy webhook URL
4. Add to Vercel environment: `SLACK_WEBHOOK_URL`
5. Add GitHub secret: `SLACK_BOT_TOKEN` (for workflow notifications)

---

## 🔄 Update Deployment

### Automatic (Recommended)
Push to `main` branch → Vercel auto-deploys

### Manual
```bash
vercel --prod
```

---

## 🛡️ Security Checklist

- [ ] No secrets in repo (run `git grep -i "token"`)
- [ ] Gitleaks workflow enabled (`.github/workflows/secret-scan.yml`)
- [ ] Branch protection on `main`
- [ ] Environment variables set in Vercel UI (not in code)
- [ ] HTTPS enforced (Vercel default)
- [ ] Security headers configured (`vercel.json`)

---

## 📞 Troubleshooting

### Build Fails
```bash
# Test locally first
npm run build
# Check for errors
npm run lint
```

### Environment Variables Not Working
- Redeploy after adding variables: `vercel --prod`
- Check variable names match code (case-sensitive)
- Verify `NEXT_PUBLIC_*` prefix for client-side variables

### 404 Errors
- Check `vercel.json` routes configuration
- Verify pages exist in `pages/` directory
- Check Next.js console for routing errors

---

## 📈 Metrics to Track

**Day 1-7:**
- Unique visitors
- Page views
- Health check uptime (target: 99.9%)
- API success rate

**Week 2-4:**
- User retention
- Feature usage
- Error rates (target: <1%)
- Performance (Core Web Vitals)

---

## 🎉 You're Live!

Default URL: `https://clausebot-admin-dashboard.vercel.app`

Custom domain (optional):
1. Add CNAME: `dashboard.miltmonndt.com` → `cname.vercel-dns.com`
2. Configure in Vercel: Settings → Domains → Add Domain
3. Wait for DNS propagation (5-60 minutes)

---

**Last Updated:** November 11, 2025  
**Version:** 10  
**Status:** Launch Ready ✅

