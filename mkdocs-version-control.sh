# Deploy version 2025.1
mike deploy --push --update-aliases 2025.1.STL latest

# Deploy additional versions
# mike deploy --push --update-aliases 2025.2.NYC

# Set default version
mike set-default --push latest

# Delete a version
# mike delete 2025.1.STL --push

# Delete all versions
# mike delete --all --push

# Serve the site locally for testing
# mike serve -a 0.0.0.0:8000

# Build the MkDocs site
# mkdocs build

# Deploy the MkDocs site
# mkdocs gh-deploy --force

# update the site with the latest changes
mike deploy --push 2025.1.STL


# List all versions
mike list
