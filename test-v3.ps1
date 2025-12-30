# Test script for Judge0 v3 - Verify all upgraded languages
$baseUrl = "http://localhost:2358"
$passed = 0
$failed = 0
$tests = @()

function Test-Language {
    param(
        [string]$Name,
        [int]$LanguageId,
        [string]$SourceCode,
        [string]$ExpectedOutput
    )
    
    Write-Host "`n🔍 Testing $Name (ID: $LanguageId)..." -ForegroundColor Cyan
    
    $body = @{
        source_code = $SourceCode
        language_id = $LanguageId
    } | ConvertTo-Json
    
    try {
        $response = Invoke-RestMethod -Uri "$baseUrl/submissions?base64_encoded=false&wait=true" `
            -Method Post `
            -ContentType "application/json" `
            -Body $body `
            -TimeoutSec 30
        
        $stdout = $response.stdout
        $stderr = $response.stderr
        $status = $response.status.description
        $time = $response.time
        $memory = $response.memory
        
        if ($status -eq "Accepted" -and $stdout -like "*$ExpectedOutput*") {
            Write-Host "  ✅ PASSED" -ForegroundColor Green
            Write-Host "     Output: $($stdout.Trim())" -ForegroundColor Gray
            Write-Host "     Time: ${time}s | Memory: ${memory}KB" -ForegroundColor Gray
            return @{ Name = $Name; Status = "PASS"; Time = $time; Memory = $memory }
        } else {
            Write-Host "  ❌ FAILED" -ForegroundColor Red
            Write-Host "     Status: $status" -ForegroundColor Yellow
            Write-Host "     Expected: $ExpectedOutput" -ForegroundColor Yellow
            Write-Host "     Got: $stdout" -ForegroundColor Yellow
            if ($stderr) { Write-Host "     Stderr: $stderr" -ForegroundColor Red }
            return @{ Name = $Name; Status = "FAIL"; Error = $status }
        }
    } catch {
        Write-Host "  ❌ ERROR: $_" -ForegroundColor Red
        return @{ Name = $Name; Status = "ERROR"; Error = $_.Exception.Message }
    }
}

Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Magenta
Write-Host "  Judge0 v3 - Complete Language Test Suite" -ForegroundColor Magenta
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Magenta

# Test 1: Java 21
$tests += Test-Language -Name "Java (OpenJDK 21.0.5)" -LanguageId 62 `
    -SourceCode "public class Main { public static void main(String[] args) { System.out.println(System.getProperty(`"java.version`")); } }" `
    -ExpectedOutput "21.0.5"

# Test 2: Python 3.12
$tests += Test-Language -Name "Python (3.12.8)" -LanguageId 71 `
    -SourceCode "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}.{sys.version_info.micro}')" `
    -ExpectedOutput "3.12.8"

# Test 3: Node.js 22
$tests += Test-Language -Name "JavaScript (Node.js 22.12.0)" -LanguageId 63 `
    -SourceCode "console.log(process.version)" `
    -ExpectedOutput "v22"

# Test 4: C (GCC 11)
$tests += Test-Language -Name "C (GCC 11.5.0)" -LanguageId 50 `
    -SourceCode "#include <stdio.h>`nint main() { printf(`"GCC 11`"); return 0; }" `
    -ExpectedOutput "GCC 11"

# Test 5: C++ (GCC 11)
$tests += Test-Language -Name "C++ (GCC 11.5.0)" -LanguageId 54 `
    -SourceCode "#include <iostream>`nusing namespace std;`nint main() { cout << `"GCC 11`"; return 0; }" `
    -ExpectedOutput "GCC 11"

# Test 6: Go 1.23
$tests += Test-Language -Name "Go (1.23.4)" -LanguageId 60 `
    -SourceCode "package main`nimport (`"fmt`"; `"runtime`")`nfunc main() { fmt.Println(runtime.Version()) }" `
    -ExpectedOutput "go1.23"

# Test 7: PHP 8.3
$tests += Test-Language -Name "PHP (8.3.15)" -LanguageId 68 `
    -SourceCode "<?php echo PHP_VERSION;" `
    -ExpectedOutput "8.3.15"

# Test 8: C# (.NET 8)
$tests += Test-Language -Name "C# (.NET 8.0)" -LanguageId 51 `
    -SourceCode "using System;`nclass Program { static void Main() { Console.WriteLine(`".NET 8`"); } }" `
    -ExpectedOutput ".NET 8"

# Test 9: Swift 5.8
$tests += Test-Language -Name "Swift (5.8.1)" -LanguageId 83 `
    -SourceCode "print(`"Swift 5.8`")" `
    -ExpectedOutput "Swift 5.8"

# Test 10: TypeScript 5.7
$tests += Test-Language -Name "TypeScript (5.7.2)" -LanguageId 74 `
    -SourceCode "const version: string = `"TypeScript 5.7`"; console.log(version);" `
    -ExpectedOutput "TypeScript 5.7"

# Test 11: Kotlin 2.0
$tests += Test-Language -Name "Kotlin (2.0.21)" -LanguageId 78 `
    -SourceCode "fun main() { println(`"Kotlin 2.0`") }" `
    -ExpectedOutput "Kotlin 2.0"

# Test 12: Ruby 3.0
$tests += Test-Language -Name "Ruby (3.0.7)" -LanguageId 72 `
    -SourceCode "puts RUBY_VERSION" `
    -ExpectedOutput "3.0.7"

# Summary
Write-Host "`n═══════════════════════════════════════════════════" -ForegroundColor Magenta
Write-Host "  Test Results Summary" -ForegroundColor Magenta
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Magenta

$passedTests = ($tests | Where-Object { $_.Status -eq "PASS" }).Count
$failedTests = ($tests | Where-Object { $_.Status -ne "PASS" }).Count
$totalTests = $tests.Count

Write-Host "`n✅ Passed: $passedTests / $totalTests" -ForegroundColor Green
Write-Host "❌ Failed: $failedTests / $totalTests" -ForegroundColor $(if($failedTests -gt 0){"Red"}else{"Green"})

if ($failedTests -eq 0) {
    Write-Host "`n🎉 ALL TESTS PASSED! Judge0 v3 is working perfectly!" -ForegroundColor Green
    Write-Host "All upgraded language versions are correctly registered and executing." -ForegroundColor Green
} else {
    Write-Host "`n⚠️  Some tests failed. Review the output above." -ForegroundColor Yellow
    $tests | Where-Object { $_.Status -ne "PASS" } | ForEach-Object {
        Write-Host "   - $($_.Name): $($_.Error)" -ForegroundColor Red
    }
}

Write-Host "`n"
