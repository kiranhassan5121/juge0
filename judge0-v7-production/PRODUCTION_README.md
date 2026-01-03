# Judge0 v7 Production Deployment

## 📦 Quick Deployment Guide

This package contains everything needed to deploy Judge0 with 23 language versions to your production server.

## 📋 Contents

```
judge0-production/
├── docker-compose.client.yml    # Main deployment configuration
├── .env.example                  # Environment variables template
├── languages-config/
│   └── active-client.rb         # All 23 language definitions
├── CLIENT_DELIVERY.md           # Comprehensive delivery notes
├── CLIENT_BUILD_SUMMARY.md      # Build documentation
├── test-all-languages.sh        # Test suite
└── README.md                    # This file
```

## 🚀 Deployment Steps

### 1. **Setup Environment**
```bash
# Copy environment template
cp .env.example .env

# Edit with your secure passwords
nano .env
```

**Required changes in `.env`:**
- `AUTHN_TOKEN` - Your API authentication token
- `AUTHZ_TOKEN` - Your API authorization token  
- `POSTGRES_PASSWORD` - Database password
- `REDIS_PASSWORD` - Redis password

### 2. **Pull Docker Image**
```bash
docker pull ghcr.io/umerfarok/juge0:v7
```

### 3. **Start Services**
```bash
docker-compose -f docker-compose.client.yml up -d
```

### 4. **Verify Deployment**
```bash
# Check all services are running
docker-compose -f docker-compose.client.yml ps

# Test API
curl http://localhost:2358/languages

# View logs
docker-compose -f docker-compose.client.yml logs -f
```

## 🔍 Testing

### Test All 23 Languages
```bash
# Make test script executable
chmod +x test-all-languages.sh

# Run comprehensive tests
docker run --rm -v "${PWD}/test-all-languages.sh:/tmp/test.sh" \
  ghcr.io/umerfarok/juge0:v7 bash /tmp/test.sh
```

### Test Individual Language
```bash
# Example: Python 3.11 (language_id: 61)
curl -X POST http://localhost:2358/submissions \
  -H "Content-Type: application/json" \
  -H "X-Auth-Token: your-token-here" \
  -d '{
    "source_code": "print(\"Hello from Python 3.11!\")",
    "language_id": 61
  }'
```

## 🌐 API Endpoints

Once deployed, the API is available at `http://your-server:2358`:

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/languages` | GET | List all 23 available languages |
| `/submissions` | POST | Submit code for execution |
| `/submissions/:token` | GET | Get submission result |
| `/about` | GET | Get Judge0 version info |

## 📊 Available Languages

**IDs 50-74** (23 total):
- C: GCC 14, GCC 15, Clang 18, Clang 19
- C++: GCC 14, GCC 15, Clang 18, Clang 19  
- Python: 2.7.18, 3.11.14, 3.14.2
- Java: JDK 25
- Go: 1.25.4
- Rust: 1.89.0
- Ruby: 3.2.8, 3.4.7
- Kotlin: 2.3.0
- PHP: 8.2.30, 8.4.3
- Node.js: 22.21.1, 24.12.0
- TypeScript: 5.7.3, 5.9.3

## 🔧 Configuration

### Scale Workers
Edit `.env`:
```bash
WORKER_COUNT=8  # Increase for higher load
```

Then restart:
```bash
docker-compose -f docker-compose.client.yml up -d --scale workers=8
```

### Adjust Resource Limits
Edit `.env`:
```bash
CPU_TIME_LIMIT=10        # Seconds
MEMORY_LIMIT=512000      # KB (512 MB)
MAX_QUEUE_SIZE=200       # Concurrent submissions
```

### Custom Port
Edit `.env`:
```bash
JUDGE0_PORT=8080  # Change from default 2358
```

## 🛠️ Maintenance

### View Logs
```bash
# All services
docker-compose -f docker-compose.client.yml logs -f

# Specific service
docker-compose -f docker-compose.client.yml logs -f workers
```

### Restart Services
```bash
docker-compose -f docker-compose.client.yml restart
```

### Update to Latest Image
```bash
docker-compose -f docker-compose.client.yml pull
docker-compose -f docker-compose.client.yml up -d
```

### Backup Database
```bash
docker exec judge0-db pg_dump -U judge0 judge0 > backup.sql
```

### Stop Services
```bash
docker-compose -f docker-compose.client.yml down
```

## 🆘 Troubleshooting

### Services Won't Start
```bash
# Check Docker is running
docker ps

# Check logs for errors
docker-compose -f docker-compose.client.yml logs
```

### API Returns 503
```bash
# Check workers are running
docker-compose -f docker-compose.client.yml ps workers

# Restart workers
docker-compose -f docker-compose.client.yml restart workers
```

### Database Connection Failed
```bash
# Check database is running
docker-compose -f docker-compose.client.yml ps db

# Check password in .env matches docker-compose.client.yml
cat .env | grep POSTGRES_PASSWORD
```

## 📈 Performance

**Recommended Server Specs:**
- CPU: 4+ cores
- RAM: 8+ GB
- Disk: 20+ GB SSD
- Network: 100+ Mbps

**Scaling Guidelines:**
- 1-100 submissions/min: 2-4 workers
- 100-500 submissions/min: 4-8 workers
- 500+ submissions/min: 8+ workers + load balancer

## 🔒 Security

**Important:**
1. Change all default passwords in `.env`
2. Enable firewall on port 2358
3. Use reverse proxy (nginx) with SSL
4. Implement rate limiting
5. Monitor resource usage

## 📞 Support

- **GitHub**: https://github.com/umerfarok/juge0
- **Issues**: https://github.com/umerfarok/juge0/issues
- **Docker Image**: ghcr.io/umerfarok/juge0:v7

## ✅ Version Info

- **Version**: v7
- **Base Image**: buildpack-deps:bookworm (Debian 12)
- **Judge0 Core**: 1.13.1
- **Docker Compose**: 3.8+
- **Build Date**: January 2026

---

**Ready for production!** 🎉

For detailed information, see `CLIENT_DELIVERY.md`
