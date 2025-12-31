# Judge0 v6 - Latest Stable Compilers

**Production Ready** | All old compiler versions removed, only latest stable releases included

## Quick Start

1. Install Docker Desktop (Windows/Mac) or Docker Engine (Linux)
2. Open terminal in this folder
3. Run: `docker-compose up -d`
4. Access API at: http://localhost:2358

## Latest Compiler Versions

| Language | Version | Language ID | Release Date |
|----------|---------|-------------|--------------|
| **GCC (C)** | 14.2.0 | 50 | Aug 2024 |
| **G++ (C++)** | 14.2.0 | 54 | Aug 2024 |
| **Java** | OpenJDK 23 | 62 | Sept 2024 |
| **Python** | 3.13.1 | 71 | Dec 2024 |
| **Node.js** | 23.5.0 | 63 | Dec 2024 |
| **TypeScript** | 5.7.2 | 74 | Dec 2024 |
| **PHP** | 8.4.2 | 68 | Nov 2024 |
| **Go** | 1.23.4 | 60 | Dec 2024 |
| **Kotlin** | 2.1.0 | 78 | Nov 2024 |
| **Swift** | 6.0.3 | 83 | Dec 2024 |
| **Rust** | 1.83.0 | 73 | Nov 2024 |
| **Ruby** | 3.3.6 | 72 | Nov 2024 |

> ⚠️ **Note:** Java 25 doesn't exist yet. Latest stable is **Java 23** (LTS is Java 21).

## What Changed from v5

**REMOVED:**
- All old GCC versions (7.4, 8.3, 9.2) - **only GCC 14 now**
- Old Java 13, Python 3.8, Node 12, PHP 7.4, Ruby 2.7

**UPGRADED:**
- C/C++ from GCC 9.2 → **GCC 14.2**
- Java from 21 → **Java 23**
- Python from 3.12 → **Python 3.13**
- Node.js from 22 → **Node 23**
- PHP from 8.3 → **PHP 8.4**
- Go from 1.13 → **Go 1.23**
- Kotlin from 2.0 → **Kotlin 2.1**
- Swift from 5.8 → **Swift 6.0**
- Rust from 1.40 → **Rust 1.83**
- Ruby from 2.7 → **Ruby 3.3**

## Installation

1. Extract this folder to any location on your machine

2. Open a terminal in this folder and run:
   ```bash
   docker-compose up -d
   ```

3. Wait 30 seconds for services to start

4. Test: http://localhost:2358/docs

## Testing

Test all 12 languages:
```powershell
# PowerShell (Windows) - in parent folder
..\test-v6.ps1

# Bash (Linux/Mac)
bash ../test-v6.sh
```

Test single language:
```bash
curl -X POST http://localhost:2358/submissions?wait=true \
  -H "Content-Type: application/json" \
  -d '{
    "source_code": "print(\"Hello from Python 3.13\")",
    "language_id": 71
  }'
```

## What's Included

Upgraded compiler versions:
- **GCC 14.2** (C/C++) - fastest execution
- **Java 23** - latest stable (not 25, doesn't exist)
- **Python 3.13** - latest with performance improvements
- **Node.js 23** - latest current release
- **Go 1.23** - near-C performance
- **PHP 8.4, Kotlin 2.1, Swift 6.0, Rust 1.83, Ruby 3.3**

## Configuration

Edit `judge0.conf` if you need to change:
- Database password
- Redis password
- Resource limits
- Time limits

After editing, restart:
```bash
docker-compose restart
```

## Stopping

```bash
docker-compose down
```

## Troubleshooting

**Services won't start?**
- Make sure Docker is running
- Check ports 2358 isn't already in use

**Can't access API?**
- Wait 30-60 seconds after starting
- Check logs: `docker-compose logs -f server`

**Need to reset everything?**
```bash
docker-compose down -v
docker-compose up -d
```
