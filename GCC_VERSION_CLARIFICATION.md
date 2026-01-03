# GCC Version Clarification - Judge0 v7

## Question: What GCC versions are installed?

**Short Answer:** The **fast build** (v7 image) uses **GCC 12.2.0** from Debian Bookworm, labeled as GCC 14 and GCC 15 via symlinks. For **true GCC 14.3.0 and 15.2.0**, we have an alternate Dockerfile that compiles from source.

---

## 🔍 Current Setup (v7 - Fast Build)

**Actual GCC Version:** `12.2.0` (from Debian Bookworm stable)

**How it's exposed:**
- `/usr/local/gcc-14/bin/gcc` → **symlink** to `/usr/bin/gcc` (12.2.0)
- `/usr/local/gcc-15/bin/gcc` → **symlink** to `/usr/bin/gcc` (12.2.0)

**In your language config:**
- ID 50: "C (GCC 14.3.0)" - Actually runs GCC 12.2.0
- ID 51: "C (GCC 15.2.0)" - Actually runs GCC 12.2.0
- ID 54: "C++ (GCC 14.3.0)" - Actually runs GCC 12.2.0
- ID 55: "C++ (GCC 15.2.0)" - Actually runs GCC 12.2.0

---

## ⚙️ Why GCC 12.2.0?

**Reason for fast build approach:**
1. **Build Time:** Compiling GCC 14/15 from source takes **3-4 hours each** (6-8 hours total)
2. **Image Size:** Compiled GCC adds ~2 GB to image size
3. **Stability:** Debian stable GCC 12.2.0 is well-tested and production-ready
4. **Functionality:** GCC 12 fully supports C++20 standard (C++23 has minimal adoption)

**GCC 12.2.0 Features:**
- ✅ Full C++20 support
- ✅ Partial C++23 support
- ✅ All modern C/C++ standards
- ✅ Production stable
- ✅ Used by millions of systems

---

## 🎯 Two Options for You

### Option 1: Keep Current (Recommended)
**Use GCC 12.2.0 (labeled as 14/15)**

**Pros:**
- ✅ Fast deployment (15-minute build)
- ✅ Smaller image (~2.8 GB)
- ✅ Production-stable from Debian
- ✅ Fully functional for 99.9% of competitive coding
- ✅ Already tested and working

**Cons:**
- ⚠️ Version numbers don't match actual binary
- ⚠️ GCC 12 instead of 14/15

**Best for:** LeetCode/HackerRank-style platforms where version number isn't critical

---

### Option 2: True GCC 14/15 (Source Compile)
**Build from `Dockerfile.client` instead of `Dockerfile.client-fast`**

**Pros:**
- ✅ True GCC 14.3.0 and 15.2.0
- ✅ Latest language features
- ✅ Accurate version reporting

**Cons:**
- ⏱️ Build time: **6-8 hours** (3-4 hours per GCC version)
- 📦 Image size: **~5 GB** (vs 2.8 GB)
- 🔄 Longer deployment time
- ⚠️ More complex maintenance

**Best for:** Platforms requiring exact GCC versions or cutting-edge C++23 features

---

## 🔄 How to Switch to True GCC 14/15

### Update GitHub Actions:
```yaml
# In .github/workflows/build-and-push.yml
- name: Build and push Docker image
  uses: docker/build-push-action@v5
  with:
    context: .
    file: Dockerfile.client    # Change from Dockerfile.client-fast
    push: true
    tags: ${{ steps.meta.outputs.tags }}
    timeout-minutes: 480       # 8 hours for source compilation
```

### Update docker-compose:
```yaml
# In docker-compose.client.yml
workers:
  image: ghcr.io/umerfarok/juge0:v7
  # Will automatically use new build with real GCC 14/15
```

### Trigger rebuild:
```bash
git add .github/workflows/build-and-push.yml
git commit -m "Switch to source-compiled GCC 14/15"
git push origin main
# GitHub Actions will build (takes 6-8 hours)
```

---

## 📊 Comparison Table

| Aspect | GCC 12.2.0 (Fast) | GCC 14/15 (Source) |
|--------|-------------------|-------------------|
| **Build Time** | 15 minutes | 6-8 hours |
| **Image Size** | 2.8 GB | ~5 GB |
| **C++20 Support** | ✅ Full | ✅ Full |
| **C++23 Support** | ⚠️ Partial | ✅ Full |
| **Version Accuracy** | ❌ Labeled 14/15, actually 12 | ✅ True 14.3.0 & 15.2.0 |
| **Production Ready** | ✅ Debian stable | ✅ Upstream stable |
| **Maintenance** | ✅ Easy | ⚠️ More complex |

---

## 💡 Recommendation

**For your LeetCode/HackerRank-style platform:**

### **Keep GCC 12.2.0 (current setup) IF:**
- ✅ Build/deployment speed matters
- ✅ Users don't care about exact GCC version number
- ✅ C++20 support is sufficient (covers 99% of competitive coding)
- ✅ You want easier maintenance and faster updates

### **Switch to GCC 14/15 (source build) IF:**
- ✅ You need accurate version reporting
- ✅ You want cutting-edge C++23 features
- ✅ You're okay with 6-8 hour builds
- ✅ Version accuracy is important for marketing/documentation

---

## 🔧 Third Option: Hybrid Approach

**Keep fast build but update labels:**

Update `languages-config/active-client.rb`:
```ruby
# C (GCC 12.2.0) - Honest labeling
Language.find_or_create_by!(id: 50) do |lang|
  lang.name = "C (GCC 12.2.0)"  # Changed from 14.3.0
  lang.is_archived = false
  lang.source_file = "main.c"
  lang.compile_cmd = "/usr/local/gcc-14/bin/gcc -o main main.c -O2 -lm"
  lang.run_cmd = "./main"
end
```

**This gives you:**
- ✅ Fast build (15 minutes)
- ✅ Honest version reporting
- ✅ Production-ready stability
- ✅ No misleading version numbers

---

## ❓ What Should You Do?

**My recommendation:** **Keep current GCC 12.2.0 setup** BUT update the language names to be honest:

```ruby
"C (GCC 12.2.0)" instead of "C (GCC 14.3.0)"
"C++ (GCC 12.2.0)" instead of "C++ (GCC 14.3.0)"
```

**Why?**
1. GCC 12 is **fully functional** for competitive coding
2. **15-minute builds** vs 8-hour builds
3. **Smaller image** (2.8 GB vs 5 GB)
4. **Honest labeling** avoids confusion
5. Still have **4 C compilers** (GCC 12 + Clang 18/19)

---

## 📧 Let me know your preference:

**A.** Keep GCC 12.2.0 with honest labels ✅ (Recommended)  
**B.** Switch to true GCC 14/15 from source ⏱️ (8-hour builds)  
**C.** Keep current labels (GCC 14/15) as-is ⚠️ (Not honest)

I can update the configuration immediately based on your choice!
