# 🏫 Arista Campus Workshop Documentation

[![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-Live-brightgreen)](https://mbalagot12.github.io/wwt-docs/)
[![MkDocs](https://img.shields.io/badge/MkDocs-Material-blue)](https://squidfunk.github.io/mkdocs-material/)
[![Mike Versioning](https://img.shields.io/badge/Mike-Versioning-orange)](https://github.com/jimporter/mike)
[![UV](https://img.shields.io/badge/UV-Environment-purple)](https://github.com/astral-sh/uv)

Comprehensive documentation for the Arista Campus Workshop, featuring advanced version management, automated testing workflows, and seamless GitHub Pages integration.

## 🌟 Key Features

- 🔄 **Version Management**: Protected versioning with Mike
- 🧪 **Smart Testing**: Local and GitHub Pages testing workflows
- 🔌 **Port Handling**: Automatic port conflict resolution
- 🔗 **Enhanced Links**: Markdown ATD links that open in new tabs
- 🛡️ **Version Protection**: Safeguards against accidental overwrites
- 🚀 **CI/CD Pipeline**: Fully automated deployment and testing
- 🧪 **Dry Run Testing**: Safe testing before actual deployment
- 🖥️ **Multi-Platform**: GitHub Pages + Nginx server deployment
- 📊 **Health Monitoring**: Automated maintenance and monitoring
- 📱 **Responsive Design**: Mobile-optimized documentation

## 🚀 Quick Start

### Prerequisites

- Python 3.8+
- Git
- GitHub account with repository access

### 1. Clone and Setup

```bash
# Clone the repository
git clone https://github.com/mbalagot12/wwt-docs.git
cd wwt-docs

# Set up UV environment (recommended)
uv venv
source .venv/bin/activate  # macOS/Linux
# or .venv\Scripts\activate  # Windows

# Install dependencies
uv pip install -r requirements.txt
```

### 2. Quick Test

```bash
# Start local server with smart port detection
./scripts/version_manager.sh serve

# Visit: http://localhost:8000/ (or alternative port if 8000 is in use)
```

### 3. Authentication Setup

Choose your preferred authentication method:

#### Option A: Secure Token Setup (Recommended for CI/CD)

```bash
# Run secure token setup script
./setup_github_token.sh

# Follow prompts to enter your Personal Access Token securely
# Token input is hidden and validated automatically
```

#### Option B: GitHub CLI Interactive

```bash
# Authenticate with GitHub CLI (browser-based)
gh auth login

# Follow prompts to authenticate via web browser
```

#### Option C: Comprehensive CI/CD Setup

```bash
# Complete CI/CD pipeline setup with authentication
./setup_cicd.sh

# Choose authentication method when prompted
# Includes dry-run testing and validation
```

### 4. Validation

```bash
# Validate your authentication setup
./validate_token.sh

# Run comprehensive dry-run tests
./test_dry_run.sh
```

## 🛠️ Version Management System

### Current Version Protection

- **Protected Version**: `2025.1.STL` (cannot be overwritten)
- **Current Status**: Live on GitHub Pages
- **Aliases**: `stable`, `baseline` (planned)

### Version Manager Commands

```bash
# Check current status
./scripts/version_manager.sh status

# Deploy new version locally
./scripts/version_manager.sh deploy 2025.2.STL "Q2 2025 Release"

# Deploy and push to GitHub
./scripts/version_manager.sh deploy 2025.2.STL "Q2 2025 Release" --push

# Set as default version
./scripts/version_manager.sh set-default 2025.2.STL --push

# Start local testing server
./scripts/version_manager.sh serve [version]

# Guided testing workflow
./scripts/version_manager.sh test <version>

# Sync with GitHub
./scripts/version_manager.sh sync

# Create backup
./scripts/version_manager.sh backup
```

## 🧪 Testing Workflows

### Local Testing (Recommended First)

```bash
# Deploy version locally (no GitHub push)
./scripts/version_manager.sh deploy 2025.2.STL "Test version"

# Test with smart port detection
./scripts/version_manager.sh serve 2025.2.STL
# Automatically handles port conflicts (8000 → 8001, etc.)

# Visit: http://localhost:PORT/2025.2.STL/
```

### GitHub Pages Testing

```bash
# Push to GitHub for testing
./scripts/version_manager.sh sync

# Test on GitHub Pages
# Visit: https://mbalagot12.github.io/wwt-docs/2025.2.STL/
```

### Production Deployment

```bash
# Set as default when testing passes
./scripts/version_manager.sh set-default 2025.2.STL --push
```

## 🔌 Smart Port Handling

The version manager automatically handles port conflicts:

- **Auto-detection**: Checks if port 8000 is in use
- **Alternative ports**: Suggests next available port (8001, 8002, etc.)
- **Custom ports**: Allows manual port selection
- **User-friendly**: Prompts for confirmation

```bash
# Example port conflict handling:
./scripts/version_manager.sh serve
# → [WARN] Port 8000 is already in use
# → [INFO] Found available port: 8001
# → Use port 8001? (Y/n):
```

## 📋 Project Structure

```
wwt-docs/
├── docs/                          # Documentation source
│   ├── a_wired/                   # Wired networking labs
│   ├── b_wireless/                # Wireless networking labs
│   ├── c_security/                # Security labs
│   ├── assets/                    # Images, videos, demos
│   └── index.md                   # Homepage
├── data/                          # Lab assignment data
│   └── lab_assignment.csv         # Student assignments with ATD links
├── scripts/                       # Automation scripts
│   └── version_manager.sh         # Enhanced version management
├── config/                        # Device configurations
├── requirements.txt               # Python dependencies
├── mkdocs.yml                     # MkDocs configuration
├── VERSION_MANAGEMENT.md          # Version strategy guide
├── SYNC_WORKFLOW.md              # GitHub sync workflows
├── TESTING_WORKFLOW.md           # Testing procedures
├── TESTING_QUICK_REFERENCE.md    # Quick testing guide
└── SETUP_VERSION_PROTECTION.md   # Protection setup guide
```

## 🔗 Enhanced Features

### ATD Token Links

- **Markdown formatted**: `[ATD Instance 1](URL){target="_blank"}`
- **New tab opening**: All ATD links open in separate browser tabs
- **Numbered instances**: ATD Instance 1-22 for easy identification
- **CSV integration**: Seamlessly integrated with lab assignment data

### Video Integration

- **Multiple formats**: Support for MP4 videos with fallback paths
- **Mike compatibility**: Proper relative paths for versioned deployment
- **Responsive design**: Videos work across all device sizes

## 🛡️ Version Protection

### Protected Versions

- **2025.1.STL**: First version, cannot be overwritten
- **Backup system**: Automatic backups before major changes
- **Git integration**: Full version history preservation

### Safety Features

```bash
# These operations are prevented:
mike deploy 2025.1.STL  # ❌ Blocked - would overwrite protected version
mike delete 2025.1.STL  # ❌ Blocked - would delete protected version

# These operations are safe:
mike deploy 2025.2.STL  # ✅ Allowed - new version
mike deploy 2025.1.STL-hotfix  # ✅ Allowed - different name
```

## 🚀 CI/CD Pipeline

### Automated Deployment

The project features a comprehensive CI/CD pipeline that automatically:

- ✅ **Detects changes** in documentation, data, or configuration
- ✅ **Runs comprehensive tests** on pull requests
- ✅ **Deploys new versions** with Mike versioning
- ✅ **Updates GitHub Pages** automatically
- ✅ **Syncs with nginx server** for live site updates
- ✅ **Performs health checks** and maintenance

### Pipeline Triggers

```bash
# Automatic triggers:
git push origin main           # → Auto-deploy if docs changed
git tag v2025.2.STL           # → Create release version
# Pull request                 # → Run tests

# Manual triggers:
# GitHub Actions → Deploy Documentation → Run workflow
# GitHub Actions → Deploy to Nginx Server → Run workflow

# Dry run testing:
# GitHub Actions → Deploy Documentation → Check "Dry run" → Run workflow
# GitHub Actions → Deploy to Nginx Server → Check "Dry run" → Run workflow
```

### 🧪 Dry Run Testing

Test your deployments safely before making actual changes:

```bash
# Test locally with version manager
./scripts/version_manager.sh deploy 2025.2.STL "Test version" --dry-run

# Run comprehensive dry run tests
./test_dry_run.sh

# Test via GitHub Actions:
# 1. Go to Actions tab
# 2. Select workflow (Deploy Documentation or Deploy to Nginx Server)
# 3. Click "Run workflow"
# 4. Check "Dry run" checkbox
# 5. Fill in other details and run
```

### Setup CI/CD Pipeline

```bash
# Test your existing nginx server connection
./test_nginx_connection.sh

# One-command CI/CD setup (uses your existing mb-partner-kp.pem)
./setup_cicd.sh

# Manual setup steps (if needed):
# 1. Use existing SSH key: /Users/miguelbalagot/Documents/MyKeyPairs/mb-partner-kp.pem
# 2. Add NGINX_SERVER_SSH_KEY to GitHub Secrets
# 3. Configure nginx server (mb-acws2)
# 4. Test pipeline with a small change
```

## 🚀 One-Command Operations

### Complete Version Release

```bash
# Deploy, test, and publish new version
./scripts/version_manager.sh deploy 2025.2.STL "Q2 2025 Release" --push
./scripts/version_manager.sh set-default 2025.2.STL --push
```

### Quick Status Check

```bash
# Check everything at once
./scripts/version_manager.sh status
# Shows: git status, current branch, mike versions, recent commits
```

### Emergency Backup

```bash
# Create backup before major changes
./scripts/version_manager.sh backup
# Creates timestamped backup branch
```

## 🌐 URLs and Access

### Live Documentation

- **Main site**: [https://mbalagot12.github.io/wwt-docs/](https://mbalagot12.github.io/wwt-docs/)
- **Current version**: [https://mbalagot12.github.io/wwt-docs/2025.1.STL/](https://mbalagot12.github.io/wwt-docs/2025.1.STL/)
- **Version selector**: Available on all pages

### Local Development

- **Default**: http://localhost:8000/
- **Smart ports**: Automatically finds available ports
- **Version-specific**: http://localhost:PORT/VERSION/

## 🛠️ Troubleshooting

### Common Issues

#### GitHub Pages 404 Error
```bash
# Check GitHub Pages settings
# Repository → Settings → Pages → Source: gh-pages branch

# Redeploy if needed
./scripts/version_manager.sh deploy 2025.1.STL "Redeploy" --push
```

#### Port Conflicts
```bash
# The version manager handles this automatically
./scripts/version_manager.sh serve
# Will prompt for alternative port if 8000 is in use
```

#### Authentication Issues
```bash
# Set up GitHub CLI authentication
gh auth login

# Or use personal access token
git config --global credential.helper cache
```

#### Version Conflicts
```bash
# Check current versions
./scripts/version_manager.sh list

# Check protection status
./scripts/version_manager.sh status
```

### Getting Help

```bash
# Show all available commands
./scripts/version_manager.sh help

# Quick testing setup
./test_setup.sh

# Port handling demo
./test_port_handling.sh
```

## 📚 Documentation

### Comprehensive Guides

- **[CI_CD_PIPELINE.md](CI_CD_PIPELINE.md)**: Complete CI/CD pipeline documentation
- **[NGINX_DEPLOYMENT_GUIDE.md](NGINX_DEPLOYMENT_GUIDE.md)**: Nginx server deployment guide
- **[VERSION_MANAGEMENT.md](VERSION_MANAGEMENT.md)**: Complete version strategy
- **[SYNC_WORKFLOW.md](SYNC_WORKFLOW.md)**: GitHub synchronization workflows
- **[TESTING_WORKFLOW.md](TESTING_WORKFLOW.md)**: Detailed testing procedures
- **[TESTING_QUICK_REFERENCE.md](TESTING_QUICK_REFERENCE.md)**: Quick testing commands
- **[SETUP_VERSION_PROTECTION.md](SETUP_VERSION_PROTECTION.md)**: Protection setup guide

### External Resources

- [MkDocs Documentation](https://www.mkdocs.org/)
- [MkDocs Material Theme](https://squidfunk.github.io/mkdocs-material/)
- [Mike Versioning](https://github.com/jimporter/mike)
- [UV Package Manager](https://github.com/astral-sh/uv)
- [GitHub Pages Guide](https://docs.github.com/en/pages)

### References

- [MkDocs with Nginx on AWS EC2](https://www.pulleycloud.com/mkdocs-nginx-aws-ec2/part-2/)
- [Hosting MkDocs with Nginx](https://getnoc.com/blog/2023-hosting-a-mkdocs-generated-site-using-nginx/)

## 👥 Contributors

### Original Maintainers

- Kyle Bush ([kbush@arista.com](mailto:kbush@arista.com))
- Larry Gomez ([larry@arista.com](mailto:larry@arista.com))

### Channel Partner Edition

- Miguel Balagot ([mbalagot@arista.com](mailto:mbalagot@arista.com))

### Recent Enhancements (2025)

- ✅ **CI/CD Pipeline**: Fully automated deployment and testing workflows
- ✅ **Multi-Platform Deployment**: GitHub Pages + Nginx server automation
- ✅ **Version Management System**: Protected versioning with Mike
- ✅ **Smart Testing Workflows**: Local and GitHub Pages testing
- ✅ **Port Conflict Resolution**: Automatic port handling
- ✅ **Enhanced ATD Integration**: Markdown links with new tab opening
- ✅ **Health Monitoring**: Automated maintenance and monitoring
- ✅ **Comprehensive Documentation**: Complete setup and usage guides

---

## 🎯 Quick Commands Reference

```bash
# Setup and authentication
gh auth login
./setup_cicd.sh                    # Complete CI/CD pipeline setup
./setup_sync.sh                    # Version management setup

# Daily development
./scripts/version_manager.sh serve
./scripts/version_manager.sh status

# Dry run testing (RECOMMENDED FIRST)
./test_dry_run.sh                  # Comprehensive dry run tests
./scripts/version_manager.sh deploy <version> "Description" --dry-run

# Version deployment (manual)
./scripts/version_manager.sh deploy <version> "Description" --push
./scripts/version_manager.sh set-default <version> --push

# CI/CD operations
git push origin main               # → Triggers automatic deployment
gh workflow run deploy-docs.yml   # → Manual deployment trigger
gh run list                       # → View workflow status

# Testing
./scripts/version_manager.sh test <version>
./test_setup.sh

# Emergency
./scripts/version_manager.sh backup
./scripts/version_manager.sh sync
```

**🚀 Ready to start? Run `./setup_cicd.sh` to configure the complete CI/CD pipeline!**
