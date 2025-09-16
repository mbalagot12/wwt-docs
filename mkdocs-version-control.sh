#!/bin/bash
# MkDocs Version Control Script
# Useful commands for managing documentation versions with Mike

# Current active version
CURRENT_VERSION="2025.1.STL"

echo "MkDocs Version Control Helper"
echo "============================="

# Uncomment the command you want to run:

# 1. Deploy current version and set as latest
# mike deploy --push --update-aliases $CURRENT_VERSION latest

# 2. Deploy additional versions (example)
# mike deploy --push --update-aliases 2025.2.NYC

# 3. Set default version
# mike set-default --push latest

# 4. Update existing version with latest changes
# mike deploy --push $CURRENT_VERSION

# 5. List all versions
mike list

# 6. Serve locally for testing
# mike serve -a 0.0.0.0:8000

# 7. Build MkDocs site (without versioning)
# mkdocs build

# 8. Delete a specific version (CAREFUL!)
# mike delete $CURRENT_VERSION --push

# 9. Delete all versions (VERY CAREFUL!)
# mike delete --all --push

echo ""
echo "Edit this script to uncomment the commands you want to run."
