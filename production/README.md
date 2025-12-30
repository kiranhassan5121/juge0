# Judge0 Production Deployment

## Quick Start

```bash
docker-compose up -d
docker-compose ps
```

API will be at: http://localhost:2358

## Languages

### Upgraded Versions
- Java: OpenJDK 21 (ID: 62)
- Python: 3.12 (ID: 71)
- JavaScript: Node.js 22 (ID: 63)
- PHP: 8.3 (ID: 68)
- Swift: 5.8 (ID: 83)

### Standard Languages
C, C++, C#, Go, Kotlin, Ruby, TypeScript, and 40+ others

Get full list: `curl http://localhost:2358/languages`

## Testing

```bash
# Test Java 21
curl -X POST "http://localhost:2358/submissions?base64_encoded=false&wait=true" \
  -H "Content-Type: application/json" \
  -d '{
    "source_code": "public class Main { public static void main(String[] args) { System.out.println(\"Hello\"); } }",
    "language_id": 62
  }'

# Test Python 3.12
curl -X POST "http://localhost:2358/submissions?base64_encoded=false&wait=true" \
  -H "Content-Type: application/json" \
  -d '{
    "source_code": "print(\"Hello\")",
    "language_id": 71
  }'
```

## Security

Before deploying to production:

1. Change passwords in `judge0.conf`:
   - POSTGRES_PASSWORD
   - REDIS_PASSWORD
   - SECRET_KEY_BASE

2. Consider adding API authentication:
   ```
   AUTHN_HEADER=X-Auth-Token
   AUTHN_TOKEN=your-secret-token
   ```

## Maintenance

```bash
# View logs
docker-compose logs -f server

# Restart services
docker-compose restart

# Stop everything
docker-compose down

# Update image
docker-compose pull
docker-compose up -d
```
