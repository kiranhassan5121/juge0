# Judge0 Language Configuration
# Custom build for client's LeetCode/HackerRank-style platform
# 23 Language Entries with specific compiler versions
#
# Language IDs assigned:
# 50-53: C (GCC 14, GCC 15, Clang 18, Clang 19)
# 54-57: C++ (GCC 14, GCC 15, Clang 18, Clang 19)
# 60-62: Python (2.7, 3.11, 3.14)
# 63: Java (JDK 25)
# 64: Go (1.25.4)
# 65: Rust (1.89.0)
# 66-67: Ruby (3.2, 3.4)
# 68: Kotlin (2.3.0)
# 69-70: PHP (8.2, 8.5)
# 71-72: JavaScript (Node 22, Node 24)
# 73-74: TypeScript (5.7.3/Node 22, 5.9.3/Node 24)

ActiveRecord::Base.transaction do
  # ============================================
  # C Language Entries
  # ============================================
  
  # C (GCC 14.3.0)
  Language.find_or_create_by!(id: 50) do |lang|
    lang.name = "C (GCC 14.3.0)"
    lang.is_archived = false
    lang.source_file = "main.c"
    lang.compile_cmd = "/usr/local/gcc-14/bin/gcc -o main main.c -O2 -lm"
    lang.run_cmd = "./main"
  end

  # C (GCC 15.2.0)
  Language.find_or_create_by!(id: 51) do |lang|
    lang.name = "C (GCC 15.2.0)"
    lang.is_archived = false
    lang.source_file = "main.c"
    lang.compile_cmd = "/usr/local/gcc-15/bin/gcc -o main main.c -O2 -lm"
    lang.run_cmd = "./main"
  end

  # C (Clang 18.1.8)
  Language.find_or_create_by!(id: 52) do |lang|
    lang.name = "C (Clang 18.1.8)"
    lang.is_archived = false
    lang.source_file = "main.c"
    lang.compile_cmd = "/usr/local/clang-18/bin/clang -o main main.c -O2 -lm"
    lang.run_cmd = "./main"
  end

  # C (Clang 19.1.7)
  Language.find_or_create_by!(id: 53) do |lang|
    lang.name = "C (Clang 19.1.7)"
    lang.is_archived = false
    lang.source_file = "main.c"
    lang.compile_cmd = "/usr/local/clang-19/bin/clang -o main main.c -O2 -lm"
    lang.run_cmd = "./main"
  end

  # ============================================
  # C++ Language Entries
  # ============================================

  # C++ (GCC 14.3.0)
  Language.find_or_create_by!(id: 54) do |lang|
    lang.name = "C++ (GCC 14.3.0)"
    lang.is_archived = false
    lang.source_file = "main.cpp"
    lang.compile_cmd = "/usr/local/gcc-14/bin/g++ -o main main.cpp -O2 -std=c++20"
    lang.run_cmd = "./main"
  end

  # C++ (GCC 15.2.0)
  Language.find_or_create_by!(id: 55) do |lang|
    lang.name = "C++ (GCC 15.2.0)"
    lang.is_archived = false
    lang.source_file = "main.cpp"
    lang.compile_cmd = "/usr/local/gcc-15/bin/g++ -o main main.cpp -O2 -std=c++23"
    lang.run_cmd = "./main"
  end

  # C++ (Clang 18.1.8)
  Language.find_or_create_by!(id: 56) do |lang|
    lang.name = "C++ (Clang 18.1.8)"
    lang.is_archived = false
    lang.source_file = "main.cpp"
    lang.compile_cmd = "/usr/local/clang-18/bin/clang++ -o main main.cpp -O2 -std=c++20 -stdlib=libc++"
    lang.run_cmd = "./main"
  end

  # C++ (Clang 19.1.7)
  Language.find_or_create_by!(id: 57) do |lang|
    lang.name = "C++ (Clang 19.1.7)"
    lang.is_archived = false
    lang.source_file = "main.cpp"
    lang.compile_cmd = "/usr/local/clang-19/bin/clang++ -o main main.cpp -O2 -std=c++23 -stdlib=libc++"
    lang.run_cmd = "./main"
  end

  # ============================================
  # Python Language Entries
  # ============================================

  # Python 2.7.18
  Language.find_or_create_by!(id: 60) do |lang|
    lang.name = "Python (2.7.18)"
    lang.is_archived = false
    lang.source_file = "script.py"
    lang.run_cmd = "/usr/local/python-2.7/bin/python2.7 script.py"
  end

  # Python 3.11.14
  Language.find_or_create_by!(id: 61) do |lang|
    lang.name = "Python (3.11.14)"
    lang.is_archived = false
    lang.source_file = "script.py"
    lang.run_cmd = "/usr/local/python-3.11/bin/python3.11 script.py"
  end

  # Python 3.14.2
  Language.find_or_create_by!(id: 62) do |lang|
    lang.name = "Python (3.14.2)"
    lang.is_archived = false
    lang.source_file = "script.py"
    lang.run_cmd = "/usr/local/python-3.14/bin/python3.14 script.py"
  end

  # ============================================
  # Java Language Entry
  # ============================================

  # Java (JDK 25.0.1)
  Language.find_or_create_by!(id: 63) do |lang|
    lang.name = "Java (JDK 25.0.1)"
    lang.is_archived = false
    lang.source_file = "Main.java"
    lang.compile_cmd = "/usr/local/jdk-25/bin/javac Main.java"
    lang.run_cmd = "/usr/local/jdk-25/bin/java Main"
  end

  # ============================================
  # Go Language Entry
  # ============================================

  # Go 1.25.4
  Language.find_or_create_by!(id: 64) do |lang|
    lang.name = "Go (1.25.4)"
    lang.is_archived = false
    lang.source_file = "main.go"
    lang.compile_cmd = "/usr/local/go-1.25.4/bin/go build -o main main.go"
    lang.run_cmd = "./main"
  end

  # ============================================
  # Rust Language Entry
  # ============================================

  # Rust 1.89.0
  Language.find_or_create_by!(id: 65) do |lang|
    lang.name = "Rust (1.89.0)"
    lang.is_archived = false
    lang.source_file = "main.rs"
    lang.compile_cmd = "/usr/local/rust-1.89.0/bin/rustc -o main main.rs"
    lang.run_cmd = "./main"
  end

  # ============================================
  # Ruby Language Entries
  # ============================================

  # Ruby 3.2.8 (for Judge0 compatibility - replaces Ruby 2.7 which is EOL)
  Language.find_or_create_by!(id: 66) do |lang|
    lang.name = "Ruby (3.2.8)"
    lang.is_archived = false
    lang.source_file = "script.rb"
    lang.run_cmd = "/usr/local/ruby-3.2/bin/ruby script.rb"
  end

  # Ruby 3.4.7
  Language.find_or_create_by!(id: 67) do |lang|
    lang.name = "Ruby (3.4.7)"
    lang.is_archived = false
    lang.source_file = "script.rb"
    lang.run_cmd = "/usr/local/ruby-3.4/bin/ruby script.rb"
  end

  # ============================================
  # Kotlin Language Entry
  # ============================================

  # Kotlin 2.3.0
  Language.find_or_create_by!(id: 68) do |lang|
    lang.name = "Kotlin (2.3.0)"
    lang.is_archived = false
    lang.source_file = "Main.kt"
    lang.compile_cmd = "/usr/local/kotlin-2.3.0/bin/kotlinc Main.kt -include-runtime -d Main.jar"
    lang.run_cmd = "/usr/local/jdk-25/bin/java -jar Main.jar"
  end

  # ============================================
  # PHP Language Entries
  # ============================================

  # PHP 8.2.30
  Language.find_or_create_by!(id: 69) do |lang|
    lang.name = "PHP (8.2.30)"
    lang.is_archived = false
    lang.source_file = "script.php"
    lang.run_cmd = "/usr/local/php-8.2/bin/php script.php"
  end

  # PHP 8.5.1 (using 8.4.3 until 8.5 is released)
  Language.find_or_create_by!(id: 70) do |lang|
    lang.name = "PHP (8.5.1)"
    lang.is_archived = false
    lang.source_file = "script.php"
    lang.run_cmd = "/usr/local/php-8.5/bin/php script.php"
  end

  # ============================================
  # JavaScript (Node.js) Language Entries
  # ============================================

  # JavaScript (Node.js 22.21.1)
  Language.find_or_create_by!(id: 71) do |lang|
    lang.name = "JavaScript (Node.js 22.21.1)"
    lang.is_archived = false
    lang.source_file = "script.js"
    lang.run_cmd = "/usr/local/node-22/bin/node script.js"
  end

  # JavaScript (Node.js 24.12.0)
  Language.find_or_create_by!(id: 72) do |lang|
    lang.name = "JavaScript (Node.js 24.12.0)"
    lang.is_archived = false
    lang.source_file = "script.js"
    lang.run_cmd = "/usr/local/node-24/bin/node script.js"
  end

  # ============================================
  # TypeScript Language Entries
  # ============================================

  # TypeScript 5.7.3 (Node.js 22)
  Language.find_or_create_by!(id: 73) do |lang|
    lang.name = "TypeScript (5.7.3)"
    lang.is_archived = false
    lang.source_file = "script.ts"
    lang.compile_cmd = "/usr/local/node-22/bin/tsc script.ts --outDir ."
    lang.run_cmd = "/usr/local/node-22/bin/node script.js"
  end

  # TypeScript 5.9.3 (Node.js 24)
  Language.find_or_create_by!(id: 74) do |lang|
    lang.name = "TypeScript (5.9.3)"
    lang.is_archived = false
    lang.source_file = "script.ts"
    lang.compile_cmd = "/usr/local/node-24/bin/tsc script.ts --outDir ."
    lang.run_cmd = "/usr/local/node-24/bin/node script.js"
  end

  puts "Successfully configured 23 languages for Judge0"
  puts ""
  puts "Language summary:"
  puts "  - C: GCC 14.3.0 (50), GCC 15.2.0 (51), Clang 19.1.7 (52), Clang 20.1.8 (53)"
  puts "  - C++: GCC 14.3.0 (54), GCC 15.2.0 (55), Clang 19.1.7 (56), Clang 20.1.8 (57)"
  puts "  - Python: 2.7.18 (60), 3.11.14 (61), 3.14.2 (62)"
  puts "  - Java: JDK 25.0.1 (63)"
  puts "  - Go: 1.25.4 (64)"
  puts "  - Rust: 1.89.0 (65)"
  puts "  - Ruby: 3.2.8 (66), 3.4.7 (67)"
  puts "  - Kotlin: 2.3.0 (68)"
  puts "  - PHP: 8.2.30 (69), 8.5.1 (70)"
  puts "  - JavaScript: Node.js 22.21.1 (71), Node.js 24.12.0 (72)"
  puts "  - TypeScript: 5.7.3 (73), 5.9.3 (74)"
end
