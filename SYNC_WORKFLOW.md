# GitHub & Local Mike Version Sync Workflow

## 🎯 Best Practices for Version Synchronization

This guide ensures your GitHub repository and local Mike versions stay perfectly synchronized.

## Current Setup Analysis

- **Local Mike Version**: `2025.1.STL [latest, push]`
- **GitHub Branches**: `main` (source), `gh-pages` (Mike versions)
- **Environment**: UV for Python virtualization

## 🔄 Complete Sync Workflow

### 1. Pre-Deployment Checklist

```bash
# Check current status
git status
git branch -a
mike list

# Ensure you're on main branch
git checkout main

# Pull latest changes from GitHub
git pull origin main

# Activate UV environment
source .venv/bin/activate  # or uv venv activate
```

### 2. Deploy and Push Workflow

#### Option A: Deploy with Automatic Push (Recommended)
```bash
# Deploy new version and push to GitHub in one command
mike deploy 2025.2.STL "Q2 2025 Release" --push

# Set as default and push
mike set-default 2025.2.STL --push

# Verify deployment
mike list
```

#### Option B: Deploy Then Push Manually
```bash
# Deploy locally first
mike deploy 2025.2.STL "Q2 2025 Release"

# Test locally
mike serve

# Push to GitHub when ready
git checkout gh-pages
git push origin gh-pages
git checkout main
```

### 3. Source Code Sync

```bash
# After making documentation changes
git add .
git commit -m "Update docs for version 2025.2.STL"
git push origin main

# Then deploy the Mike version
mike deploy 2025.2.STL "Q2 2025 Release" --push
```

## 🛠️ Enhanced Version Manager Script

The version manager now includes GitHub sync capabilities:

### New Commands Available:

```bash
# Deploy and push in one command (RECOMMENDED)
./scripts/version_manager.sh deploy 2025.2.STL "Q2 2025 Release" --push

# Set default and push
./scripts/version_manager.sh set-default 2025.2.STL --push

# Check current status
./scripts/version_manager.sh status

# Sync with GitHub manually
./scripts/version_manager.sh sync
```

## 🎯 Recommended Workflows

### Workflow 1: Complete Version Release (BEST PRACTICE)

```bash
# 1. Start fresh
git checkout main
git pull origin main
source .venv/bin/activate

# 2. Make your documentation changes
# Edit files in docs/...

# 3. Commit source changes
git add .
git commit -m "Update documentation for version 2025.2.STL"
git push origin main

# 4. Deploy Mike version with automatic push
./scripts/version_manager.sh deploy 2025.2.STL "Q2 2025 Release" --push

# 5. Set as default if needed
./scripts/version_manager.sh set-default 2025.2.STL --push

# 6. Verify everything is synced
./scripts/version_manager.sh status
```

### Workflow 2: Test Locally First

```bash
# 1. Deploy locally without pushing
./scripts/version_manager.sh deploy 2025.2.STL "Q2 2025 Release"

# 2. Test locally
mike serve
# Visit http://localhost:8000 to test

# 3. If satisfied, sync to GitHub
./scripts/version_manager.sh sync

# 4. Set as default and push
./scripts/version_manager.sh set-default 2025.2.STL --push
```

### Workflow 3: Emergency Hotfix

```bash
# 1. Quick fix deployment
git add .
git commit -m "Hotfix: Critical documentation update"
git push origin main

# 2. Deploy and push immediately
./scripts/version_manager.sh deploy 2025.1.STL-hotfix "Emergency fix" --push
./scripts/version_manager.sh set-default 2025.1.STL-hotfix --push
```

## 🔍 Verification Commands

### Check Sync Status
```bash
# Complete status check
./scripts/version_manager.sh status

# Manual verification
git status
git log --oneline -5
mike list
```

### Verify GitHub Pages
```bash
# Check if gh-pages is up to date
git checkout gh-pages
git log --oneline -5
git checkout main

# Check remote status
git remote show origin
```

## 🚨 Troubleshooting Sync Issues

### Issue 1: Local and Remote Out of Sync
```bash
# Force sync from GitHub
git checkout gh-pages
git reset --hard origin/gh-pages
git checkout main

# Re-deploy if needed
./scripts/version_manager.sh deploy 2025.1.STL "Re-sync deployment" --push
```

### Issue 2: Mike Version Missing on GitHub
```bash
# Check what's on GitHub
git checkout gh-pages
mike list

# If missing, re-deploy
git checkout main
./scripts/version_manager.sh deploy 2025.1.STL "Restore missing version" --push
```

### Issue 3: Conflicting Changes
```bash
# Backup current state
./scripts/version_manager.sh backup

# Pull latest and resolve
git pull origin main
git pull origin gh-pages

# Re-deploy clean version
./scripts/version_manager.sh deploy 2025.1.STL "Clean deployment" --push
```

## 📋 Daily Workflow Checklist

### Before Making Changes:
- [ ] `git checkout main`
- [ ] `git pull origin main`
- [ ] `source .venv/bin/activate`
- [ ] `./scripts/version_manager.sh status`

### After Making Changes:
- [ ] `git add .`
- [ ] `git commit -m "Descriptive message"`
- [ ] `git push origin main`
- [ ] `./scripts/version_manager.sh deploy <version> "Description" --push`

### Weekly Maintenance:
- [ ] `./scripts/version_manager.sh backup`
- [ ] `./scripts/version_manager.sh status`
- [ ] Verify GitHub Pages site is working
- [ ] Clean up old test versions if any

## 🎯 Key Benefits of This Approach

✅ **Automatic Sync**: `--push` flag handles GitHub sync automatically
✅ **Pre-flight Checks**: Script verifies git status before deployment
✅ **Protected Versions**: Cannot accidentally overwrite `2025.1.STL`
✅ **Status Monitoring**: Easy to check sync status anytime
✅ **Backup Strategy**: Automatic backups before major operations
✅ **UV Compatible**: Works seamlessly with your UV environment

## 🔗 Quick Reference

| Command | Purpose | GitHub Sync |
|---------|---------|-------------|
| `deploy <version> "desc" --push` | Deploy new version | ✅ Auto |
| `set-default <version> --push` | Set default version | ✅ Auto |
| `sync` | Manual GitHub sync | ✅ Manual |
| `status` | Check current state | ❌ Read-only |
| `backup` | Create backup | ✅ Creates branch |

Your Mike versions and GitHub repository will now stay perfectly synchronized! 🎉
