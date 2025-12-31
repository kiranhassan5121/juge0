# Judge0 v6 - Latest Compilers (December 2025)

## Problem Fixed

Your client was seeing old GCC versions (7.4, 8.3, 9.2) because the v6 Docker image was never built.

## Solution

Updated `Dockerfile.latest` and `languages-config/active-latest.rb` with the **actual latest versions as of December 31, 2025**:

| Language | Version | Client Requested |
|----------|---------|-----------------|
| **GCC/G++** | 14.3.0 | ✅ (wanted 14+) |
| **Java** | 25 (LTS) | ✅ (wanted 25) |
| **Python** | 3.14.2 | ✅ (latest) |
| **Node.js** | 24.12.0 (LTS) | ✅ (latest) |
| **Go** | 1.25.6 | ✅ (latest) |
| **PHP** | 8.5.1 | ✅ (latest) |
| **Kotlin** | 2.3.0 | ✅ (latest) |
| **Rust** | 1.92.0 | ✅ (latest) |
| **Ruby** | 4.0.0 | ✅ (latest) |

**Total:** 10 languages (C, C++, Java, Python, JS, PHP, Go, Kotlin, Rust, Ruby)

**Removed:** Swift, TypeScript (client wanted max 10 languages)
**Removed old versions:** GCC 7.4, 8.3, 9.2 deleted

## Next Steps

### 1. Push to GitHub (2 min)
```bash
git add .
git commit -m "v6: Latest stable compilers Dec 2025 - GCC 15.2, Java 25, Python 3.14, etc."
git push origin main
```

### 2. Wait for Build (~2 hours, automated)
GitHub Actions will build the image automatically. Monitor at:
https://github.com/umerfarok/juge0/actions

### 3. Client Tests
```bash
docker pull ghcr.io/umerfarok/juge0:v6
cd production
docker-compose down
docker-compose up -d

# Verify
bash ../verify-v6.sh
```

## Expected Results

After deployment:
```bash
# Inside container should show:
gcc --version     # GCC 15.2.0
java -version     # Java 25
python3.14 --version  # Python 3.14.2

# API endpoint should show:
curl http://localhost:2358/languages/54
{
  "name": "C++ (GCC 15.2.0)",
  "compile_cmd": "/usr/local/gcc-15/bin/g++ %s main.cpp"
}

# Old versions should be gone:
ls /usr/local/gcc-7* # Not found ✅
ls /usr/local/gcc-8* # Not found ✅
ls /usr/local/gcc-9* # Not found ✅
```

## Files Changed
- `Dockerfile.latest` - All versions updated to Dec 2025 latest
- `languages-config/active-latest.rb` - 10 languages, Swift/TypeScript removed
- `verify-v6.sh` - Test script for client

Ready to build! 🚀
