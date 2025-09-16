# 🧪 Comprehensive Dry Run Guide

## Overview

The CI/CD pipeline includes extensive dry-run capabilities to test deployments safely before making any actual changes. This ensures you can validate everything works correctly without risk.

## 🎯 Why Use Dry Runs?

- ✅ **Test without consequences** - No actual deployments or changes
- ✅ **Validate configurations** - Ensure all settings are correct
- ✅ **Check connectivity** - Verify SSH and GitHub access
- ✅ **Prevent mistakes** - Catch issues before they affect production
- ✅ **Build confidence** - Know exactly what will happen

## 🛠️ Dry Run Capabilities

### 1. Local Version Manager Dry Run

```bash
# Test version deployment locally
./scripts/version_manager.sh deploy 2025.2.STL "Test version" --dry-run

# Test with push simulation
./scripts/version_manager.sh deploy 2025.2.STL "Test version" --push --dry-run

# What it does:
# ✅ Validates MkDocs build
# ✅ Tests Mike deployment locally
# ✅ Shows exact commands that would run
# ✅ Cleans up test version automatically
# ❌ No actual deployment or push
```

### 2. GitHub Actions Dry Run

#### Deploy Documentation Workflow

**Steps:**
1. Go to **GitHub Actions** tab
2. Select **"Deploy Documentation"** workflow
3. Click **"Run workflow"**
4. Fill in the form:
   - **Version**: `2025.2.STL`
   - **Description**: `Test deployment`
   - **Set as default**: `false`
   - **Dry run**: ✅ **Check this box**
5. Click **"Run workflow"**

**What it does:**
- ✅ Detects changes and determines deployment strategy
- ✅ Tests MkDocs build process
- ✅ Simulates Mike deployment (no push to gh-pages)
- ✅ Shows version that would be created
- ✅ Validates all configurations
- ❌ No actual GitHub Pages deployment

#### Nginx Server Deployment Workflow

**Steps:**
1. Go to **GitHub Actions** tab
2. Select **"Deploy to Nginx Server"** workflow
3. Click **"Run workflow"**
4. Fill in the form:
   - **Server hostname**: `mb-acws2`
   - **Force update**: `false`
   - **Dry run**: ✅ **Check this box**
5. Click **"Run workflow"**

**What it does:**
- ✅ Tests SSH connection to nginx server
- ✅ Simulates backup creation
- ✅ Shows git commands that would run
- ✅ Validates nginx configuration
- ✅ Tests server accessibility
- ❌ No actual file changes or nginx reload

### 3. Comprehensive Testing Script

```bash
# Run all dry run tests
./test_dry_run.sh
```

**What it tests:**
- ✅ Local version manager dry run
- ✅ GitHub Actions workflow validation
- ✅ MkDocs build test
- ✅ Mike deployment test (local only)
- ✅ SSH connection test
- ✅ GitHub CLI integration
- ✅ Dependencies check
- ✅ Configuration validation

## 📋 Dry Run Workflow

### Recommended Testing Sequence

```bash
# 1. Start with comprehensive testing
./test_dry_run.sh

# 2. Test specific version deployment locally
./scripts/version_manager.sh deploy 2025.2.STL "Q2 Release" --dry-run

# 3. Test GitHub Actions deployment (dry run)
# Use GitHub UI with dry run checkbox checked

# 4. Test nginx deployment (dry run)
# Use GitHub UI with dry run checkbox checked

# 5. If all tests pass, deploy for real
./scripts/version_manager.sh deploy 2025.2.STL "Q2 Release" --push
```

### Before Every Major Deployment

```bash
# Always test first!
./test_dry_run.sh

# Test the specific deployment
./scripts/version_manager.sh deploy <version> "<description>" --dry-run

# Only then deploy for real
./scripts/version_manager.sh deploy <version> "<description>" --push
```

## 🔍 What Dry Run Shows You

### Local Dry Run Output

```
🧪 DRY RUN: Deploying Version: 2025.2.STL
📝 Description: Test version
⚠️ This is a dry run - no actual deployment will occur

✅ MkDocs build would succeed

Would run commands:
  mike deploy "2025.2.STL" "Test version" --push

✅ Dry run completed - deployment would succeed
ℹ️ To deploy for real, run without --dry-run flag
```

### GitHub Actions Dry Run Summary

```
## 🧪 Dry Run Summary

- Mode: DRY RUN (No actual deployment)
- Version: 2025.2.STL (would be deployed)
- Description: Test version
- Trigger: workflow_dispatch

### 🧪 What Would Happen
- ✅ Build would succeed
- ✅ Mike deployment would work
- ✅ Version would be created: 2025.2.STL
- ✅ No actual push to gh-pages
- ✅ No nginx server update

### 🚀 To Deploy for Real
Run the workflow again with 'Dry run' unchecked
```

## 🚨 Common Dry Run Scenarios

### Testing New Features

```bash
# Before adding new documentation
./test_dry_run.sh

# Test specific changes
./scripts/version_manager.sh deploy test-feature "New feature test" --dry-run
```

### Testing Configuration Changes

```bash
# After modifying mkdocs.yml or requirements.txt
./test_dry_run.sh

# Test deployment with changes
./scripts/version_manager.sh deploy config-test "Config changes" --dry-run
```

### Testing Server Changes

```bash
# Test nginx server connectivity
./test_nginx_connection.sh

# Test deployment to server (dry run)
# Use GitHub Actions with dry run checkbox
```

## 🛡️ Safety Features

### Automatic Cleanup

- ✅ **Local test versions** are automatically deleted
- ✅ **No persistent changes** are made during dry runs
- ✅ **Git state** is preserved exactly as before
- ✅ **Server state** remains unchanged

### Error Handling

- ✅ **Build failures** are caught and reported
- ✅ **Configuration errors** are identified
- ✅ **Network issues** are detected
- ✅ **Permission problems** are highlighted

### Validation Checks

- ✅ **Dependencies** are verified
- ✅ **File permissions** are checked
- ✅ **Network connectivity** is tested
- ✅ **Configuration syntax** is validated

## 📊 Interpreting Dry Run Results

### ✅ Success Indicators

- "Dry run completed - deployment would succeed"
- "✅ MkDocs build would succeed"
- "✅ SSH connection test passed"
- "✅ All required dependencies are available"

### ⚠️ Warning Signs

- "⚠️ SSH connection test failed (server may be unreachable)"
- "⚠️ No dry run capability in workflow"
- "⚠️ Missing dependencies"

### ❌ Failure Indicators

- "❌ MkDocs build would fail"
- "❌ SSH connection failed"
- "❌ Missing required dependencies"

## 🎯 Best Practices

### Always Test First

```bash
# GOOD: Test before deploying
./scripts/version_manager.sh deploy 2025.2.STL "Release" --dry-run
./scripts/version_manager.sh deploy 2025.2.STL "Release" --push

# BAD: Deploy without testing
./scripts/version_manager.sh deploy 2025.2.STL "Release" --push
```

### Use Comprehensive Testing

```bash
# GOOD: Full testing suite
./test_dry_run.sh
./scripts/version_manager.sh deploy <version> "<desc>" --dry-run
# Then deploy for real

# BAD: Skip comprehensive testing
./scripts/version_manager.sh deploy <version> "<desc>" --push
```

### Test Different Scenarios

```bash
# Test normal deployment
./scripts/version_manager.sh deploy 2025.2.STL "Normal" --dry-run

# Test with push
./scripts/version_manager.sh deploy 2025.2.STL "With push" --push --dry-run

# Test GitHub Actions (use UI with dry run checkbox)
```

## 🚀 Moving from Dry Run to Production

### After Successful Dry Run

```bash
# 1. Dry run passed
./scripts/version_manager.sh deploy 2025.2.STL "Q2 Release" --dry-run
# ✅ Dry run completed - deployment would succeed

# 2. Deploy for real
./scripts/version_manager.sh deploy 2025.2.STL "Q2 Release" --push
# ✅ Version 2025.2.STL deployed successfully
```

### GitHub Actions Transition

1. **Run dry run first** (with checkbox checked)
2. **Review the dry run summary**
3. **Run again for real** (with checkbox unchecked)
4. **Monitor the actual deployment**

## 📞 Troubleshooting Dry Runs

### Dry Run Fails

```bash
# Check what failed
./test_dry_run.sh

# Fix issues and test again
./scripts/version_manager.sh deploy <version> "<desc>" --dry-run
```

### SSH Connection Issues

```bash
# Test connection specifically
./test_nginx_connection.sh

# Check key permissions
chmod 600 /Users/miguelbalagot/Documents/MyKeyPairs/mb-partner-kp.pem
```

### Build Failures

```bash
# Test build manually
mkdocs build

# Check for errors in mkdocs.yml or content
```

## ✅ Dry Run Checklist

Before any major deployment:

- [ ] Run `./test_dry_run.sh` successfully
- [ ] Test specific deployment with `--dry-run` flag
- [ ] Test GitHub Actions deployment (dry run)
- [ ] Test nginx deployment (dry run) if applicable
- [ ] Review all dry run summaries
- [ ] Verify no warnings or errors
- [ ] Confirm expected behavior
- [ ] Only then deploy for real

**Remember: Dry runs are your safety net. Use them liberally!** 🛡️
