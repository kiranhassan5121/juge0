# Test Judge0 v6 - Latest Stable Compilers
# Tests all 12 languages with latest versions

$baseUrl = "http://localhost:2358"
$languages = @(
    @{id=50; name="C (GCC 14.2.0)"; code='#include <stdio.h>
int main() { printf("Hello from GCC 14\n"); return 0; }'},
    
    @{id=54; name="C++ (GCC 14.2.0)"; code='#include <iostream>
int main() { std::cout << "Hello from G++ 14" << std::endl; return 0; }'},
    
    @{id=62; name="Java (OpenJDK 23)"; code='public class Main { public static void main(String[] args) { System.out.println("Hello from Java 23"); } }'},
    
    @{id=71; name="Python (3.13.1)"; code='print("Hello from Python 3.13")
import sys
print(f"Version: {sys.version}")'},
    
    @{id=63; name="JavaScript (Node.js 23.5.0)"; code='console.log("Hello from Node 23");
console.log("Version:", process.version);'},
    
    @{id=74; name="TypeScript (5.7.2)"; code='const msg: string = "Hello from TypeScript 5.7";
console.log(msg);'},
    
    @{id=68; name="PHP (8.4.2)"; code='<?php
echo "Hello from PHP 8.4\n";
echo "Version: " . PHP_VERSION . "\n";
?>'},
    
    @{id=60; name="Go (1.23.4)"; code='package main
import "fmt"
func main() { fmt.Println("Hello from Go 1.23") }'},
    
    @{id=78; name="Kotlin (2.1.0)"; code='fun main() { println("Hello from Kotlin 2.1") }'},
    
    @{id=83; name="Swift (6.0.3)"; code='print("Hello from Swift 6.0")'},
    
    @{id=73; name="Rust (1.83.0)"; code='fn main() { println!("Hello from Rust 1.83"); }'},
    
    @{id=72; name="Ruby (3.3.6)"; code='puts "Hello from Ruby 3.3"
puts "Version: #{RUBY_VERSION}"'}
)

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Judge0 v6 - Latest Compilers Test Suite" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

$passed = 0
$failed = 0

foreach ($lang in $languages) {
    Write-Host "Testing: $($lang.name)" -ForegroundColor Yellow
    
    $body = @{
        source_code = $lang.code
        language_id = $lang.id
    } | ConvertTo-Json
    
    try {
        $response = Invoke-RestMethod -Uri "$baseUrl/submissions?wait=true" `
            -Method Post `
            -Body $body `
            -ContentType "application/json"
        
        if ($response.status.description -eq "Accepted") {
            Write-Host "  ✓ PASS" -ForegroundColor Green
            Write-Host "    Output: $($response.stdout)" -ForegroundColor Gray
            Write-Host "    Time: $($response.time)s | Memory: $($response.memory) KB" -ForegroundColor Gray
            $passed++
        } else {
            Write-Host "  ✗ FAIL: $($response.status.description)" -ForegroundColor Red
            if ($response.stderr) {
                Write-Host "    Error: $($response.stderr)" -ForegroundColor Red
            }
            $failed++
        }
    } catch {
        Write-Host "  ✗ ERROR: $_" -ForegroundColor Red
        $failed++
    }
    
    Write-Host ""
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Results: $passed PASSED | $failed FAILED" -ForegroundColor $(if ($failed -eq 0) { "Green" } else { "Yellow" })
Write-Host "========================================`n" -ForegroundColor Cyan
