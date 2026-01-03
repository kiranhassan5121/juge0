#!/bin/bash
set -e

echo "=============================================="
echo "JUDGE0 CLIENT IMAGE - COMPREHENSIVE TEST"
echo "=============================================="
echo ""

# Test 1: GCC 14 (C)
echo "=== TEST 1: GCC 14 (C) ==="
cat > /tmp/test_gcc14.c << 'CEOF'
#include <stdio.h>
int main() { 
    printf("Hello from GCC 14!\n"); 
    return 0; 
}
CEOF
/usr/local/gcc-14/bin/gcc /tmp/test_gcc14.c -o /tmp/test_gcc14 && /tmp/test_gcc14
echo ""

# Test 2: GCC 15 (C++)
echo "=== TEST 2: GCC 15 (C++) ==="
cat > /tmp/test_gpp15.cpp << 'CPPEOF'
#include <iostream>
int main() { 
    std::cout << "Hello from GCC 15 C++!" << std::endl; 
    return 0; 
}
CPPEOF
/usr/local/gcc-15/bin/g++ /tmp/test_gpp15.cpp -o /tmp/test_gpp15 && /tmp/test_gpp15
echo ""

# Test 3: Clang 18 (C)
echo "=== TEST 3: Clang 18 (C) ==="
cat > /tmp/test_clang18.c << 'CLEOF'
#include <stdio.h>
int main() { 
    printf("Hello from Clang 18!\n"); 
    return 0; 
}
CLEOF
/usr/local/clang-18/bin/clang /tmp/test_clang18.c -o /tmp/test_clang18 && /tmp/test_clang18
echo ""

# Test 4: Clang 19 (C++)
echo "=== TEST 4: Clang 19 (C++) ==="
cat > /tmp/test_clang19.cpp << 'CL19EOF'
#include <iostream>
int main() { 
    std::cout << "Hello from Clang 19 C++!" << std::endl; 
    return 0; 
}
CL19EOF
/usr/local/clang-19/bin/clang++ /tmp/test_clang19.cpp -o /tmp/test_clang19 && /tmp/test_clang19
echo ""

# Test 5: Python 2.7
echo "=== TEST 5: Python 2.7 ==="
/usr/local/python-2.7/bin/python2.7 << 'PY27EOF'
print "Hello from Python 2.7!"
print "2 + 3 =", 2 + 3
PY27EOF
echo ""

# Test 6: Python 3.11
echo "=== TEST 6: Python 3.11 ==="
/usr/local/python-3.11/bin/python3.11 << 'PY311EOF'
print("Hello from Python 3.11!")
def fib(n):
    if n <= 1: return n
    return fib(n-1) + fib(n-2)
print(f"fib(10) = {fib(10)}")
PY311EOF
echo ""

# Test 7: Python 3.14
echo "=== TEST 7: Python 3.14 ==="
/usr/local/python-3.14/bin/python3.14 << 'PY314EOF'
print("Hello from Python 3.14!")
import sys
print(f"Python version: {sys.version}")
PY314EOF
echo ""

# Test 8: Java 25
echo "=== TEST 8: Java 25 ==="
cat > /tmp/HelloJava.java << 'JAVAEOF'
public class HelloJava {
    public static void main(String[] args) {
        System.out.println("Hello from Java 25!");
        int[] nums = {2, 7, 11, 15};
        int target = 9;
        for (int i = 0; i < nums.length; i++) {
            for (int j = i + 1; j < nums.length; j++) {
                if (nums[i] + nums[j] == target) {
                    System.out.println("Two Sum: [" + i + ", " + j + "]");
                }
            }
        }
    }
}
JAVAEOF
cd /tmp && /usr/local/jdk-25/bin/javac HelloJava.java && /usr/local/jdk-25/bin/java HelloJava
echo ""

# Test 9: Go 1.25.4
echo "=== TEST 9: Go 1.25.4 ==="
cat > /tmp/test_go.go << 'GOEOF'
package main
import "fmt"
func main() {
    fmt.Println("Hello from Go 1.25.4!")
    arr := []int{64, 34, 25, 12, 22, 11, 90}
    fmt.Println("Array:", arr)
}
GOEOF
/usr/local/go-1.25.4/bin/go run /tmp/test_go.go
echo ""

# Test 10: Rust 1.89.0
echo "=== TEST 10: Rust 1.89.0 ==="
cat > /tmp/test_rust.rs << 'RUSTEOF'
fn main() {
    println!("Hello from Rust 1.89.0!");
    let arr = vec![64, 34, 25, 12, 22, 11, 90];
    println!("Array: {:?}", arr);
}
RUSTEOF
/usr/local/rust-1.89.0/bin/rustc /tmp/test_rust.rs -o /tmp/test_rust && /tmp/test_rust
echo ""

# Test 11: Ruby 3.2.8
echo "=== TEST 11: Ruby 3.2.8 ==="
/usr/local/ruby-3.2/bin/ruby << 'RUBY32EOF'
puts "Hello from Ruby 3.2.8!"
arr = [64, 34, 25, 12, 22, 11, 90]
puts "Sorted: #{arr.sort}"
RUBY32EOF
echo ""

# Test 12: Ruby 3.4.7
echo "=== TEST 12: Ruby 3.4.7 ==="
/usr/local/ruby-3.4/bin/ruby << 'RUBY34EOF'
puts "Hello from Ruby 3.4.7!"
(1..5).each { |i| puts "  Iteration #{i}" }
RUBY34EOF
echo ""

# Test 13: Kotlin 2.3.0
echo "=== TEST 13: Kotlin 2.3.0 ==="
export JAVA_HOME=/usr/local/jdk-25
export PATH=/usr/local/jdk-25/bin:$PATH
cat > /tmp/test_kotlin.kt << 'KTEOF'
fun main() {
    println("Hello from Kotlin 2.3.0!")
    val nums = listOf(1, 2, 3, 4, 5)
    println("Sum: ${nums.sum()}")
}
KTEOF
/usr/local/kotlin-2.3.0/bin/kotlinc /tmp/test_kotlin.kt -include-runtime -d /tmp/test_kotlin.jar 2>/dev/null
/usr/local/jdk-25/bin/java -jar /tmp/test_kotlin.jar
echo ""

# Test 14: PHP 8.2.30
echo "=== TEST 14: PHP 8.2.30 ==="
/usr/local/php-8.2/bin/php << 'PHP82EOF'
<?php
echo "Hello from PHP 8.2.30!\n";
$arr = [64, 34, 25, 12, 22, 11, 90];
sort($arr);
echo "Sorted: " . implode(", ", $arr) . "\n";
?>
PHP82EOF
echo ""

# Test 15: PHP 8.4.3
echo "=== TEST 15: PHP 8.4.3 ==="
/usr/local/php-8.5/bin/php << 'PHP85EOF'
<?php
echo "Hello from PHP 8.4.3!\n";
$sum = array_reduce([1,2,3,4,5], fn($a, $b) => $a + $b, 0);
echo "Sum of 1-5: $sum\n";
?>
PHP85EOF
echo ""

# Test 16: Node.js 22.21.1
echo "=== TEST 16: Node.js 22.21.1 ==="
/usr/local/node-22/bin/node << 'NODE22EOF'
console.log("Hello from Node.js 22.21.1!");
const arr = [64, 34, 25, 12, 22, 11, 90];
console.log("Sorted:", arr.sort((a, b) => a - b));
NODE22EOF
echo ""

# Test 17: Node.js 24.12.0
echo "=== TEST 17: Node.js 24.12.0 ==="
/usr/local/node-24/bin/node << 'NODE24EOF'
console.log("Hello from Node.js 24.12.0!");
const sum = [1, 2, 3, 4, 5].reduce((a, b) => a + b, 0);
console.log("Sum of 1-5:", sum);
NODE24EOF
echo ""

# Test 18: TypeScript 5.7.3
echo "=== TEST 18: TypeScript 5.7.3 (Node 22) ==="
export PATH=/usr/local/node-22/bin:$PATH
cat > /tmp/test_ts22.ts << 'TS22EOF'
const message: string = "Hello from TypeScript 5.7.3!";
console.log(message);
const nums: number[] = [1, 2, 3, 4, 5];
console.log("Sum:", nums.reduce((a, b) => a + b, 0));
TS22EOF
/usr/local/node-22/bin/tsc /tmp/test_ts22.ts --outDir /tmp 2>/dev/null
/usr/local/node-22/bin/node /tmp/test_ts22.js
echo ""

# Test 19: TypeScript 5.9.3
echo "=== TEST 19: TypeScript 5.9.3 (Node 24) ==="
export PATH=/usr/local/node-24/bin:$PATH
cat > /tmp/test_ts24.ts << 'TS24EOF'
interface Greeting {
    message: string;
}
const greeting: Greeting = { message: "Hello from TypeScript 5.9.3!" };
console.log(greeting.message);
TS24EOF
/usr/local/node-24/bin/tsc /tmp/test_ts24.ts --outDir /tmp 2>/dev/null
/usr/local/node-24/bin/node /tmp/test_ts24.js
echo ""

echo "=============================================="
echo "ALL TESTS COMPLETED SUCCESSFULLY!"
echo "=============================================="
echo ""
echo "Summary of installed languages:"
echo "  - GCC 14 & 15 (C/C++)"
echo "  - Clang 18 & 19 (C/C++)"
echo "  - Python 2.7, 3.11, 3.14"
echo "  - Java 25"
echo "  - Go 1.25.4"
echo "  - Rust 1.89.0"
echo "  - Ruby 3.2.8 & 3.4.7"
echo "  - Kotlin 2.3.0"
echo "  - PHP 8.2.30 & 8.4.3"
echo "  - Node.js 22.21.1 & 24.12.0"
echo "  - TypeScript 5.7.3 & 5.9.3"
