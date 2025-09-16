# 🔒 Security Guide for CI/CD Pipeline

## Overview

This guide covers secure authentication and token management for the WWT Docs CI/CD pipeline.

## 🎯 Authentication Methods

### Method 1: Secure Token Setup (Recommended)

**Use this for automated CI/CD and when you have a Personal Access Token**

```bash
# Run the secure token setup script
./setup_github_token.sh
```

**What it does:**
- ✅ Securely accepts your token (hidden input)
- ✅ Validates token format and permissions
- ✅ Tests authentication with GitHub API
- ✅ Sets up GitHub CLI authentication
- ✅ Configures git credential helper
- ✅ Adds token to repository secrets
- ✅ Applies secure file permissions
- ✅ Clears token from memory after setup

### Method 2: GitHub CLI Interactive (Browser-based)

**Use this for interactive setup**

```bash
# GitHub CLI interactive authentication
gh auth login
```

**What it does:**
- ✅ Opens browser for OAuth authentication
- ✅ No token handling required
- ✅ Secure OAuth flow
- ✅ Automatic scope management

### Method 3: Manual Setup

**Use this if you prefer manual configuration**

```bash
# Set up git credentials manually
git config --global credential.helper store
echo "https://username:token@github.com" >> ~/.git-credentials
chmod 600 ~/.git-credentials
```

## 🔑 GitHub Personal Access Token

### Creating a Token

1. Go to **GitHub** → **Settings** → **Developer settings** → **Personal access tokens**
2. Click **Generate new token** → **Generate new token (classic)**
3. Set **Expiration** (recommend 90 days for security)
4. Select required **scopes**:

#### Required Scopes for CI/CD

```
✅ repo                    # Full repository access
  ✅ repo:status           # Access commit status
  ✅ repo_deployment       # Access deployment status
  ✅ public_repo           # Access public repositories
  ✅ repo:invite           # Access repository invitations

✅ workflow                # Update GitHub Action workflows

✅ write:packages          # Upload packages to GitHub Package Registry
✅ read:packages           # Download packages from GitHub Package Registry

✅ admin:repo_hook         # Full control of repository hooks
  ✅ write:repo_hook       # Write repository hooks
  ✅ read:repo_hook        # Read repository hooks

✅ admin:org_hook          # Full control of organization hooks (if needed)
```

#### Optional Scopes

```
⚪ user                    # Update ALL user data
  ✅ read:user             # Read user profile data
  ✅ user:email            # Access user email addresses

⚪ admin:public_key        # Full control of user public keys
⚪ admin:gpg_key           # Full control of user GPG keys
```

### Token Security Best Practices

#### ✅ Do's

- **Use fine-grained tokens** when possible
- **Set expiration dates** (90 days recommended)
- **Use minimum required scopes**
- **Store in secure password manager**
- **Use the secure setup script**
- **Regenerate regularly**
- **Monitor token usage** in GitHub settings

#### ❌ Don'ts

- **Never commit tokens to git**
- **Never share tokens with others**
- **Don't use tokens in URLs**
- **Don't store in plain text files**
- **Don't use overly broad scopes**
- **Don't use tokens without expiration**

## 🛡️ Security Features

### Secure Token Handling

The `setup_github_token.sh` script implements multiple security layers:

#### Input Security
```bash
# Hidden input (no echo to terminal)
read -s token

# Format validation
validate_token_format "$token"

# API testing before storage
test_github_token "$token"
```

#### Storage Security
```bash
# Secure file permissions
chmod 600 ~/.git-credentials

# Encrypted GitHub Secrets storage
gh secret set GITHUB_TOKEN_CUSTOM

# Memory cleanup
token=""
unset token
```

#### Access Control
```bash
# Credential helper with cache timeout
git config --global credential.helper 'cache --timeout=3600'

# Scope validation
check_token_scopes "$token"
```

### Repository Secrets

The CI/CD pipeline uses GitHub Secrets for secure token storage:

#### Required Secrets

```yaml
GITHUB_TOKEN_CUSTOM:     # Your Personal Access Token
  Description: Custom GitHub token for CI/CD operations
  Required for: Documentation deployment, workflow triggers
  
NGINX_SERVER_SSH_KEY:    # SSH private key for nginx server
  Description: SSH key for deploying to nginx server
  Required for: Nginx server deployment
  Value: Contents of mb-partner-kp.pem
```

#### Setting Secrets

**Via GitHub CLI (Automated):**
```bash
# Set token secret (done by setup script)
gh secret set GITHUB_TOKEN_CUSTOM

# Set SSH key secret
gh secret set NGINX_SERVER_SSH_KEY < /Users/miguelbalagot/Documents/MyKeyPairs/mb-partner-kp.pem
```

**Via GitHub Web Interface:**
1. Go to **Repository** → **Settings** → **Secrets and variables** → **Actions**
2. Click **New repository secret**
3. Name: `GITHUB_TOKEN_CUSTOM`
4. Value: Your Personal Access Token
5. Click **Add secret**

## 🔍 Security Validation

### Token Testing

The setup script validates your token:

```bash
# API authentication test
curl -H "Authorization: token $token" https://api.github.com/user

# Scope verification
curl -I -H "Authorization: token $token" https://api.github.com/user

# Repository access test
gh repo view
```

### Security Checklist

Before deploying:

- [ ] Token has required scopes
- [ ] Token is stored in GitHub Secrets
- [ ] SSH key is configured for nginx server
- [ ] File permissions are secure (600)
- [ ] No tokens in git history
- [ ] Credential helper is configured
- [ ] Token expiration is set

### Monitoring and Maintenance

#### Regular Security Tasks

```bash
# Check token status
gh auth status

# Verify repository access
gh repo view

# Test CI/CD pipeline (dry run)
./test_dry_run.sh

# Rotate tokens (every 90 days)
./setup_github_token.sh
```

#### Security Monitoring

- **Monitor token usage** in GitHub settings
- **Check for unauthorized access** in audit logs
- **Review workflow runs** for suspicious activity
- **Update tokens before expiration**

## 🚨 Security Incidents

### If Token is Compromised

1. **Immediately revoke the token**:
   - Go to GitHub → Settings → Developer settings → Personal access tokens
   - Find the compromised token and click **Delete**

2. **Generate new token**:
   ```bash
   # Create new token with same scopes
   # Run setup script with new token
   ./setup_github_token.sh
   ```

3. **Update all systems**:
   ```bash
   # Update GitHub Secrets
   gh secret set GITHUB_TOKEN_CUSTOM
   
   # Update local credentials
   ./setup_github_token.sh
   ```

4. **Audit access**:
   - Check GitHub audit logs
   - Review recent workflow runs
   - Verify no unauthorized changes

### If SSH Key is Compromised

1. **Remove key from server**:
   ```bash
   ssh ubuntu@ec2-3-140-61-206.us-east-2.compute.amazonaws.com "sed -i '/COMPROMISED_KEY/d' ~/.ssh/authorized_keys"
   ```

2. **Generate new key pair**:
   ```bash
   ssh-keygen -t rsa -b 4096 -f ~/new-key
   ```

3. **Update GitHub Secrets**:
   ```bash
   gh secret set NGINX_SERVER_SSH_KEY < ~/new-key
   ```

## 🔧 Troubleshooting

### Authentication Issues

#### "Bad credentials" Error
```bash
# Token may be expired or invalid
./setup_github_token.sh  # Re-run token setup
```

#### "Permission denied" Error
```bash
# Check token scopes
gh auth status
# Regenerate token with correct scopes
```

#### SSH Connection Failed
```bash
# Test SSH key
ssh -i /Users/miguelbalagot/Documents/MyKeyPairs/mb-partner-kp.pem ubuntu@ec2-3-140-61-206.us-east-2.compute.amazonaws.com

# Check key permissions
chmod 600 /Users/miguelbalagot/Documents/MyKeyPairs/mb-partner-kp.pem
```

### Workflow Failures

#### "GITHUB_TOKEN_CUSTOM not found"
```bash
# Add token to repository secrets
gh secret set GITHUB_TOKEN_CUSTOM
```

#### "NGINX_SERVER_SSH_KEY not found"
```bash
# Add SSH key to repository secrets
gh secret set NGINX_SERVER_SSH_KEY < /Users/miguelbalagot/Documents/MyKeyPairs/mb-partner-kp.pem
```

## 📋 Security Compliance

### Industry Standards

- **OWASP Guidelines**: Following secure coding practices
- **GitHub Security Best Practices**: Token management and access control
- **SSH Security**: Key-based authentication with secure permissions
- **Principle of Least Privilege**: Minimum required scopes and permissions

### Audit Trail

All security-related actions are logged:

- **GitHub audit logs**: Token usage and repository access
- **Workflow logs**: CI/CD pipeline execution
- **SSH logs**: Server access and deployment activities
- **Git logs**: All code changes and deployments

## 🎯 Quick Setup

For immediate secure setup:

```bash
# 1. Run the comprehensive setup
./setup_cicd.sh

# 2. Choose option 2 (Personal Access Token)
# 3. Enter your token securely
# 4. Test the setup
./test_dry_run.sh

# 5. Deploy when ready
./scripts/version_manager.sh deploy <version> "<description>" --push
```

**Your CI/CD pipeline is now securely configured!** 🔒
