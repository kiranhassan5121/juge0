# Judge0 Setup Instructions

This package contains everything you need to run Judge0 with upgraded compilers.

## What You Need

- Docker Desktop (Windows/Mac) or Docker Engine (Linux)

## Installation

1. Extract this folder to any location on your machine

2. Open a terminal in this folder and run:
   ```bash
   docker-compose up -d
   ```

3. Wait about 30 seconds for everything to start, then check:
   ```bash
   docker-compose ps
   ```
   All services should show "Up"

4. Open your browser to http://localhost:2358/docs

## What's Included

Upgraded compiler versions:
- Java 21 (was OpenJDK 13)
- Python 3.12 (was 3.8)
- Node.js 22 (was 12)
- PHP 8.3 (was 7.4)
- Swift 5.8 (was 5.2)
- Plus all standard Judge0 languages

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
