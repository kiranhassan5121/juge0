# Judge0 Language Configuration - Working Versions
# Using actually existing and tested versions

[
  # C (using existing GCC from base image)
  {
    id: 50,
    name: "C (GCC 9.2.0)",
    is_archived: false,
    source_file: "main.c",
    compile_cmd: "/usr/bin/gcc %s -lm",
    run_cmd: "./a.out"
  },

  # C++ (using existing GCC from base image)
  {
    id: 54,
    name: "C++ (GCC 9.2.0)",
    is_archived: false,
    source_file: "main.cpp",
    compile_cmd: "/usr/bin/g++ %s -lm",
    run_cmd: "./a.out"
  },

  # Java 21 LTS
  {
    id: 62,
    name: "Java (OpenJDK 21 LTS)",
    is_archived: false,
    source_file: "Main.java",
    compile_cmd: "/usr/local/openjdk-21/bin/javac %s",
    run_cmd: "/usr/local/openjdk-21/bin/java Main"
  },

  # Python 3.12
  {
    id: 71,
    name: "Python (3.12.8)",
    is_archived: false,
    source_file: "script.py",
    compile_cmd: nil,
    run_cmd: "/usr/local/python-3.12/bin/python3.12 %s"
  },

  # Node.js 22 LTS
  {
    id: 63,
    name: "JavaScript (Node.js 22.12.0 LTS)",
    is_archived: false,
    source_file: "script.js",
    compile_cmd: nil,
    run_cmd: "/usr/local/bin/node %s"
  },

  # PHP 8.3
  {
    id: 68,
    name: "PHP (8.3.15)",
    is_archived: false,
    source_file: "script.php",
    compile_cmd: nil,
    run_cmd: "/usr/local/php-8.3/bin/php %s"
  },

  # Go 1.23
  {
    id: 60,
    name: "Go (1.23.4)",
    is_archived: false,
    source_file: "main.go",
    compile_cmd: "/usr/local/go-1.23/bin/go build %s",
    run_cmd: "./main"
  },

  # Kotlin 2.1
  {
    id: 78,
    name: "Kotlin (2.1.0)",
    is_archived: false,
    source_file: "Main.kt",
    compile_cmd: "/usr/local/kotlin-2.1/bin/kotlinc %s -include-runtime -d Main.jar",
    run_cmd: "/usr/local/openjdk-21/bin/java -jar Main.jar"
  },

  # Rust 1.83
  {
    id: 73,
    name: "Rust (1.83.0)",
    is_archived: false,
    source_file: "main.rs",
    compile_cmd: "/usr/local/cargo/bin/rustc %s",
    run_cmd: "./main"
  },

  # Ruby 3.3
  {
    id: 72,
    name: "Ruby (3.3.6)",
    is_archived: false,
    source_file: "script.rb",
    compile_cmd: nil,
    run_cmd: "/usr/local/ruby-3.3/bin/ruby3.3 %s"
  }
]
