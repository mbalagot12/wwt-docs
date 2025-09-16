# 🖥️ Nginx Server Deployment Guide

## Your Current Setup

- **Server**: ec2-3-140-61-206.us-east-2.compute.amazonaws.com (Ubuntu Linux)
- **SSH Key**: `/Users/miguelbalagot/Documents/MyKeyPairs/mb-partner-kp.pem`
- **Website**: http://wwt-acws.duckdns.org/
- **Server Path**: `/var/www/wwt-acws.duckdns.org`
- **User**: ubuntu

## 🚀 Quick Setup for CI/CD

### Step 1: Test Your Current Connection

```bash
# Test your existing SSH connection and server setup
./test_nginx_connection.sh
```

This script will verify:
- ✅ SSH key exists and has correct permissions
- ✅ Connection to ec2-3-140-61-206.us-east-2.compute.amazonaws.com works
- ✅ Server directory structure is correct
- ✅ Git is installed on server
- ✅ Nginx is running
- ✅ Website is accessible

### Step 2: Configure CI/CD Pipeline

```bash
# Run the CI/CD setup script
./setup_cicd.sh
```

When prompted:
1. **Use existing keypair**: Choose **Yes** to use `mb-partner-kp.pem`
2. **Server hostname**: Enter `ec2-3-140-61-206.us-east-2.compute.amazonaws.com` (or press Enter for default)
3. **GitHub authentication**: Follow prompts to authenticate

The script will:
- ✅ Use your existing `mb-partner-kp.pem` key
- ✅ Add the private key to GitHub Secrets
- ✅ Test the connection
- ✅ Verify all workflow files

### Step 3: Test the Pipeline

```bash
# Make a small change to test deployment
echo "<!-- Test change $(date) -->" >> docs/index.md

# Commit and push (triggers automatic deployment)
git add .
git commit -m "Test CI/CD pipeline deployment"
git push origin main
```

## 🔧 Manual Server Configuration

If you need to manually configure your nginx server:

### Server Directory Setup

```bash
# SSH to your server
ssh -i /Users/miguelbalagot/Documents/MyKeyPairs/mb-partner-kp.pem ubuntu@ec2-3-140-61-206.us-east-2.compute.amazonaws.com

# Create and configure directory
sudo mkdir -p /var/www/wwt-acws.duckdns.org
sudo chown -R www-data:www-data /var/www/wwt-acws.duckdns.org
sudo chmod -R 755 /var/www/wwt-acws.duckdns.org
```

### Nginx Configuration

```bash
# Create nginx site configuration
sudo nano /etc/nginx/sites-available/wwt-acws.duckdns.org
```

Add this configuration:

```nginx
server {
    listen 80;
    server_name wwt-acws.duckdns.org;
    
    root /var/www/wwt-acws.duckdns.org;
    index index.html;
    
    # Handle Mike versioning routes
    location / {
        try_files $uri $uri/ $uri/index.html =404;
    }
    
    # Handle version-specific routes
    location ~ ^/([^/]+)/(.*)$ {
        try_files $uri $uri/ /$1/index.html =404;
    }
    
    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
    
    # Cache static assets
    location ~* \.(css|js|png|jpg|jpeg|gif|ico|svg|mp4|mov)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
    
    # Handle CSV files
    location ~* \.csv$ {
        add_header Content-Type "text/csv";
        add_header Content-Disposition "attachment";
    }
}
```

Enable the site:

```bash
# Enable the site
sudo ln -s /etc/nginx/sites-available/wwt-acws.duckdns.org /etc/nginx/sites-enabled/

# Test configuration
sudo nginx -t

# Reload nginx
sudo systemctl reload nginx
```

### Initial Git Repository Setup

```bash
# SSH to server
ssh -i /Users/miguelbalagot/Documents/MyKeyPairs/mb-partner-kp.pem ubuntu@ec2-3-140-61-206.us-east-2.compute.amazonaws.com

# Navigate to web directory
cd /var/www/wwt-acws.duckdns.org

# Clone the repository (gh-pages branch)
sudo git clone -b gh-pages https://github.com/mbalagot12/wwt-docs.git .

# Set proper ownership
sudo chown -R www-data:www-data /var/www/wwt-acws.duckdns.org
```

## 🔄 How CI/CD Deployment Works

### Automatic Process

1. **Trigger**: You push changes to `main` branch
2. **GitHub Actions**: Detects changes and runs deployment workflow
3. **Build**: Creates new Mike version and deploys to gh-pages
4. **Nginx Sync**: Automatically pulls latest changes to your server
5. **Verification**: Tests that the site is accessible

### Manual Deployment

```bash
# Trigger manual deployment via GitHub Actions
gh workflow run deploy-docs.yml

# Or deploy directly to server
ssh -i /Users/miguelbalagot/Documents/MyKeyPairs/mb-partner-kp.pem ubuntu@ec2-3-140-61-206.us-east-2.compute.amazonaws.com
cd /var/www/wwt-acws.duckdns.org
sudo git pull origin gh-pages
sudo systemctl reload nginx
```

## 🛡️ Security Considerations

### SSH Key Security

- ✅ **Key permissions**: Ensure `mb-partner-kp.pem` has 600 permissions
- ✅ **GitHub Secrets**: Private key is securely stored in GitHub Secrets
- ✅ **Server access**: Only ubuntu user has access via this key

### Server Security

```bash
# Update server packages
sudo apt update && sudo apt upgrade -y

# Configure firewall (if not already done)
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw --force enable

# Check nginx security
sudo nginx -t
```

## 📊 Monitoring and Maintenance

### Health Checks

The CI/CD pipeline includes automated health checks:
- ✅ **Daily monitoring**: Checks site availability
- ✅ **Link validation**: Verifies external links work
- ✅ **Server status**: Monitors nginx and server health

### Manual Health Check

```bash
# Check website status
curl -I http://wwt-acws.duckdns.org/

# Check server status
ssh -i /Users/miguelbalagot/Documents/MyKeyPairs/mb-partner-kp.pem ubuntu@mb-acws2 "
  sudo systemctl status nginx
  df -h
  free -h
"
```

### Log Monitoring

```bash
# Check nginx logs
ssh -i /Users/miguelbalagot/Documents/MyKeyPairs/mb-partner-kp.pem ubuntu@mb-acws2 "
  sudo tail -f /var/log/nginx/access.log
"

# Check error logs
ssh -i /Users/miguelbalagot/Documents/MyKeyPairs/mb-partner-kp.pem ubuntu@mb-acws2 "
  sudo tail -f /var/log/nginx/error.log
"
```

## 🚨 Troubleshooting

### Common Issues

#### SSH Connection Failed
```bash
# Check key permissions
chmod 600 /Users/miguelbalagot/Documents/MyKeyPairs/mb-partner-kp.pem

# Test connection
ssh -i /Users/miguelbalagot/Documents/MyKeyPairs/mb-partner-kp.pem ubuntu@mb-acws2
```

#### Website Not Accessible
```bash
# Check nginx status
ssh -i /Users/miguelbalagot/Documents/MyKeyPairs/mb-partner-kp.pem ubuntu@mb-acws2 "
  sudo systemctl status nginx
  sudo nginx -t
"
```

#### Git Pull Fails
```bash
# Reset git repository
ssh -i /Users/miguelbalagot/Documents/MyKeyPairs/mb-partner-kp.pem ubuntu@mb-acws2 "
  cd /var/www/wwt-acws.duckdns.org
  sudo git fetch origin
  sudo git reset --hard origin/gh-pages
"
```

### Emergency Recovery

```bash
# Restore from backup (if available)
ssh -i /Users/miguelbalagot/Documents/MyKeyPairs/mb-partner-kp.pem ubuntu@mb-acws2 "
  sudo rm -rf /var/www/wwt-acws.duckdns.org
  sudo mv /var/www/wwt-acws.duckdns.org.backup.TIMESTAMP /var/www/wwt-acws.duckdns.org
  sudo systemctl reload nginx
"
```

## ✅ Verification Checklist

After setup, verify:

- [ ] SSH connection works with existing key
- [ ] Website loads at http://wwt-acws.duckdns.org/
- [ ] GitHub Actions workflows are configured
- [ ] NGINX_SERVER_SSH_KEY secret is added to GitHub
- [ ] Test deployment works (push a small change)
- [ ] Automatic deployment triggers on push to main
- [ ] Health monitoring is active

## 🎯 Next Steps

1. **Run the test script**: `./test_nginx_connection.sh`
2. **Configure CI/CD**: `./setup_cicd.sh`
3. **Test deployment**: Make a small change and push
4. **Monitor workflows**: Check GitHub Actions tab
5. **Verify website**: Visit http://wwt-acws.duckdns.org/

**Your nginx server is now ready for automated CI/CD deployment!** 🚀
