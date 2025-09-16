# 🏫 Arista Campus Workshop Documentation

[![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-Live-brightgreen)](https://mbalagot12.github.io/wwt-docs/)
[![Nginx Server](https://img.shields.io/badge/Nginx-AWS%20EC2-orange)](http://wwt-acws.duckdns.org/)
[![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-CI%2FCD-blue)](https://github.com/mbalagot12/wwt-docs/actions)
[![MkDocs](https://img.shields.io/badge/MkDocs-Material-blue)](https://squidfunk.github.io/mkdocs-material/)
[![Mike Versioning](https://img.shields.io/badge/Mike-Versioning-orange)](https://github.com/jimporter/mike)
[![UV](https://img.shields.io/badge/UV-Environment-purple)](https://github.com/astral-sh/uv)

**Enterprise-grade documentation platform** for the Arista Campus Workshop, featuring **fully automated CI/CD pipeline**, **dual-platform deployment** (GitHub Pages + AWS EC2 nginx), **intelligent version management**, and **comprehensive dry-run testing**.

## 🌟 Enterprise Features

### 🚀 **Automated CI/CD Pipeline**
- ⚡ **Push-to-Deploy**: Automatic deployment on content changes
- 🔄 **Dual Platform**: GitHub Pages + AWS EC2 nginx server
- 🧪 **Dry-Run Testing**: Safe testing before production deployment
- 📊 **Health Monitoring**: Automated maintenance and status checks
- 🔐 **Secure Authentication**: GitHub Actions with encrypted secrets

### 🛡️ **Advanced Version Management**
- 🔄 **Protected Versioning**: Mike-powered version control with safeguards
- 🎯 **Smart Detection**: Intelligent change detection and deployment
- 📦 **Version Isolation**: Each version completely separate and protected
- 🔒 **Rollback Capability**: Easy rollback to previous versions
- 📈 **Release Management**: Automated version tagging and releases

### 🧪 **Comprehensive Testing**
- 🧪 **Multi-Level Testing**: Local, GitHub Pages, and nginx server testing
- 🔌 **Smart Port Handling**: Automatic port conflict resolution
- 🎯 **Content Validation**: Automated link checking and content validation
- 📱 **Cross-Platform**: Mobile-optimized responsive design
- 🔗 **Enhanced Links**: ATD links that open in new tabs

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

### 3. CI/CD Pipeline Setup

**🚀 Your CI/CD pipeline is ready to use!** The automation is already configured and will trigger automatically when you push changes.

#### Quick Authentication Setup

```bash
# Add your GitHub Personal Access Token to repository secrets
./add_repo_secret.sh

# Or use the direct method
./add_token_direct.sh

# Or add manually via GitHub web interface:
# Go to: https://github.com/mbalagot12/wwt-docs/settings/secrets/actions
# Add secret: WWT_DOCS_TOKEN (your Personal Access Token)
```

#### Verify Setup

```bash
# Validate authentication and pipeline
./validate_token.sh

# Test CI/CD pipeline safely
./test_dry_run.sh

# Test AWS server connection
./test_aws_connection.sh
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

## 🚀 **GitHub Actions CI/CD Pipeline**

### **🔄 Fully Automated Deployment**

Your CI/CD pipeline provides **enterprise-grade automation**:

#### **Automatic Triggers (Push-to-Deploy)**
- ⚡ **Content Changes**: Automatic deployment when you push to main branch
- 🎯 **Smart Detection**: Only triggers on documentation, data, or config changes
- 🔄 **Dual Platform**: Deploys to both GitHub Pages and AWS EC2 nginx server
- 📊 **Health Monitoring**: Automated status checks and maintenance

#### **Manual Triggers (Version Control)**
- 🎮 **GitHub Actions UI**: Manual workflow triggers with parameters
- 🧪 **Dry-Run Testing**: Test deployments without making changes
- 📦 **Version Releases**: Create and deploy specific versions
- 🔧 **Emergency Deployments**: Force updates when needed

### **🎯 How to Use Your CI/CD Pipeline**

#### **For Daily Content Updates (Automatic)**
```bash
# 1. Edit your documentation files
vim docs/a_wired/a01_lab.md

# 2. Commit and push (triggers automatic deployment)
git add . && git commit -m "Update lab guide" && git push

# 3. GitHub Actions automatically:
#    - Detects changes
#    - Builds documentation
#    - Deploys to GitHub Pages
#    - Syncs to AWS nginx server
#    - Both platforms updated in ~3-5 minutes
```

#### **For Version Releases (Manual)**
```bash
# 1. Go to GitHub Actions: https://github.com/mbalagot12/wwt-docs/actions
# 2. Select "Deploy Documentation" workflow
# 3. Click "Run workflow"
# 4. Fill in details:
#    - Version: 2025.2.STL
#    - Description: Q2 2025 Release
#    - Set as default: true
#    - Dry run: false (or true for testing)
# 5. Click "Run workflow"
```

### **🧪 Comprehensive Dry-Run Testing**

**Always test before deploying to production:**

#### **Local Dry-Run Testing**
```bash
# Test version deployment locally (no actual deployment)
./scripts/version_manager.sh deploy 2025.2.STL "Test version" --dry-run

# Run comprehensive dry-run tests (recommended)
./test_dry_run.sh

# Test AWS server connection
./test_aws_connection.sh
```

#### **GitHub Actions Dry-Run Testing**
```bash
# 1. Go to: https://github.com/mbalagot12/wwt-docs/actions
# 2. Select "Deploy Documentation" workflow
# 3. Click "Run workflow"
# 4. ✅ Check "Dry run" checkbox
# 5. Fill in version details
# 6. Click "Run workflow"
# 7. Monitor test execution without any actual deployment
```

### **🔧 AWS EC2 Server Integration**

Your nginx server is fully integrated and automated:

#### **Server Details**
- **🖥️ Server**: `ec2-3-140-61-206.us-east-2.compute.amazonaws.com`
- **🌐 Website**: http://wwt-acws.duckdns.org/
- **🔐 SSH Key**: `/Users/miguelbalagot/Documents/MyKeyPairs/mb-partner-kp.pem`
- **🔄 Auto-Sync**: Automatically syncs with GitHub Pages deployments

#### **Server Testing**
```bash
# Test server connection and status
./test_aws_connection.sh

# Manual server deployment (if needed)
# GitHub Actions → Deploy to Nginx Server → Run workflow
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

## 🌐 **Live Documentation Access**

### **Production Platforms**

#### **GitHub Pages (Primary)**
- **🌐 Main Site**: [https://mbalagot12.github.io/wwt-docs/](https://mbalagot12.github.io/wwt-docs/)
- **📦 Current Version**: [https://mbalagot12.github.io/wwt-docs/2025.1.STL/](https://mbalagot12.github.io/wwt-docs/2025.1.STL/)
- **🔄 Version Selector**: Available on all pages
- **⚡ Auto-Deploy**: Updates automatically on push

#### **AWS EC2 Nginx Server (Secondary)**
- **🖥️ Live Site**: [http://wwt-acws.duckdns.org/](http://wwt-acws.duckdns.org/)
- **🔄 Auto-Sync**: Syncs with GitHub Pages automatically
- **🛡️ Backup Platform**: Provides redundancy and local access
- **⚡ Fast Updates**: Updates within minutes of GitHub deployment

### **Development Environment**

#### **Local Testing**
- **🏠 Default**: `http://localhost:8000/`
- **🔌 Smart Ports**: Automatically finds available ports (8001, 8002, etc.)
- **📦 Version-Specific**: `http://localhost:PORT/VERSION/`
- **🧪 Dry-Run Testing**: Test versions before deployment

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

## 📚 **Complete Documentation Suite**

### **🚀 CI/CD and Automation Guides**

- **[GITHUB_ACTIONS_AUTOMATION.md](GITHUB_ACTIONS_AUTOMATION.md)**: Complete GitHub Actions automation guide
- **[CI_CD_PIPELINE.md](CI_CD_PIPELINE.md)**: Comprehensive CI/CD pipeline documentation
- **[AWS_SERVER_SETUP_COMPLETE.md](AWS_SERVER_SETUP_COMPLETE.md)**: AWS EC2 server integration guide
- **[NGINX_DEPLOYMENT_GUIDE.md](NGINX_DEPLOYMENT_GUIDE.md)**: Nginx server deployment and management

### **🛡️ Security and Authentication**

- **[SECURITY_GUIDE.md](SECURITY_GUIDE.md)**: Complete security and authentication guide
- **[SECURE_DEPLOYMENT_SUMMARY.md](SECURE_DEPLOYMENT_SUMMARY.md)**: Security deployment summary

### **🧪 Testing and Version Management**

- **[VERSION_MANAGEMENT.md](VERSION_MANAGEMENT.md)**: Advanced version control strategy
- **[TESTING_WORKFLOW.md](TESTING_WORKFLOW.md)**: Comprehensive testing procedures
- **[TESTING_QUICK_REFERENCE.md](TESTING_QUICK_REFERENCE.md)**: Quick testing commands reference

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

## 🎯 **Quick Commands Reference**

### **🚀 CI/CD Pipeline (Ready to Use!)**

```bash
# Your CI/CD pipeline is already configured and ready!

# 1. AUTOMATIC DEPLOYMENT (Just push your changes)
git add . && git commit -m "Update docs" && git push
# → GitHub Actions automatically deploys to both platforms

# 2. MANUAL VERSION DEPLOYMENT
# Go to: https://github.com/mbalagot12/wwt-docs/actions
# → Deploy Documentation → Run workflow → Fill details → Run

# 3. DRY-RUN TESTING (Always test first!)
./test_dry_run.sh                  # Comprehensive testing
./test_aws_connection.sh           # AWS server testing
```

### **🔧 Authentication Setup**

```bash
# Add your GitHub token to repository secrets
./add_repo_secret.sh               # Secure token setup
./add_token_direct.sh              # Direct method
./validate_token.sh                # Verify setup
```

### **🧪 Local Development and Testing**

```bash
# Local development
./scripts/version_manager.sh serve # Start local server
./scripts/version_manager.sh status # Check status

# Version management
./scripts/version_manager.sh deploy <version> "Description" --dry-run
./scripts/version_manager.sh deploy <version> "Description" --push
./scripts/version_manager.sh set-default <version> --push
```

### **📊 Monitoring and Status**

```bash
# GitHub Actions monitoring
gh run list                        # View workflow runs
gh run watch                       # Watch current run
open "https://github.com/mbalagot12/wwt-docs/actions"

# Platform status
curl -I https://mbalagot12.github.io/wwt-docs/
curl -I http://wwt-acws.duckdns.org/
```

---

## 🎉 **Your Enterprise CI/CD Pipeline is Ready!**

### **✅ What's Already Configured:**
- 🚀 **Automatic deployment** on content changes
- 🔄 **Dual-platform deployment** (GitHub Pages + AWS EC2)
- 🧪 **Comprehensive dry-run testing**
- 🛡️ **Version protection** and management
- 📊 **Health monitoring** and maintenance
- 🔐 **Secure authentication** with encrypted secrets

### **🎯 Next Steps:**
1. **Add your token**: Run `./add_repo_secret.sh`
2. **Test the pipeline**: Run `./test_dry_run.sh`
3. **Make a change**: Edit any file in `docs/` and push
4. **Watch automation**: Monitor at https://github.com/mbalagot12/wwt-docs/actions

**Your documentation platform is now enterprise-ready with full CI/CD automation!** 🚀✨
