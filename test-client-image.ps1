# Judge0 Client Image - Test Script
# Tests all 23 language entries after building the image
#
# Usage: .\test-client-image.ps1

param(
    [string]$ImageName = "judge0-client:test"
)

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "Judge0 Client Image Test Suite" -ForegroundColor Cyan
Write-Host "Testing image: $ImageName" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# First run version check
Write-Host "Running version checks..." -ForegroundColor Yellow
docker run --rm $ImageName /usr/local/bin/check-versions.sh
Write-Host ""

# Test each language
$tests = @(
    @{Name="C (GCC 14)"; Cmd='echo ''#include <stdio.h>
int main() { printf("Hello from C GCC 14!\n"); return 0; }'' > /tmp/test.c && /usr/local/gcc-14/bin/gcc -o /tmp/test /tmp/test.c && /tmp/test'},
    
    @{Name="C++ (GCC 14)"; Cmd='echo ''#include <iostream>
int main() { std::cout << "Hello from C++ GCC 14!" << std::endl; return 0; }'' > /tmp/test.cpp && /usr/local/gcc-14/bin/g++ -o /tmp/test /tmp/test.cpp && /tmp/test'},
    
    @{Name="C (Clang 19)"; Cmd='echo ''#include <stdio.h>
int main() { printf("Hello from C Clang 19!\n"); return 0; }'' > /tmp/test.c && /usr/local/clang-19/bin/clang -o /tmp/test /tmp/test.c && /tmp/test'},
    
    @{Name="C++ (Clang 19)"; Cmd='echo ''#include <iostream>
int main() { std::cout << "Hello from C++ Clang 19!" << std::endl; return 0; }'' > /tmp/test.cpp && /usr/local/clang-19/bin/clang++ -o /tmp/test /tmp/test.cpp -lstdc++ && /tmp/test'},
    
    @{Name="Python 2.7"; Cmd='/usr/local/python-2.7/bin/python2.7 -c "print ''Hello from Python 2.7!''"'},
    
    @{Name="Python 3.11"; Cmd='/usr/local/python-3.11/bin/python3.11 -c "print(''Hello from Python 3.11!'')"'},
    
    @{Name="Python 3.14"; Cmd='/usr/local/python-3.14/bin/python3.14 -c "print(''Hello from Python 3.14!'')"'},
    
    @{Name="Java JDK 25"; Cmd='echo ''public class Test { public static void main(String[] args) { System.out.println("Hello from Java 25!"); } }'' > /tmp/Test.java && /usr/local/jdk-25/bin/javac /tmp/Test.java -d /tmp && /usr/local/jdk-25/bin/java -cp /tmp Test'},
    
    @{Name="Go 1.25"; Cmd='echo ''package main
import "fmt"
func main() { fmt.Println("Hello from Go 1.25!") }'' > /tmp/test.go && /usr/local/go-1.25.4/bin/go run /tmp/test.go'},
    
    @{Name="Rust 1.89"; Cmd='echo ''fn main() { println!("Hello from Rust 1.89!"); }'' > /tmp/test.rs && /usr/local/rust-1.89.0/bin/rustc -o /tmp/test /tmp/test.rs && /tmp/test'},
    
    @{Name="Ruby 2.7"; Cmd='/usr/local/ruby-2.7/bin/ruby -e "puts ''Hello from Ruby 2.7!''"'},
    
    @{Name="Ruby 3.4"; Cmd='/usr/local/ruby-3.4/bin/ruby -e "puts ''Hello from Ruby 3.4!''"'},
    
    @{Name="PHP 8.2"; Cmd='/usr/local/php-8.2/bin/php -r "echo \"Hello from PHP 8.2!\n\";"'},
    
    @{Name="PHP 8.4/8.5"; Cmd='/usr/local/php-8.5/bin/php -r "echo \"Hello from PHP 8.4!\n\";"'},
    
    @{Name="Node.js 22"; Cmd='/usr/local/node-22/bin/node -e "console.log(''Hello from Node.js 22!'')"'},
    
    @{Name="Node.js 24"; Cmd='/usr/local/node-24/bin/node -e "console.log(''Hello from Node.js 24!'')"'},
    
    @{Name="TypeScript 5.7 (Node 22)"; Cmd='echo ''console.log("Hello from TypeScript 5.7!");'' > /tmp/test.ts && /usr/local/node-22/bin/tsc /tmp/test.ts --outDir /tmp && /usr/local/node-22/bin/node /tmp/test.js'},
    
    @{Name="TypeScript 5.9 (Node 24)"; Cmd='echo ''console.log("Hello from TypeScript 5.9!");'' > /tmp/test.ts && /usr/local/node-24/bin/tsc /tmp/test.ts --outDir /tmp && /usr/local/node-24/bin/node /tmp/test.js'}
)

$passed = 0
$failed = 0
$results = @()

Write-Host "Running language tests..." -ForegroundColor Yellow
Write-Host ""

foreach ($test in $tests) {
    Write-Host "Testing $($test.Name)..." -NoNewline
    
    try {
        $output = docker run --rm $ImageName bash -c $test.Cmd 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host " PASSED" -ForegroundColor Green
            Write-Host "  Output: $output" -ForegroundColor DarkGray
            $passed++
            $results += @{Name=$test.Name; Status="PASSED"; Output=$output}
        } else {
            Write-Host " FAILED" -ForegroundColor Red
            Write-Host "  Error: $output" -ForegroundColor DarkGray
            $failed++
            $results += @{Name=$test.Name; Status="FAILED"; Output=$output}
        }
    } catch {
        Write-Host " ERROR" -ForegroundColor Red
        Write-Host "  Exception: $_" -ForegroundColor DarkGray
        $failed++
        $results += @{Name=$test.Name; Status="ERROR"; Output=$_.ToString()}
    }
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "TEST SUMMARY" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "Passed: $passed" -ForegroundColor Green
Write-Host "Failed: $failed" -ForegroundColor $(if ($failed -gt 0) { "Red" } else { "Green" })
Write-Host ""

if ($failed -gt 0) {
    Write-Host "Failed tests:" -ForegroundColor Red
    foreach ($result in $results) {
        if ($result.Status -ne "PASSED") {
            Write-Host "  - $($result.Name): $($result.Output)" -ForegroundColor Red
        }
    }
}

Write-Host ""
Write-Host "Done!" -ForegroundColor Cyan
