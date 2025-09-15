# 🧪 Testing Quick Reference Card

## 🚀 One-Command Testing

```bash
# Start testing environment
./test_setup.sh

# Quick local test
./scripts/version_manager.sh serve

# Test specific version
./scripts/version_manager.sh serve 2025.1.STL
```

## 📋 Testing Workflow Cheat Sheet

### 1. Local Testing First
```bash
# Deploy locally (no push)
./scripts/version_manager.sh deploy 2025.2.STL "Test version"

# Test locally
./scripts/version_manager.sh serve 2025.2.STL
# Visit: http://localhost:8000/2025.2.STL/
```

### 2. GitHub Pages Testing
```bash
# Push to GitHub for testing
./scripts/version_manager.sh sync

# Test on GitHub Pages
# Visit: https://<username>.github.io/wwt-docs/2025.2.STL/
```

### 3. Make Live
```bash
# Set as default when satisfied
./scripts/version_manager.sh set-default 2025.2.STL --push
```

## 🔗 Quick URLs

### Local Testing (Smart Port Detection)
- **All versions**: http://localhost:PORT/ (auto-detects available port)
- **Current version**: http://localhost:PORT/2025.1.STL/
- **Version selector**: http://localhost:PORT/ (dropdown)
- **Default port**: 8000 (automatically finds alternatives if in use)

### GitHub Pages
- **All versions**: https://`<username>`.github.io/wwt-docs/
- **Current version**: https://`<username>`.github.io/wwt-docs/2025.1.STL/
- **Latest**: https://`<username>`.github.io/wwt-docs/ (redirects to default)

## ✅ Testing Checklist

Quick verification points:
- [ ] Pages load without errors
- [ ] Navigation works
- [ ] Images/videos display
- [ ] Links work (internal & external)
- [ ] Version selector functions
- [ ] Mobile responsive
- [ ] ATD Token links open in new tabs

## 🛠️ Essential Commands

| Command | Purpose | Use When |
|---------|---------|----------|
| `./scripts/version_manager.sh serve` | Start local server | Testing locally |
| `./scripts/version_manager.sh test <version>` | Guided test workflow | Testing specific version |
| `./scripts/version_manager.sh status` | Check current state | Before any operation |
| `./scripts/version_manager.sh sync` | Push to GitHub | Ready for GitHub testing |

## 🚨 Emergency Commands

```bash
# Stop any running server
pkill -f "mike serve"

# Check what's running
./scripts/version_manager.sh status

# Quick status check
mike list
git status
```

## 🎯 Common Testing Scenarios

### New Version Testing
```bash
./scripts/version_manager.sh deploy 2025.2.STL "New version"
./scripts/version_manager.sh serve 2025.2.STL
# Test → Sync → Test on GitHub → Set default
```

### Hotfix Testing
```bash
./scripts/version_manager.sh deploy 2025.1.STL-hotfix "Urgent fix"
./scripts/version_manager.sh test 2025.1.STL-hotfix
# Test → Deploy with --push if critical
```

### Multi-Version Testing
```bash
./scripts/version_manager.sh serve
# Test version switching at http://localhost:8000/
```

---

**💡 Pro Tip**: Always test locally first, then on GitHub Pages, then make it the default version!

**🔒 Protected**: Version `2025.1.STL` cannot be accidentally overwritten.
