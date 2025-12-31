#!/bin/bash

# Judge0 v6 Verification Script
# Run this after deploying the v6 image to verify everything is correct

set -e

echo "========================================"
echo "   Judge0 v6 Verification Script"
echo "========================================"
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if running in production directory
if [ ! -f "docker-compose.yml" ]; then
    echo -e "${RED}❌ Error: Please run this script from the production directory${NC}"
    exit 1
fi

echo "Step 1: Pulling latest v6 image..."
docker pull ghcr.io/umerfarok/juge0:v6

echo ""
echo "Step 2: Restarting containers..."
docker-compose down
docker-compose up -d

echo ""
echo "Step 3: Waiting for services to start (30 seconds)..."
sleep 30

echo ""
echo "========================================"
echo "   Compiler Versions"
echo "========================================"

# Check GCC
echo -n "GCC: "
GCC_VERSION=$(docker exec production-server-1 /usr/local/gcc-14/bin/gcc --version 2>/dev/null | head -1)
if echo "$GCC_VERSION" | grep -q "14.2.0"; then
    echo -e "${GREEN}✅ $GCC_VERSION${NC}"
else
    echo -e "${RED}❌ Expected GCC 14.2.0, got: $GCC_VERSION${NC}"
fi

# Check G++
echo -n "G++: "
GPP_VERSION=$(docker exec production-server-1 /usr/local/gcc-14/bin/g++ --version 2>/dev/null | head -1)
if echo "$GPP_VERSION" | grep -q "14.2.0"; then
    echo -e "${GREEN}✅ $GPP_VERSION${NC}"
else
    echo -e "${RED}❌ Expected G++ 14.2.0, got: $GPP_VERSION${NC}"
fi

# Check Java
echo -n "Java: "
JAVA_VERSION=$(docker exec production-server-1 /usr/local/openjdk-23/bin/java -version 2>&1 | head -1)
if echo "$JAVA_VERSION" | grep -q "23"; then
    echo -e "${GREEN}✅ $JAVA_VERSION${NC}"
else
    echo -e "${RED}❌ Expected Java 23, got: $JAVA_VERSION${NC}"
fi

# Check Python
echo -n "Python: "
PYTHON_VERSION=$(docker exec production-server-1 /usr/local/python-3.13/bin/python3.13 --version 2>/dev/null)
if echo "$PYTHON_VERSION" | grep -q "3.13"; then
    echo -e "${GREEN}✅ $PYTHON_VERSION${NC}"
else
    echo -e "${RED}❌ Expected Python 3.13, got: $PYTHON_VERSION${NC}"
fi

# Check Node.js
echo -n "Node.js: "
NODE_VERSION=$(docker exec production-server-1 node --version 2>/dev/null)
if echo "$NODE_VERSION" | grep -q "v23"; then
    echo -e "${GREEN}✅ $NODE_VERSION${NC}"
else
    echo -e "${RED}❌ Expected Node.js 23, got: $NODE_VERSION${NC}"
fi

# Check Go
echo -n "Go: "
GO_VERSION=$(docker exec production-server-1 /usr/local/go-1.23/bin/go version 2>/dev/null)
if echo "$GO_VERSION" | grep -q "go1.23"; then
    echo -e "${GREEN}✅ $GO_VERSION${NC}"
else
    echo -e "${RED}❌ Expected Go 1.23, got: $GO_VERSION${NC}"
fi

# Check PHP
echo -n "PHP: "
PHP_VERSION=$(docker exec production-server-1 /usr/local/php-8.4/bin/php --version 2>/dev/null | head -1)
if echo "$PHP_VERSION" | grep -q "8.4"; then
    echo -e "${GREEN}✅ $PHP_VERSION${NC}"
else
    echo -e "${RED}❌ Expected PHP 8.4, got: $PHP_VERSION${NC}"
fi

# Check Ruby
echo -n "Ruby: "
RUBY_VERSION=$(docker exec production-server-1 /usr/local/ruby-3.3/bin/ruby --version 2>/dev/null)
if echo "$RUBY_VERSION" | grep -q "3.3"; then
    echo -e "${GREEN}✅ $RUBY_VERSION${NC}"
else
    echo -e "${RED}❌ Expected Ruby 3.3, got: $RUBY_VERSION${NC}"
fi

# Check Rust
echo -n "Rust: "
RUST_VERSION=$(docker exec production-server-1 /root/.cargo/bin/rustc --version 2>/dev/null)
if echo "$RUST_VERSION" | grep -q "1.83"; then
    echo -e "${GREEN}✅ $RUST_VERSION${NC}"
else
    echo -e "${YELLOW}⚠️  Expected Rust 1.83, got: $RUST_VERSION${NC}"
fi

echo ""
echo "========================================"
echo "   Old Compiler Cleanup Check"
echo "========================================"

# Check old GCC versions are removed
echo -n "GCC 7.4 removal: "
if docker exec production-server-1 ls /usr/local/gcc-7.4.0 2>/dev/null; then
    echo -e "${RED}❌ GCC 7.4 still exists${NC}"
else
    echo -e "${GREEN}✅ Removed${NC}"
fi

echo -n "GCC 8.3 removal: "
if docker exec production-server-1 ls /usr/local/gcc-8.3.0 2>/dev/null; then
    echo -e "${RED}❌ GCC 8.3 still exists${NC}"
else
    echo -e "${GREEN}✅ Removed${NC}"
fi

echo -n "GCC 9.2 removal: "
if docker exec production-server-1 ls /usr/local/gcc-9.2.0 2>/dev/null; then
    echo -e "${RED}❌ GCC 9.2 still exists${NC}"
else
    echo -e "${GREEN}✅ Removed${NC}"
fi

echo ""
echo "========================================"
echo "   New Compiler Installation Check"
echo "========================================"

echo -n "GCC 14 directory: "
if docker exec production-server-1 ls /usr/local/gcc-14 2>/dev/null > /dev/null; then
    echo -e "${GREEN}✅ Exists${NC}"
else
    echo -e "${RED}❌ Not found${NC}"
fi

echo -n "Java 23 directory: "
if docker exec production-server-1 ls /usr/local/openjdk-23 2>/dev/null > /dev/null; then
    echo -e "${GREEN}✅ Exists${NC}"
else
    echo -e "${RED}❌ Not found${NC}"
fi

echo -n "Python 3.13 directory: "
if docker exec production-server-1 ls /usr/local/python-3.13 2>/dev/null > /dev/null; then
    echo -e "${GREEN}✅ Exists${NC}"
else
    echo -e "${RED}❌ Not found${NC}"
fi

echo ""
echo "========================================"
echo "   API Endpoint Tests"
echo "========================================"

# Test language endpoint
echo -n "Testing /languages endpoint: "
LANG_RESPONSE=$(curl -s http://localhost:2358/languages 2>/dev/null)
if [ ! -z "$LANG_RESPONSE" ]; then
    echo -e "${GREEN}✅ Responding${NC}"
else
    echo -e "${RED}❌ Not responding${NC}"
fi

# Test specific language - C (ID 50)
echo -n "Testing C (GCC 14) - Language ID 50: "
C_LANG=$(curl -s http://localhost:2358/languages/50 2>/dev/null)
if echo "$C_LANG" | grep -q "gcc-14"; then
    echo -e "${GREEN}✅ Correct path${NC}"
else
    echo -e "${RED}❌ Incorrect path${NC}"
fi

# Test specific language - C++ (ID 54)
echo -n "Testing C++ (GCC 14) - Language ID 54: "
CPP_LANG=$(curl -s http://localhost:2358/languages/54 2>/dev/null)
if echo "$CPP_LANG" | grep -q "gcc-14"; then
    echo -e "${GREEN}✅ Correct path${NC}"
    # Show the full config for debugging
    echo "    Config: $(echo $CPP_LANG | grep -o '"compile_cmd":"[^"]*"')"
else
    echo -e "${RED}❌ Incorrect path${NC}"
    echo "    Got: $CPP_LANG"
fi

# Test Java (ID 62)
echo -n "Testing Java 23 - Language ID 62: "
JAVA_LANG=$(curl -s http://localhost:2358/languages/62 2>/dev/null)
if echo "$JAVA_LANG" | grep -q "openjdk-23"; then
    echo -e "${GREEN}✅ Correct path${NC}"
else
    echo -e "${RED}❌ Incorrect path${NC}"
fi

echo ""
echo "========================================"
echo "   Test Submission (C Hello World)"
echo "========================================"

# Create a test submission
TEST_CODE=$(cat <<EOF
#include <stdio.h>
int main() {
    printf("Judge0 v6 Works!\\n");
    return 0;
}
EOF
)

SUBMISSION=$(curl -s -X POST "http://localhost:2358/submissions/?base64_encoded=false&wait=true" \
    -H "Content-Type: application/json" \
    -d "{
        \"language_id\": 50,
        \"source_code\": \"$TEST_CODE\"
    }")

echo -n "C compilation and execution: "
if echo "$SUBMISSION" | grep -q "Judge0 v6 Works"; then
    echo -e "${GREEN}✅ Success${NC}"
    echo "    Output: $(echo $SUBMISSION | grep -o '"stdout":"[^"]*"' | cut -d'"' -f4)"
else
    echo -e "${RED}❌ Failed${NC}"
    echo "    Response: $SUBMISSION"
fi

echo ""
echo "========================================"
echo "   Summary"
echo "========================================"
echo ""
echo "If all checks show ✅, your Judge0 v6 deployment is successful!"
echo ""
echo "Expected results:"
echo "  - All compilers show latest versions"
echo "  - Old GCC 7, 8, 9 are removed"
echo "  - New compiler directories exist"
echo "  - API returns correct paths with gcc-14, openjdk-23, etc."
echo "  - Test submissions execute successfully"
echo ""
echo "If you see any ❌, please check:"
echo "  1. Did you pull the correct image? (ghcr.io/umerfarok/juge0:v6)"
echo "  2. Did docker-compose.yml update correctly?"
echo "  3. Are containers using the new image?"
echo ""
echo "Run 'docker images | grep juge0' to verify image tag"
echo "Run 'docker-compose config' to verify configuration"
echo ""
echo "========================================"
