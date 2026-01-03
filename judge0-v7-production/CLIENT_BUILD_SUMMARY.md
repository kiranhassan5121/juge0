# Judge0 Custom Compilers - Client Build Summary

## Overview

This document summarizes the custom Judge0 compilers image built for your LeetCode/HackerRank-style competitive coding platform.

## 23 Language Entries

| ID | Language | Version | Compiler Path |
|----|----------|---------|---------------|
| 50 | C (GCC 14) | 14.3.0 | `/usr/local/gcc-14/bin/gcc` |
| 51 | C (GCC 15) | 15.2.0 | `/usr/local/gcc-15/bin/gcc` |
| 52 | C (Clang 19) | 19.1.7 | `/usr/local/clang-19/bin/clang` |
| 53 | C (Clang 20) | 20.1.8 | `/usr/local/clang-20/bin/clang` |
| 54 | C++ (GCC 14) | 14.3.0 | `/usr/local/gcc-14/bin/g++` |
| 55 | C++ (GCC 15) | 15.2.0 | `/usr/local/gcc-15/bin/g++` |
| 56 | C++ (Clang 19) | 19.1.7 | `/usr/local/clang-19/bin/clang++` |
| 57 | C++ (Clang 20) | 20.1.8 | `/usr/local/clang-20/bin/clang++` |
| 60 | Python | 2.7.18 | `/usr/local/python-2.7/bin/python2.7` |
| 61 | Python | 3.11.14 | `/usr/local/python-3.11/bin/python3.11` |
| 62 | Python | 3.14.2 | `/usr/local/python-3.14/bin/python3.14` |
| 63 | Java | JDK 25.0.1 | `/usr/local/jdk-25/bin/java` |
| 64 | Go | 1.25.4 | `/usr/local/go-1.25.4/bin/go` |
| 65 | Rust | 1.89.0 | `/usr/local/rust-1.89.0/bin/rustc` |
| 66 | Ruby | 2.7.8 | `/usr/local/ruby-2.7/bin/ruby` |
| 67 | Ruby | 3.4.7 | `/usr/local/ruby-3.4/bin/ruby` |
| 68 | Kotlin | 2.3.0 | `/usr/local/kotlin-2.3.0/bin/kotlinc` |
| 69 | PHP | 8.2.30 | `/usr/local/php-8.2/bin/php` |
| 70 | PHP | 8.5.1* | `/usr/local/php-8.5/bin/php` |
| 71 | JavaScript | Node.js 22.21.1 | `/usr/local/node-22/bin/node` |
| 72 | JavaScript | Node.js 24.12.0 | `/usr/local/node-24/bin/node` |
| 73 | TypeScript | 5.7.3 | `/usr/local/node-22/bin/tsc` |
| 74 | TypeScript | 5.9.3 | `/usr/local/node-24/bin/tsc` |

> *PHP 8.5.1 is not yet released, using PHP 8.4.3 (latest stable) with the 8.5 path for future compatibility.

## Files Created

1. **Dockerfile.client-fast** - Docker build file using pre-built binaries (faster build)
2. **Dockerfile.client** - Docker build file compiling GCC from source (slower but exact versions)
3. **languages-config/active-client.rb** - Judge0 language configuration
4. **docker-compose.client.yml** - Production deployment configuration
5. **test-client-image.ps1** - Test script to verify all languages

## Quick Start

### Build the Image Locally

```bash
# Fast build (uses system GCC + Clang from LLVM apt repo)
docker build -f Dockerfile.client-fast -t judge0-client:latest .

# Full build (compiles GCC 14/15 from source - takes hours)
docker build -f Dockerfile.client -t judge0-client:latest .
```

### Test the Image

```bash
# Check all compiler versions
docker run --rm judge0-client:latest

# Run test script (PowerShell)
.\test-client-image.ps1
```

### Deploy with Docker Compose

```bash
# Start all services
docker-compose -f docker-compose.client.yml up -d

# Check logs
docker-compose -f docker-compose.client.yml logs -f

# Stop services
docker-compose -f docker-compose.client.yml down
```

## API Endpoints

Once deployed, the Judge0 API is available at `http://localhost:2358`:

```bash
# Get available languages
curl http://localhost:2358/languages

# Submit code execution
curl -X POST http://localhost:2358/submissions \
  -H "Content-Type: application/json" \
  -d '{
    "source_code": "print(\"Hello World\")",
    "language_id": 61
  }'
```

## Version Verification

After building, verify all versions are correct:

```bash
docker run --rm judge0-client:latest /usr/local/bin/check-versions.sh
```

## Notes

- Base image: `buildpack-deps:bookworm` (Debian 12)
- All languages installed in `/usr/local/` with clear paths
- C++20/C++23 standards supported
- Ruby 2.7 included for Judge0 API compatibility
- TypeScript runs on respective Node.js versions

## Image Size

Expected final image size: ~3-4 GB (includes all compilers and runtimes)

## Push to Registry

```bash
# Tag for GitHub Container Registry
docker tag judge0-client:latest ghcr.io/umerfarok/judge0-client:latest

# Push
docker push ghcr.io/umerfarok/judge0-client:latest
```
