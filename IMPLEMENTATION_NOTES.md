# La Suite - Drive YunoHost Package Implementation Notes

## Overview
This is a YunoHost package for La Suite - Drive, a secure, collaborative file storage and sharing application.

## Package Structure
```
.
├── manifest.toml               # Package metadata and configuration
├── conf/                       # Configuration templates
│   ├── config_panel.toml      # Web UI configuration panel
│   ├── env                    # Environment variables template
│   ├── nginx.conf             # Nginx proxy configuration
│   └── systemd.service        # Systemd service file
├── scripts/                   # Installation/management scripts
│   ├── _common.sh            # Common helper functions
│   ├── install               # Installation script
│   ├── remove                # Removal script
│   ├── restore               # Restore from backup
│   ├── upgrade               # Upgrade script
│   ├── backup                # Backup creation
│   ├── change_url            # Handle domain/path changes
│   └── config                # Configuration script
├── tests.toml                # Test scenarios
├── README.md                 # Documentation
├── LICENSE                   # License
└── doc/                      # Documentation directory
```

## Key Features
- Multi-instance support
- PostgreSQL database
- Redis caching
- S3 storage integration (Minio/Garage)
- Django backend
- Next.js frontend
- Mail service support
- Systemd service management
- Nginx reverse proxy

## Installation Requirements
Before installing, you need:
1. A YunoHost instance (v12.1.17 or later)
2. At least one S3 storage service (Minio or Garage) installed
3. PostgreSQL support (included)
4. Redis support (included)
5. 2000MB disk space for installation
6. 2000MB RAM for build
7. 400MB RAM for runtime

## Configuration
The application is configured through:
1. Environment variables (`conf/env` template)
2. Nginx proxy configuration (`conf/nginx.conf`)
3. Systemd service (`conf/systemd.service`)
4. Runtime config panel (`conf/config_panel.toml`)

## Build Process
During installation, the script:
1. Creates Python virtual environment
2. Installs Django backend dependencies
3. Builds mail service
4. Collects static files
5. Compiles translations
6. Builds Next.js frontend
7. Sets up database
8. Configures Nginx and Systemd

## Differences from La Suite - Docs
- Simpler authentication model (no mandatory Dex/OIDC)
- Different frontend (Next.js app vs. Impress)
- No Y-provider collaboration server requirement
- Simplified frontend serving (no separate y-provider service)

## Known Limitations
- Garage S3 support is noted as "not yet supported" (similar to docs package)
- Frontend build may take significant time on slower servers
- Celery workers not yet integrated (can be added in future versions)

## Testing
Run tests with:
```
# From YunoHost server
sudo yunohost app install https://github.com/YunoHost-Apps/lasuite-drive_ynh/tree/testing
sudo yunohost app upgrade lasuite-drive -u https://github.com/YunoHost-Apps/lasuite-drive_ynh/tree/testing
```

## Future Enhancements
1. Celery worker support for background tasks
2. Garage S3 backend support
3. Optional Dex/OIDC authentication
4. Email configuration in web UI
5. Additional language support

## Troubleshooting
### Service won't start
- Check logs: `sudo journalctl -u lasuite-drive`
- Verify PostgreSQL is running: `sudo systemctl status postgresql`
- Verify Redis is running: `sudo systemctl status redis-server`
- Check S3 credentials: `sudo cat /var/www/lasuite-drive/.env | grep AWS`

### Build failures
- Ensure sufficient disk space
- Check Node.js version: `node --version` (should be 20+)
- Check Python version: `python3 --version` (should be 3.10+)

### Database issues
- Check permissions: `sudo -u postgres psql -l | grep lasuite_drive`
- Reset database: Run migrations again if schema changed
