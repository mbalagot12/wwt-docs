# Testing Workflow: GitHub Pages + Local Mike Serve

## 🎯 Complete Testing Strategy

This guide ensures you can test your documentation both locally with `mike serve` and on GitHub Pages before making versions live.

## Current Setup Analysis

- **GitHub Pages URL**: `https://<username>.github.io/wwt-docs/`
- **Local Mike URL**: `http://localhost:8000/`
- **Current Version**: `2025.1.STL`
- **Environment**: UV with Mike versioning

## 🧪 Testing Workflows

### Workflow 1: Local Testing First (RECOMMENDED)

```bash
# 1. Start with clean environment
git checkout main
git pull origin main
source .venv/bin/activate

# 2. Make your documentation changes
# Edit files in docs/...

# 3. Deploy locally for testing (NO --push)
./scripts/version_manager.sh deploy 2025.2.STL "Q2 2025 Release"

# 4. Test locally
mike serve
# Visit: http://localhost:8000/2025.2.STL/

# 5. Test version switching
# Visit: http://localhost:8000/ (should show version selector)

# 6. If satisfied, push to GitHub
./scripts/version_manager.sh sync

# 7. Test on GitHub Pages
# Visit: https://<username>.github.io/wwt-docs/2025.2.STL/

# 8. Set as default if everything works
./scripts/version_manager.sh set-default 2025.2.STL --push
```

### Workflow 2: Test Branch Strategy

```bash
# 1. Create test branch
git checkout -b test-version-2025.2.STL

# 2. Make changes and commit
git add .
git commit -m "Test changes for version 2025.2.STL"

# 3. Deploy test version locally
./scripts/version_manager.sh deploy 2025.2.STL-test "Test version"

# 4. Test locally
mike serve

# 5. If good, merge to main and deploy properly
git checkout main
git merge test-version-2025.2.STL
./scripts/version_manager.sh deploy 2025.2.STL "Q2 2025 Release" --push

# 6. Clean up test version
mike delete 2025.2.STL-test
```

### Workflow 3: Staging Environment

```bash
# 1. Deploy to staging version first
./scripts/version_manager.sh deploy 2025.2.STL-staging "Staging version" --push

# 2. Test on GitHub Pages staging
# Visit: https://<username>.github.io/wwt-docs/2025.2.STL-staging/

# 3. Share staging URL with team for review

# 4. When approved, deploy production version
./scripts/version_manager.sh deploy 2025.2.STL "Q2 2025 Release" --push

# 5. Clean up staging
mike delete 2025.2.STL-staging --push
```

## 🔧 Enhanced Testing Commands

The version manager now includes dedicated testing commands:

### New Testing Commands:

```bash
# Start local server for testing
./scripts/version_manager.sh serve [version]

# Test specific version with guided workflow
./scripts/version_manager.sh test <version>

# Quick serve current versions
./scripts/version_manager.sh serve
```

## 📋 Complete Testing Checklist

### Before Deploying New Version:

#### 1. Local Testing
```bash
# Deploy locally (no --push)
./scripts/version_manager.sh deploy 2025.2.STL "Q2 2025 Release"

# Test locally
./scripts/version_manager.sh serve 2025.2.STL
# Visit: http://localhost:8000/2025.2.STL/
```

#### 2. Test Checklist
- [ ] All pages load correctly
- [ ] Navigation works properly
- [ ] Images and videos display
- [ ] Links work (internal and external)
- [ ] Version selector shows all versions
- [ ] Mobile responsiveness
- [ ] Search functionality (if enabled)

#### 3. GitHub Pages Testing
```bash
# Push to GitHub for testing
./scripts/version_manager.sh sync

# Test on GitHub Pages
# Visit: https://<username>.github.io/wwt-docs/2025.2.STL/
```

#### 4. Production Deployment
```bash
# Set as default when satisfied
./scripts/version_manager.sh set-default 2025.2.STL --push
```

## 🌐 URL Structure Reference

### Local Testing URLs:
- **All versions**: `http://localhost:8000/`
- **Specific version**: `http://localhost:8000/2025.1.STL/`
- **Version selector**: `http://localhost:8000/` (dropdown menu)

### GitHub Pages URLs:
- **All versions**: `https://<username>.github.io/wwt-docs/`
- **Specific version**: `https://<username>.github.io/wwt-docs/2025.1.STL/`
- **Latest version**: `https://<username>.github.io/wwt-docs/` (redirects to default)

## 🧪 Testing Scenarios

### Scenario 1: New Feature Testing
```bash
# 1. Create feature branch
git checkout -b feature/new-lab-guide

# 2. Make changes
# Edit docs/...

# 3. Deploy test version
./scripts/version_manager.sh deploy 2025.2.STL-feature "Feature test"

# 4. Test locally
./scripts/version_manager.sh test 2025.2.STL-feature

# 5. If good, merge and deploy properly
git checkout main
git merge feature/new-lab-guide
./scripts/version_manager.sh deploy 2025.2.STL "Q2 2025 Release" --push
```

### Scenario 2: Hotfix Testing
```bash
# 1. Quick fix
git checkout main
# Make urgent changes

# 2. Test current version with fixes
./scripts/version_manager.sh deploy 2025.1.STL-hotfix "Urgent fix"
./scripts/version_manager.sh test 2025.1.STL-hotfix

# 3. Deploy immediately if critical
./scripts/version_manager.sh deploy 2025.1.STL-hotfix "Critical hotfix" --push
./scripts/version_manager.sh set-default 2025.1.STL-hotfix --push
```

### Scenario 3: Multi-Version Testing
```bash
# Test version switching
./scripts/version_manager.sh serve

# Visit http://localhost:8000/
# Test version dropdown functionality
# Verify all versions are accessible
```

## 🔍 Testing Verification Commands

### Check Local Status
```bash
# Complete status
./scripts/version_manager.sh status

# List all versions
./scripts/version_manager.sh list

# Test specific version
./scripts/version_manager.sh test 2025.1.STL
```

### Verify GitHub Sync
```bash
# Check what's on GitHub
git checkout gh-pages
mike list
git log --oneline -5
git checkout main

# Compare with local
mike list
```

## 🚨 Common Testing Issues & Solutions

### Issue 1: Version Not Showing Locally
```bash
# Check if version exists
mike list

# Re-deploy if missing
./scripts/version_manager.sh deploy 2025.1.STL "Re-deploy"

# Clear browser cache and retry
```

### Issue 2: GitHub Pages Not Updating
```bash
# Force push to GitHub
./scripts/version_manager.sh sync

# Check GitHub Pages settings in repository
# Ensure source is set to gh-pages branch
```

### Issue 3: Version Selector Not Working
```bash
# Check mkdocs.yml configuration
grep -A 5 "version:" mkdocs.yml

# Verify mike configuration
mike list
```

### Issue 4: Assets Not Loading
```bash
# Check asset paths in markdown files
# Ensure relative paths are correct for versioned structure
# Example: ./assets/images/... (not /assets/images/...)
```

## 📊 Testing Matrix

| Test Type | Local (mike serve) | GitHub Pages | Status |
|-----------|-------------------|--------------|--------|
| Page Loading | ✅ Required | ✅ Required | - |
| Navigation | ✅ Required | ✅ Required | - |
| Images/Videos | ✅ Required | ✅ Required | - |
| Version Switching | ✅ Required | ✅ Required | - |
| Mobile View | ✅ Required | ✅ Required | - |
| Search | ✅ Optional | ✅ Optional | - |
| Performance | ❌ Limited | ✅ Required | - |

## 🎯 Quick Testing Commands

```bash
# Full testing workflow
./scripts/version_manager.sh deploy 2025.2.STL "Test version"
./scripts/version_manager.sh test 2025.2.STL
# Test in browser, then:
./scripts/version_manager.sh sync
# Test on GitHub Pages, then:
./scripts/version_manager.sh set-default 2025.2.STL --push

# Quick local test
./scripts/version_manager.sh serve

# Status check
./scripts/version_manager.sh status
```

## 🎉 Benefits of This Testing Approach

✅ **Local Testing First**: Catch issues before pushing to GitHub
✅ **GitHub Pages Verification**: Test in production environment
✅ **Version Protection**: Cannot accidentally overwrite protected versions
✅ **Automated URLs**: Script provides correct URLs for testing
✅ **Guided Workflow**: Step-by-step testing process
✅ **Rollback Capability**: Easy to revert if issues found

Your testing workflow is now comprehensive and safe! 🚀
