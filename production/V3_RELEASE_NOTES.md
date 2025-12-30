# Judge0 v3 Release Notes

## What's New in v3

**v3 now properly registers all upgraded language versions with the Judge0 API!**

The previous v2 image had the upgraded compilers installed (Java 21, Python 3.12, etc.) but they weren't registered in the language database, so the API couldn't use them. This has been fixed in v3.

## Updated Language Versions

All these languages now use their upgraded versions when you submit code via the API:

| Language ID | Language | Old Version (v2) | New Version (v3) |
|-------------|----------|------------------|------------------|
| **50** | C (GCC) | 9.2.0 | **11.5.0** ✨ |
| **51** | C# | Mono 6.6.0 | **.NET 8.0** ✨ |
| **54** | C++ (GCC) | 9.2.0 | **11.5.0** ✨ |
| **60** | Go | 1.13.5 | **1.23.4** ✨ |
| **62** | Java | OpenJDK 13.0.1 | **OpenJDK 21.0.5** ✨ |
| **63** | JavaScript | Node.js 12.14.0 | **Node.js 22.12.0** ✨ |
| **68** | PHP | 7.4.1 | **8.3.15** ✨ |
| **71** | Python | 3.8.1 | **3.12.8** ✨ |
| **72** | Ruby | 2.7.0 | **3.0.7** ✨ |
| **74** | TypeScript | 3.7.4 | **5.7.2** ✨ |
| **78** | Kotlin | 1.3.70 | **2.0.21** ✨ |
| **83** | Swift | 5.2.3 | **5.8.1** ✨ |

## How to Upgrade from v2 to v3

If you're already running v2, upgrading is simple:

```bash
# Stop the current containers
docker-compose down

# Pull the new v3 image
docker-compose pull

# Start with v3
docker-compose up -d
```

The `docker-compose.yml` file has already been updated to use `v3`.

## Testing the Upgrade

### 1. Check Available Languages
```bash
curl http://localhost:2358/languages | jq '.'
```

You should see the updated language versions in the response.

### 2. Test Java 21
```bash
curl -X POST "http://localhost:2358/submissions?base64_encoded=false&wait=true" \
  -H "Content-Type: application/json" \
  -d '{
    "source_code": "public class Main { public static void main(String[] args) { System.out.println(System.getProperty(\"java.version\")); } }",
    "language_id": 62
  }'
```

Expected output: `21.0.5`

### 3. Test Python 3.12
```bash
curl -X POST "http://localhost:2358/submissions?base64_encoded=false&wait=true" \
  -H "Content-Type: application/json" \
  -d '{
    "source_code": "import sys; print(sys.version)",
    "language_id": 71
  }'
```

Expected output should include `3.12.8`

### 4. Test Node.js 22
```bash
curl -X POST "http://localhost:2358/submissions?base64_encoded=false&wait=true" \
  -H "Content-Type: application/json" \
  -d '{
    "source_code": "console.log(process.version)",
    "language_id": 63
  }'
```

Expected output: `v22.12.0`

## Performance Testing

Now you can properly test the execution time and memory usage differences between versions!

Example test comparing performance:
```bash
# Test with time measurement
curl -X POST "http://localhost:2358/submissions?base64_encoded=false&wait=true" \
  -H "Content-Type: application/json" \
  -d '{
    "source_code": "import time; start = time.time(); sum(range(1000000)); print(f\"Execution time: {time.time() - start}s\")",
    "language_id": 71
  }' | jq '.time, .memory'
```

The response will show:
- `time`: Execution time in seconds
- `memory`: Memory usage in KB

## What Was Fixed

1. **Language Database Updated**: The `/api/db/languages/active.rb` file now points to the correct compiler paths
2. **Binary Paths Corrected**: 
   - Java: `/usr/bin/javac` and `/usr/bin/java` (Java 21)
   - Python: `/usr/bin/python3` (Python 3.12)
   - Node.js: `/usr/bin/node` (Node 22)
   - Go: `/usr/local/go/bin/go` (Go 1.23)
   - PHP: `/usr/local/bin/php` (PHP 8.3)
   - Swift: `/usr/bin/swiftc` (Swift 5.8)
   - .NET: `/usr/bin/dotnet` (.NET 8)

3. **No More Version Mismatch**: Previously, even though Java 21 was installed, the API was still calling Java 13 because the database wasn't updated.

## Troubleshooting

### If languages still show old versions:

```bash
# Check which image is actually running
docker ps

# Force pull the v3 image
docker pull ghcr.io/umerfarok/juge0:v3

# Restart everything
docker-compose down
docker-compose up -d
```

### Verify the image tag:
```bash
docker inspect judge0-production-v3-server-1 | grep Image
```

Should show: `"Image": "ghcr.io/umerfarok/juge0:v3"`

## Build Status

The v3 image is currently building in GitHub Actions. You can check the progress here:
https://github.com/umerfarok/juge0/actions

Once the build completes (usually 30-45 minutes), you can pull and deploy v3.

## Questions?

If you encounter any issues:
1. Check the container logs: `docker-compose logs -f server`
2. Verify the image tag: `docker-compose ps`
3. Test individual languages using the cURL examples above

---

**Note**: The v3 image maintains full backward compatibility with v2. All existing code submissions will continue to work, but will now use the upgraded compiler versions.
