# Quick Start Guide - La Suite Drive YunoHost Package

## 📦 What's Been Created

A complete YunoHost package for La Suite - Drive v0.18.0, ready to be deployed on YunoHost servers.

### Package Location
```
/home/matzipan/Workspace/drive-ynh/
```

## 🚀 Getting Started

### 1. Verify the Package
```bash
cd /home/matzipan/Workspace/drive-ynh
ls -la  # Check all files are present
```

### 2. Initialize Git (if deploying to GitHub)
```bash
git init
git add .
git commit -m "Initial YunoHost package for La Suite - Drive v0.18.0"
git remote add origin https://github.com/YunoHost-Apps/lasuite-drive_ynh.git
git branch -M main
git push -u origin main
```

### 3. Create Testing Branch
```bash
git checkout -b testing
git push -u origin testing
```

### 4. Test the Package
On a YunoHost server with Minio/Garage installed:
```bash
sudo yunohost app install https://github.com/YunoHost-Apps/lasuite-drive_ynh/tree/testing
```

## 📋 Package Contents

### Configuration Files
- **manifest.toml** - Package metadata, dependencies, and configuration options
- **conf/env** - Django environment variables template
- **conf/nginx.conf** - Nginx proxy configuration
- **conf/systemd.service** - Systemd service definition
- **conf/config_panel.toml** - Web-based configuration UI

### Installation Scripts
- **scripts/install** - Main installation script
- **scripts/remove** - Uninstall script
- **scripts/backup** - Backup creation
- **scripts/restore** - Restore from backup
- **scripts/upgrade** - Upgrade script
- **scripts/change_url** - Handle domain/path changes
- **scripts/config** - Configuration script
- **scripts/_common.sh** - Shared helper functions

### Documentation
- **README.md** - User-facing documentation
- **IMPLEMENTATION_NOTES.md** - Technical details
- **QUICK_START.md** - This file
- **LICENSE** - AGPL-3.0-or-later license

## 🔧 Configuration

### Environment Variables
Edit `conf/env` to customize:
- Database credentials
- Redis configuration
- S3 storage settings
- Email configuration
- Django settings

### Templates
The `__PLACEHOLDER__` values in configuration files are automatically replaced during installation by YunoHost with actual values:
- `__DOMAIN__` → Installation domain
- `__INSTALL_DIR__` → Installation directory
- `__DB_NAME__` → Database name
- `__APP__` → Application identifier
- etc.

## 📝 Requirements

### Server Requirements
- YunoHost ≥ 12.1.17
- 2000 MB disk space for installation
- 2000 MB RAM for build process
- 400 MB RAM for runtime

### Dependencies
- PostgreSQL (auto-configured)
- Redis (auto-configured)
- S3 Storage (Minio or Garage instance required)
- Node.js 20
- Python 3.13

## 🐛 Troubleshooting

### Check Service Status
```bash
sudo systemctl status lasuite-drive
sudo journalctl -u lasuite-drive -n 50
```

### View Application Logs
```bash
sudo journalctl -u lasuite-drive -f  # Follow logs in real-time
```

### Verify Database
```bash
sudo -u postgres psql -l | grep lasuite_drive
```

### Check S3 Configuration
```bash
sudo cat /var/www/lasuite-drive/.env | grep AWS
```

## 🔄 Upgrade Path

When new versions of Drive are released:
1. Update version in `manifest.toml`
2. Update source URL and SHA256
3. Commit and push to testing branch
4. Test thoroughly
5. Merge to main when stable

## 📚 Resources

- **YunoHost Documentation**: https://doc.yunohost.org/
- **YunoHost App Packaging**: https://doc.yunohost.org/packaging_apps
- **Drive Repository**: https://github.com/suitenumerique/drive
- **La Suite Documentation**: https://docs.suitenumerique.org/

## 🎯 Next Steps

1. ✅ Package is complete and ready
2. 📤 Push to GitHub (optional)
3. 🧪 Test installation on a YunoHost server
4. 📸 Add screenshots to `doc/screenshots/`
5. 🎉 Deploy to YunoHost App Store

## 💡 Tips

- Keep `testing` branch for development
- Use `main` branch for stable releases
- Test on multiple YunoHost versions
- Maintain changelog in future releases
- Monitor upstream (Drive) for updates

---

For detailed technical information, see **IMPLEMENTATION_NOTES.md**
