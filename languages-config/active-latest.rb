# Judge0 Language Configuration - Latest Stable Versions Only
# Last Updated: December 31, 2025
# Old versions removed, only latest stable compilers

[
  # ============================================================================
  # C (GCC 14.2.0) - Latest Stable
  # ============================================================================
  {
    id: 50,
    name: "C (GCC 14.2.0)",
    is_archived: false,
    source_file: "main.c",
    compile_cmd: "/usr/local/gcc-14/bin/gcc %s -lm",
    run_cmd: "LD_LIBRARY_PATH=/usr/local/gcc-14/lib64 ./a.out"
  },

  # ============================================================================
  # C++ (GCC 14.2.0) - Latest Stable
  # ============================================================================
  {
    id: 54,
    name: "C++ (GCC 14.2.0)",
    is_archived: false,
    source_file: "main.cpp",
    compile_cmd: "/usr/local/gcc-14/bin/g++ %s -lm",
    run_cmd: "LD_LIBRARY_PATH=/usr/local/gcc-14/lib64 ./a.out"
  },

  # ============================================================================
  # Java (OpenJDK 23) - Latest Stable
  # ============================================================================
  {
    id: 62,
    name: "Java (OpenJDK 23)",
    is_archived: false,
    source_file: "Main.java",
    compile_cmd: "/usr/local/openjdk-23/bin/javac %s",
    run_cmd: "/usr/local/openjdk-23/bin/java Main"
  },

  # ============================================================================
  # Python (3.13.1) - Latest Stable
  # ============================================================================
  {
    id: 71,
    name: "Python (3.13.1)",
    is_archived: false,
    source_file: "script.py",
    compile_cmd: nil,
    run_cmd: "/usr/local/python-3.13/bin/python3.13 %s"
  },

  # ============================================================================
  # Node.js (23.5.0) - Latest Current
  # ============================================================================
  {
    id: 63,
    name: "JavaScript (Node.js 23.5.0)",
    is_archived: false,
    source_file: "script.js",
    compile_cmd: nil,
    run_cmd: "/usr/local/bin/node %s"
  },

  # ============================================================================
  # TypeScript (5.7.2) - Latest Stable
  # ============================================================================
  {
    id: 74,
    name: "TypeScript (5.7.2)",
    is_archived: false,
    source_file: "script.ts",
    compile_cmd: "/usr/local/bin/tsc %s",
    run_cmd: "/usr/local/bin/node script.js"
  },

  # ============================================================================
  # PHP (8.4.2) - Latest Stable
  # ============================================================================
  {
    id: 68,
    name: "PHP (8.4.2)",
    is_archived: false,
    source_file: "script.php",
    compile_cmd: nil,
    run_cmd: "/usr/local/php-8.4/bin/php %s"
  },

  # ============================================================================
  # Go (1.23.4) - Latest Stable
  # ============================================================================
  {
    id: 60,
    name: "Go (1.23.4)",
    is_archived: false,
    source_file: "main.go",
    compile_cmd: "/usr/local/go-1.23/bin/go build %s",
    run_cmd: "./main"
  },

  # ============================================================================
  # Kotlin (2.1.0) - Latest Stable
  # ============================================================================
  {
    id: 78,
    name: "Kotlin (2.1.0)",
    is_archived: false,
    source_file: "Main.kt",
    compile_cmd: "/usr/local/kotlin-2.1/bin/kotlinc %s -include-runtime -d Main.jar",
    run_cmd: "/usr/local/openjdk-23/bin/java -jar Main.jar"
  },

  # ============================================================================
  # Swift (6.0.3) - Latest Stable
  # ============================================================================
  {
    id: 83,
    name: "Swift (6.0.3)",
    is_archived: false,
    source_file: "Main.swift",
    compile_cmd: "/usr/local/swift-6.0/usr/bin/swiftc %s",
    run_cmd: "./Main"
  },

  # ============================================================================
  # Rust (1.83.0) - Latest Stable
  # ============================================================================
  {
    id: 73,
    name: "Rust (1.83.0)",
    is_archived: false,
    source_file: "main.rs",
    compile_cmd: "/root/.cargo/bin/rustc %s",
    run_cmd: "./main"
  },

  # ============================================================================
  # Ruby (3.3.6) - Latest Stable
  # ============================================================================
  {
    id: 72,
    name: "Ruby (3.3.6)",
    is_archived: false,
    source_file: "script.rb",
    compile_cmd: nil,
    run_cmd: "/usr/local/ruby-3.3/bin/ruby %s"
  }
]
