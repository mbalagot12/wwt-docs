# Version Management Strategy for WWT Docs

## Current Setup
- **First Version**: `2025.1.STL` (baseline version)
- **Version Control**: Mike
- **Environment**: UV for Python virtualization

## Protection Strategy for First Version

### 1. Version Naming Convention
- **Format**: `YYYY.Q.LOCATION` (e.g., `2025.1.STL`)
- **First Version**: `2025.1.STL` - **PROTECTED** (never overwrite)
- **Future Versions**: `2025.2.STL`, `2025.3.STL`, etc.

### 2. Mike Commands for Version Management

#### Deploy New Version (WITHOUT overwriting existing)
```bash
# Deploy new version while keeping existing ones
mike deploy 2025.2.STL --update-aliases

# Set new version as latest (optional)
mike set-default 2025.2.STL
```

#### Protect First Version with Aliases
```bash
# Create stable alias for first version
mike alias 2025.1.STL stable

# Create baseline alias
mike alias 2025.1.STL baseline

# List all versions to verify
mike list
```

#### Safe Version Deployment Workflow
```bash
# 1. Always check current versions first
mike list

# 2. Deploy new version with specific name
mike deploy 2025.X.STL

# 3. Verify deployment
mike list

# 4. Set as latest only if ready
mike set-default 2025.X.STL
```

### 3. Version Protection Rules

#### ❌ NEVER DO:
```bash
# This would overwrite existing version
mike deploy 2025.1.STL  # DON'T DO THIS

# This would delete the first version
mike delete 2025.1.STL  # DON'T DO THIS
```

#### ✅ ALWAYS DO:
```bash
# Use unique version numbers
mike deploy 2025.2.STL
mike deploy 2025.3.STL

# Check before deploying
mike list
```

### 4. Recommended Workflow for New Versions

1. **Before Creating New Version**:
   ```bash
   # Check current versions
   mike list
   
   # Verify first version is protected
   git log --oneline gh-pages | head -10
   ```

2. **Deploy New Version**:
   ```bash
   # Create new version with unique identifier
   mike deploy 2025.2.STL "Q2 2025 Release"
   
   # Verify deployment
   mike list
   ```

3. **Set Version Aliases** (if needed):
   ```bash
   # Set new version as latest
   mike set-default 2025.2.STL
   
   # Keep stable pointing to first version
   mike alias 2025.1.STL stable
   ```

### 5. Emergency Recovery

If first version gets accidentally overwritten:
```bash
# Check git history
git log --oneline gh-pages

# Restore from git history
git checkout gh-pages
git reset --hard <commit-hash-of-first-version>
git push origin gh-pages --force
```

### 6. Best Practices

- **Always use unique version identifiers**
- **Test new versions before setting as default**
- **Keep documentation of version changes**
- **Regular backups of gh-pages branch**
- **Use descriptive commit messages for version deployments**

## Version History Template

| Version | Date | Description | Status |
|---------|------|-------------|--------|
| 2025.1.STL | Current | First baseline version | Protected/Stable |
| 2025.2.STL | Future | Q2 2025 updates | Planned |
| 2025.3.STL | Future | Q3 2025 updates | Planned |

## UV Environment Commands

```bash
# Activate UV environment
uv venv activate

# Install/update dependencies
uv pip install -r requirements.txt

# Run mike commands in UV environment
uv run mike deploy 2025.X.STL
```
