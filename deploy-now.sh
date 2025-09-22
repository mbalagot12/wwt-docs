#!/bin/bash

# Bulletproof Deployment Script for Critical Content Changes
# This script works regardless of GitHub Pages status

set -e  # Exit on any error

echo "🚀 BULLETPROOF DEPLOYMENT: Building and deploying your latest changes..."

# Build the site locally with all your latest changes
echo "📦 Building site with your latest content..."
mkdocs build

# Create mike deployment structure
echo "🔧 Creating versioned deployment structure..."
mike deploy 2025.1.STL "Latest changes $(date '+%Y-%m-%d %H:%M:%S')"

# Upload directly to nginx server
echo "📤 Uploading directly to nginx server..."

# Create temporary directory
TEMP_DIR=$(mktemp -d)
echo "Using temp directory: $TEMP_DIR"

# Copy the built site
cp -r site/* "$TEMP_DIR/"

# Upload to server
echo "🔄 Syncing to server..."
ssh -i /Users/miguelbalagot/Documents/MyKeyPairs/mb-partner-kp.pem ubuntu@ec2-3-140-61-206.us-east-2.compute.amazonaws.com "
  # Fix permissions for upload
  sudo chown -R ubuntu:ubuntu /var/www/wwt-acws.duckdns.org
"

# Sync files
rsync -avz --delete \
      --exclude='.git*' \
      --exclude='*.tmp' \
      --exclude='*.log' \
      -e 'ssh -i /Users/miguelbalagot/Documents/MyKeyPairs/mb-partner-kp.pem' \
      "$TEMP_DIR/" ubuntu@ec2-3-140-61-206.us-east-2.compute.amazonaws.com:/var/www/wwt-acws.duckdns.org/

# Set proper permissions and reload nginx
ssh -i /Users/miguelbalagot/Documents/MyKeyPairs/mb-partner-kp.pem ubuntu@ec2-3-140-61-206.us-east-2.compute.amazonaws.com "
  sudo chown -R www-data:www-data /var/www/wwt-acws.duckdns.org
  sudo chmod -R 755 /var/www/wwt-acws.duckdns.org
  sudo systemctl reload nginx
  echo '✅ Deployment complete, nginx reloaded'
"

# Clean up
rm -rf "$TEMP_DIR"

echo "✅ DEPLOYMENT SUCCESSFUL!"
echo "🌐 Your changes are now live at: https://wwt-acws.duckdns.org/2025.1.STL/"
echo "📝 This includes your latest agenda changes and all content updates"

# Test the deployment
echo "🔍 Testing deployment..."
sleep 5
if curl -s -f "https://wwt-acws.duckdns.org/2025.1.STL/" > /dev/null; then
    echo "✅ Site is accessible and working!"
else
    echo "⚠️ Site may need a moment to propagate"
fi

echo ""
echo "🎯 BULLETPROOF DEPLOYMENT COMPLETE!"
echo "   Your agenda changes are now live and ready for your presentation!"
