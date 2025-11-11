# ⚡ IMMEDIATE ACTIONS — Launch Week Checklist

**Time Remaining**: T-2 Days (November 10 Launch)

---

## 🔥 **TONIGHT (November 8) - Critical Tasks**

### **1. Configure GitHub Secrets** ⏰ **10 minutes**

**Location**: `miltmon/clausebot-enterprise` → Settings → Secrets → Actions

**Required Secrets**:
```bash
WIX_SITE_ID=your_site_id
WIX_API_KEY=your_api_key
WIX_CLIENT_ID=your_client_id
WIX_CLIENT_SECRET=your_client_secret
WIX_ACCOUNT_ID=your_account_id
WIX_REFRESH_TOKEN=your_refresh_token
WIX_WEBHOOK_SECRET=your_webhook_secret
DEPLOYMENT_ENV=staging
```

**Commands to set**:
```bash
gh secret set WIX_SITE_ID --body "your_value" --repo miltmon/clausebot-enterprise
gh secret set WIX_API_KEY --body "your_value" --repo miltmon/clausebot-enterprise
# ... repeat for all 8 secrets
```

**Verify**: Paste `SECRETS SET` + Actions run URL when complete

---

### **2. Trigger Workflow Run** ⏰ **5 minutes**

**Option A - Automatic** (on next push):
```bash
cd clausebot-enterprise
git add .
git commit -m "Configure Wix MCP secrets"
git push origin main
```

**Option B - Manual** (via GitHub UI):
1. Go to: https://github.com/miltmon/clausebot-enterprise/actions
2. Select `ci-smoke-test.yml` workflow
3. Click "Run workflow"
4. Select branch: `main`
5. Click "Run workflow" button

---

### **3. Monitor Validation** ⏰ **10 minutes**

**Watch workflow logs**:
```bash
# Get latest run URL
gh run list --repo miltmon/clausebot-enterprise --limit 1

# Watch logs
gh run watch --repo miltmon/clausebot-enterprise
```

**Verify**:
- ✅ All steps pass
- ✅ Wix site updates
- ✅ No errors in logs

---

## 🌅 **TOMORROW (November 9) - Production Switch**

### **Morning Tasks** (8:00 AM - 12:00 PM)

#### **1. Final System Checks** ⏰ **30 minutes**

**Health Checks**:
```bash
# ClauseBot API
curl -I https://clausebot-api.onrender.com/health

# Crosswalk Stats
curl -sS https://clausebot-api.onrender.com/v1/crosswalk/stats | jq .

# Sample Query
time curl -X POST https://clausebot-api.onrender.com/v1/query \
  -H "Content-Type: application/json" \
  -d '{"question":"What is preheat per AWS D1.1?"}' | jq .
```

**Expected Results**:
- ✅ Health: 200 OK
- ✅ Stats: Valid JSON response
- ✅ Query: <1.2s response time with clause citation

---

#### **2. Stripe Production Switch** ⏰ **20 minutes**

**Pre-Switch Checklist**:
- [ ] Test mode payments verified
- [ ] Webhook endpoints configured
- [ ] Product metadata correct
- [ ] Pricing confirmed ($49 pilot)

**Switch Steps**:
1. Login to Stripe Dashboard
2. Go to Developers → API Keys
3. Replace test keys with live keys
4. Update environment variables:
   ```bash
   STRIPE_PUBLIC_KEY=pk_live_xxx
   STRIPE_SECRET_KEY=sk_live_xxx
   STRIPE_WEBHOOK_SECRET=whsec_xxx
   ```
5. Test live checkout (use real card)
6. Verify webhook fires correctly

---

### **Afternoon Tasks** (12:00 PM - 6:00 PM)

#### **3. Production Deployment** ⏰ **45 minutes**

**Deploy Steps**:
```bash
# Pull latest code
cd clausebot-enterprise
git pull origin main

# Verify build
npm run build

# Deploy to production
npm run deploy:prod

# Verify deployment
curl -I https://your-production-url.com/health
```

**Smoke Test Production**:
```bash
# Run full smoke suite
npm run smoke:prod

# Expected: All tests pass
```

---

#### **4. Final QA Checklist** ⏰ **30 minutes**

**Manual Testing**:
- [ ] Homepage loads correctly
- [ ] Demo works (try 3 queries)
- [ ] Checkout flow works (test purchase)
- [ ] Success page displays
- [ ] Confirmation email sent
- [ ] Subscription created in Stripe
- [ ] Entitlements granted correctly

---

### **Evening Tasks** (6:00 PM - 8:00 PM)

#### **5. Team Briefing** ⏰ **30 minutes**

**Attendees**: All stakeholders

**Agenda**:
1. Review validation results (5 min)
2. Walk through launch timeline (10 min)
3. Assign responsibilities (10 min)
4. Q&A (5 min)

**Responsibilities**:
- **Milton**: Sales, demos, customer support
- **Ops**: Monitor systems, handle incidents
- **Marketing**: Social media, outreach

---

## 🚀 **LAUNCH DAY (November 10) - Hour by Hour**

### **6:00 AM - Pre-Launch Prep** ⏰ **30 minutes**
- [ ] Coffee ☕
- [ ] Review launch checklist
- [ ] Open monitoring dashboards
- [ ] Prepare outreach emails

---

### **7:00 AM - Final Systems Check** ⏰ **30 minutes**
- [ ] Run smoke tests
- [ ] Verify all services healthy
- [ ] Check Stripe dashboard
- [ ] Test payment flow one last time

---

### **8:00 AM - LAUNCH BEGINS** 🚀

#### **8:00 - 9:00 AM: Prepare Outreach**
- [ ] Finalize first 10 email contacts
- [ ] Personalize email templates
- [ ] Queue LinkedIn post for 10 AM

---

### **9:00 AM - FIRST WAVE OUTREACH** 📧
- [ ] Send 10-15 personalized emails
- [ ] Use persona-specific templates
- [ ] Track in spreadsheet

---

### **10:00 AM - SOCIAL MEDIA LAUNCH** 📱
- [ ] Post LinkedIn announcement
- [ ] Post Twitter/X announcement
- [ ] Share in relevant groups

---

### **10:00 AM - 6:00 PM - MONITOR & RESPOND**
- [ ] Check emails every 30 minutes
- [ ] Respond within 1 hour
- [ ] Monitor website analytics
- [ ] Track Stripe dashboard
- [ ] Handle demo requests immediately

---

### **6:00 PM - DAY 1 REVIEW** 📊
- [ ] Calculate metrics
- [ ] Document wins
- [ ] Document challenges
- [ ] Plan Day 2 actions
- [ ] **CELEBRATE!** 🎉

---

## 🆘 **EMERGENCY PROCEDURES**

### **If Site Goes Down**

1. **Check Status**:
   ```bash
   curl -I https://your-site.com/health
   ```

2. **Check Logs**:
   - Vercel/Netlify dashboard
   - Server logs
   - Error tracking (Sentry)

3. **Escalate**:
   - Contact: [Technical Lead]
   - Backup: [Senior Dev]
   - Emergency: [CTO]

---

### **If Payment Fails**

1. **Check Stripe Dashboard**:
   - Look for failed payments
   - Check webhook logs
   - Verify API keys active

2. **Manual Fallback**:
   - Collect payment via invoice
   - Manually grant entitlements
   - Document for later reconciliation

3. **Contact Stripe Support**:
   - Email: support@stripe.com
   - Phone: [Emergency line]

---

## ✅ **SUCCESS METRICS**

**Minimum Viable Launch**:
- [ ] 10 emails sent
- [ ] 0 critical errors
- [ ] Systems stable

**Good Launch**:
- [ ] 20 emails sent
- [ ] 3+ responses
- [ ] 1 demo scheduled

**Great Launch**:
- [ ] 30 emails sent
- [ ] 5+ responses
- [ ] 1 PAYING CUSTOMER 💰

---

## 📞 **KEY CONTACTS**

**Technical Issues**:
- Primary: [Name] - [Email] - [Phone]
- Backup: [Name] - [Email] - [Phone]

**Business Issues**:
- Primary: Milton
- Backup: [Name]

**Stripe Support**:
- Email: support@stripe.com
- Phone: 1-888-926-2289

**Hosting Support**:
- Vercel: support@vercel.com
- Same.new: support@same.new

---

**Everything's ready. Let's launch!** 🚀

