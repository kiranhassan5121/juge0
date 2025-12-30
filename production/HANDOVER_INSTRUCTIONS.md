# Judge0 Custom Deployment Instructions

This package contains the production configuration for your custom Judge0 instance.

## **Prerequisites**
- **Docker Desktop** (for Windows/Mac) or **Docker Engine** (for Linux) must be installed.

## **Installation Steps (Local or Server)**

1. **Extract the files**
   Unzip this folder to a location on your machine.

2. **Start the Service**
   Open a terminal (Command Prompt, PowerShell, or Bash) in the extracted folder and run:
   ```bash
   docker-compose up -d
   ```
   *This will automatically pull the custom image (`ghcr.io/umerfarok/juge0:v4`) which includes Java 21, Python 3.12, Node 22, PHP 8.3, Swift 5.8, and more.*

3. **Verify Installation**
   Check if the services are running:
   ```bash
   docker-compose ps
   ```

4. **Access the API**
   The API will be available at:
   `http://localhost:2358`

## **Configuration**
- The main configuration file is `judge0.conf`.
- If you need to change passwords or resource limits, edit `judge0.conf` and restart the services:
  ```bash
  docker-compose restart
  ```

## **Included Compilers**
- **Java 21** (LTS)
- **Python 3.12**
- **Node.js 22**
- **.NET 8.0**
- **Go 1.23**
- **PHP 8.3**
- **Swift 5.8**
- **C/C++ (GCC)**
