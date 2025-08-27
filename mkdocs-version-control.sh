# Deploy version 2025.1
mike deploy --push --update-aliases 2025.1 latest

# Deploy additional versions
mike deploy --push --update-aliases 2024.12 

# Set default version
mike set-default --push latest

# List all versions
mike list
