# Version Protection Setup Guide

## 🛡️ Protecting Your First Version (2025.1.STL)

This guide ensures your first Mike version `2025.1.STL` is never accidentally overwritten when introducing new versions.

## Quick Setup

### 1. Create Stable Alias for First Version
```bash
# Create a stable alias pointing to your first version
mike alias 2025.1.STL stable

# Create a baseline alias as well
mike alias 2025.1.STL baseline

# Verify aliases are created
mike list
```

### 2. Use the Version Manager Script
```bash
# Make script executable (already done)
chmod +x scripts/version_manager.sh

# List current versions
./scripts/version_manager.sh list

# Deploy new version safely (will prevent overwriting protected versions)
./scripts/version_manager.sh deploy 2025.2.STL "Q2 2025 Release"
```

## UV Environment Setup

### 1. Activate UV Environment
```bash
# If you haven't created a UV environment yet
uv venv

# Activate the environment
source .venv/bin/activate  # On macOS/Linux
# or
.venv\Scripts\activate     # On Windows
```

### 2. Install Dependencies
```bash
# Install all requirements with UV
uv pip install -r requirements.txt

# Verify Mike is installed
mike --version
```

## Safe Version Management Workflow

### For Future Version Deployments:

#### ✅ SAFE - Deploy New Version
```bash
# Using version manager (recommended)
./scripts/version_manager.sh deploy 2025.2.STL "Q2 2025 Updates"

# Or manually (but be careful)
mike deploy 2025.2.STL "Q2 2025 Updates"
```

#### ✅ SAFE - Set New Default
```bash
# Using version manager
./scripts/version_manager.sh set-default 2025.2.STL

# Or manually
mike set-default 2025.2.STL
```

#### ❌ DANGEROUS - Never Do This
```bash
# This would overwrite your first version!
mike deploy 2025.1.STL  # DON'T DO THIS!

# This would delete your first version!
mike delete 2025.1.STL  # DON'T DO THIS!
```

## Version Naming Strategy

### Recommended Format: `YYYY.Q.LOCATION`
- `2025.1.STL` - Q1 2025, STL location (PROTECTED)
- `2025.2.STL` - Q2 2025, STL location
- `2025.3.STL` - Q3 2025, STL location
- `2025.4.STL` - Q4 2025, STL location

### Alternative Format: `YYYY.MM.LOCATION`
- `2025.01.STL` - January 2025 (PROTECTED)
- `2025.03.STL` - March 2025
- `2025.06.STL` - June 2025

## Emergency Recovery

If something goes wrong:

### 1. Check Git History
```bash
git log --oneline gh-pages | head -20
```

### 2. Restore from Backup
```bash
# Create backup first
./scripts/version_manager.sh backup

# If you need to restore
git checkout gh-pages
git reset --hard <commit-hash-of-good-state>
git push origin gh-pages --force
```

## Verification Commands

### Check Current Status
```bash
# List all versions
mike list

# Check git branches
git branch -a

# Verify first version exists
mike list | grep "2025.1.STL"
```

### Test New Version Deployment
```bash
# Test with a development version first
mike deploy 2025.1.STL-test "Test deployment"

# If successful, delete test version
mike delete 2025.1.STL-test

# Then deploy real new version
mike deploy 2025.2.STL "Real Q2 release"
```

## Integration with CI/CD

If you use GitHub Actions or similar:

```yaml
# .github/workflows/deploy-docs.yml
name: Deploy Documentation

on:
  push:
    tags:
      - 'v*'

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup UV
        run: |
          pip install uv
          uv venv
          source .venv/bin/activate
          uv pip install -r requirements.txt
      
      - name: Deploy with protection
        run: |
          # Extract version from tag
          VERSION=${GITHUB_REF#refs/tags/v}
          
          # Use version manager for safe deployment
          ./scripts/version_manager.sh deploy "$VERSION" "Release $VERSION"
```

## Summary

✅ **Protected**: `2025.1.STL` with aliases `stable` and `baseline`
✅ **Safe Deployment**: Use `./scripts/version_manager.sh deploy <new-version>`
✅ **UV Environment**: Properly configured with all dependencies
✅ **Backup Strategy**: Automatic backup creation before major changes
✅ **Recovery Plan**: Git-based recovery if needed

Your first version is now protected from accidental overwrites!
