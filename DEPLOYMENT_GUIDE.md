# Simple Content Deployment Guide

## 🎯 **For Simple Content Changes (Recommended)**

### **Step 1: Make Your Changes**
Edit any files in the `docs/` or `data/` directories:
- `docs/agenda.md` - Your agenda page
- `docs/lab/access.md` - Lab access information  
- `docs/a_wired/`, `docs/b_wireless/`, `docs/c_security/` - Lab content
- `data/lab_assignment.csv` - Student assignments

### **Step 2: Commit and Push**
```bash
git add .
git commit -m "Update agenda page content"
git push origin main
```

### **Step 3: Wait for Automatic Deployment**
- ✅ **GitHub Actions will automatically deploy your changes**
- ⏱️ **Total time: ~3-4 minutes**
  - GitHub Pages deployment: ~1-2 minutes
  - Nginx server sync: ~1-2 minutes

### **Step 4: Verify Changes**
Check your changes at:
- **Live Site**: https://wwt-acws.duckdns.org/2025.1.STL/
- **GitHub Pages**: https://mbalagot12.github.io/wwt-docs/2025.1.STL/

---

## 🔧 **How It Works (Behind the Scenes)**

### **Simplified Workflow**
1. **Push to main** → Triggers GitHub Actions
2. **Deploy Documentation** workflow:
   - Builds the site with MkDocs + Mike
   - Updates the `2025.1.STL` version
   - Deploys to GitHub Pages
3. **Deploy to Nginx Server** workflow:
   - Automatically triggered when GitHub Pages completes
   - Downloads the latest site from GitHub Pages
   - Syncs to your nginx server
   - Reloads nginx

### **What Changed**
- ❌ **Removed**: Complex version management, dry-run modes, protection logic
- ❌ **Removed**: Unsupported `--force` flag that was causing failures
- ✅ **Added**: Simple, reliable deployment focused on `2025.1.STL`
- ✅ **Added**: Automatic nginx sync without manual intervention

---

## 🚨 **If Something Goes Wrong**

### **Check Workflow Status**
```bash
gh run list --limit 3
```

### **Manual Trigger (If Needed)**
```bash
# Trigger documentation deployment
gh workflow run deploy-docs.yml

# Trigger nginx sync (if needed)
gh workflow run deploy-nginx.yml
```

### **View Workflow Logs**
```bash
gh run view --log
```

---

## 📝 **Best Practices**

### **Commit Messages**
Use clear, descriptive commit messages:
```bash
git commit -m "Update agenda: Add new session on network security"
git commit -m "Fix typo in lab 2 instructions"
git commit -m "Update student assignments for winter 2025"
```

### **Test Locally (Optional)**
```bash
# Preview changes locally before pushing
uv run mkdocs serve
# Visit http://localhost:8000/2025.1.STL/
```

### **Batch Related Changes**
Make multiple related changes in one commit to avoid multiple deployments:
```bash
# Edit multiple files
git add docs/agenda.md docs/lab/access.md
git commit -m "Update agenda and lab access info for new semester"
git push origin main
```

---

## ✅ **Success Indicators**

### **GitHub Actions**
- ✅ "Deploy Documentation" workflow completes successfully
- ✅ "Deploy to Nginx Server" workflow completes successfully

### **Site Updates**
- ✅ Changes visible at https://wwt-acws.duckdns.org/2025.1.STL/
- ✅ No 404 errors or broken links
- ✅ Images and assets load correctly

---

## 🎉 **That's It!**

Your content deployment is now **simple and reliable**:
1. **Edit** → 2. **Commit** → 3. **Push** → 4. **Wait 3-4 minutes** → 5. **Done!**

No more complex workflows, version conflicts, or manual interventions needed.
