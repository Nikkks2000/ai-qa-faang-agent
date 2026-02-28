# 🚀 CI/CD Pipeline Documentation

## Overview

This project implements a comprehensive CI/CD pipeline with the following workflow:

```
Code (GitHub) → Jenkins → Docker Build → Test Execution → Allure Report → AI Analysis
```

## Pipeline Architecture

### 1. **Source Control (GitHub)**
- Repository: `https://github.com/Nikkks2000/ai-qa-faang-agent`
- Branch: `master` (production builds)
- Triggers: Push events, Pull requests, Scheduled builds

### 2. **Build Tool (Maven)**
- Java 21 (LTS)
- Maven 3.9.12
- Dependencies: TestNG, REST Assured, OkHttp3

### 3. **Testing Framework (TestNG)**
- Unit tests with Allure reporting
- Parallel execution (4 threads)
- Code coverage via JaCoCo
- Test configuration: `testng.xml`

### 4. **CI/CD Platforms**

#### **Jenkins Pipeline**
- **Agent**: Any
- **Parameters**: DEPLOY_DOCKER (boolean), DOCKER_REGISTRY (string)
- **Stages**:
  1. 📋 Checkout - Clone repository from GitHub
  2. 🔨 Build & Compile - Compile Java source code
  3. 🧪 Unit Tests - Execute TestNG tests
  4. 📊 Allure Report - Generate test reports
  5. 🐳 Docker Build & Push - Build and push Docker image (optional)
  6. 🤖 AI Analysis - Run AI-based analysis on test results

#### **GitHub Actions Workflow**
- **File**: `.github/workflows/ci-cd-pipeline.yml`
- **Triggers**: Push to master/main/develop, PRs, Daily schedule
- **Jobs**:
  - ✅ build-and-test
  - 🐳 docker-build-push (on master only)
  - 🔒 security-scan (OWASP Dependency Check)
  - 📊 quality-gates (Code quality analysis)
  - 📢 notify-status

### 5. **Docker**
- **Base Image**: maven:3.9.6-eclipse-temurin-21 (builder)
- **Final Image**: eclipse-temurin:21-jdk-jammy
- **Multi-stage Build**: Reduces final image size
- **Image Registry**: Docker Hub (configurable)
- **Expected Image**: nikkks2000/ai-qa-faang-agent:latest

### 6. **Test Reporting**
- **Allure Reports**: Visual test results and trends
- **Location**: `target/allure-results/` & `target/allure-report/`
- **Integration**: Published to GitHub Pages (GitHub Actions)

### 7. **Artifacts & Artifacts**
- Test results (XML/JSON)
- Allure reports (HTML)
- Code coverage reports (JaCoCo)
- Docker images with build metadata

---

## Setup Instructions

### Prerequisites
- Java 21 (JDK 21)
- Maven 3.9.12+
- Docker & Docker Compose (for containerization)
- Jenkins (self-hosted or cloud-based)
- Git client

### Local Development Setup

#### 1. Clone the repository
```bash
git clone https://github.com/Nikkks2000/ai-qa-faang-agent.git
cd ai-qa-faang-agent
```

#### 2. Build the project
```bash
mvn clean compile
```

#### 3. Run tests locally
```bash
mvn test
```

#### 4. Generate Allure report
```bash
mvn allure:report
```

#### 5. View the report
```bash
# For Unix/Mac
open target/allure-report/index.html

# For Windows
start target/allure-report/index.html
```

#### 6. Run using Docker (optional)
```bash
# Using docker-compose
docker-compose up -d

# Or direct Docker
docker build -t ai-qa-faang-agent:latest .
docker run ai-qa-faang-agent:latest
```

#### 7. Run local pipeline script
```bash
chmod +x run-local-pipeline.sh
./run-local-pipeline.sh           # Regular run
./run-local-pipeline.sh --docker  # With Docker build
```

---

## Jenkins Setup Guide

### 1. Install Required Plugins
- Pipeline
- Git
- Maven Integration
- Allure
- Docker
- Email Extension
- Blue Ocean (optional, for better UI)

### 2. Create a New Pipeline Job
1. Click "New Item"
2. Select "Pipeline"
3. Configure:
   - **SCM**: Git
   - **Repository URL**: `https://github.com/Nikkks2000/ai-qa-faang-agent.git`
   - **Branch**: `*/master`
   - **Script Path**: `Jenkinsfile`

### 3. Configure Jenkins Tools
Go to Manage Jenkins → Tools:

#### Maven Configuration
- **Name**: Maven3.9.12
- **MAVEN_HOME**: `/path/to/maven-3.9.12`

#### JDK Configuration
- **Name**: JDK21
- **JAVA_HOME**: `/path/to/jdk-21`

### 4. Configure Credentials
Store these in Jenkins Credentials Store:
- **docker-credentials**: Docker Hub username/password
- **github-token** (optional): GitHub Personal Access Token

### 5. Enable Allure Plugin
- Manage Jenkins → Manage Plugins → Install "Allure Plugin"
- Configure Allure in job post-build actions

### 6. Configure Email Notifications (Optional)
- Manage Jenkins → Configure System → Email Notification
- Set SMTP server details
- Enable post-build email notifications in Jenkinsfile

---

## GitHub Actions Setup

### 1. Add Repository Secrets
Go to Settings → Secrets and Variables → Actions:
```
DOCKER_USERNAME    = Your Docker Hub username
DOCKER_PASSWORD    = Your Docker Hub password/token
GITHUB_TOKEN       = (Automatically provided)
```

### 2. Workflow Triggers
The workflow automatically runs on:
- Push to `master`, `main`, or `develop`
- Pull requests to `master`, `main`, or `develop`
- Daily schedule (2 AM UTC)

### 3. View Workflow Results
1. Go to Actions tab
2. Select "CI/CD Pipeline - Java 21"
3. View job logs and artifacts

### 4. GitHub Pages Setup (for Allure Reports)
1. Go to Settings → Pages
2. Set Source to: "Deploy from a branch"
3. Branch: `gh-pages` (auto-created by workflow)
4. Allure reports will be accessible at: `https://<username>.github.io/<repo>/`

---

## Build & Test Commands

### Local Maven Commands
```bash
# Compile only
mvn clean compile

# Compile + run tests
mvn clean test

# Full build with coverage
mvn clean verify -Djacoco.skip=false

# Skip tests
mvn clean package -DskipTests

# Generate Allure report
mvn allure:report

# Serve Allure report locally
mvn allure:serve
```

### Docker Commands
```bash
# Build image
docker build -t ai-qa-faang-agent:latest .

# Run container
docker run ai-qa-faang-agent:latest

# Run with Docker Compose
docker-compose up -d

# View logs
docker logs -f <container-id>

# Stop and remove
docker-compose down
```

---

## File Structure

```
ai-qa-faang-agent/
├── .github/
│   └── workflows/
│       └── ci-cd-pipeline.yml          # GitHub Actions workflow
├── src/
│   ├── main/java/com/faang/ai/
│   │   └── OllamaClient.java           # Main application code
│   └── test/java/com/faang/ai/
│       └── TestRunner.java             # Test code
├── pom.xml                              # Maven configuration (Java 21, TestNG, Allure)
├── testng.xml                           # Test suite configuration
├── Dockerfile                           # Multi-stage Docker build
├── docker-compose.yml                   # Local Docker Compose setup
├── Jenkinsfile                          # Jenkins pipeline configuration
├── run-local-pipeline.sh                # Local pipeline execution script
└── .dockerignore                        # Docker build exclusions
```

---

## Pipeline Stages Explained

### 1. 📋 Checkout
- Clones the latest code from GitHub repository
- Sets up the workspace

### 2. 🔨 Build & Compile
- Compiles Java source code with Java 21
- Validates project structure
- Downloads all dependencies

### 3. 🧪 Unit Tests & Code Coverage
- Executes TestNG test suite
- Generates Allure test results
- Produces JaCoCo code coverage reports
- Parallel test execution (4 threads)

### 4. 📊 Allure Report
- Converts test results to Allure format
- Generates interactive HTML report
- Shows test trends and analytics
- Published to GitHub Pages (GitHub Actions) or Jenkins (Jenkins)

### 5. 🐳 Docker Build & Push (Optional)
- Builds multi-stage Docker image
- Tags with build number and commit hash
- Pushes to Docker Hub registry
- Only runs on master branch in GitHub Actions

### 6. 🤖 AI Analysis (Optional)
- Runs AI-based analysis on test results
- Analyzes trends and patterns
- Identifies flaky tests
- Generates insights for improvement

---

## Expected Outputs

### Build Success
```
✅ Compilation successful
✅ All tests passed (X/X)
✅ Allure report generated
✅ Docker image built and pushed
✅ Pipeline completed successfully
```

### Artifacts Generated
- `target/allure-results/` - Raw test results
- `target/allure-report/` - HTML test report
- `target/site/jacoco/` - Code coverage report
- `target/classes/` - Compiled classes
- `target/test-classes/` - Compiled test classes
- Docker image: `nikkks2000/ai-qa-faang-agent:latest`

---

## Troubleshooting

### Maven Build Failures
```bash
# Clear Maven cache
mvn clean

# Rebuild dependencies
mvn dependency:resolve

# Verbose output
mvn clean test -X
```

### Test Failures
1. Check test logs: `target/surefire-reports/`
2. Review Allure report for detailed failure info
3. Ensure TestNG annotations are correct (@Test)

### Docker Issues
```bash
# Check images
docker images

# Remove dangling images
docker image prune -a

# Inspect container
docker inspect <container-id>
```

### Jenkins Configuration Issues
1. Check Jenkins logs: `/var/log/jenkins/jenkins.log`
2. Validate Jenkinsfile syntax: `mvn -f Jenkinsfile validate`
3. Verify tool paths in Manage Jenkins → Tools

---

## Security Considerations

1. **Credentials Management**
   - Store Docker credentials in Jenkins Credentials Store
   - Use GitHub Secrets for Docker Hub access
   - Never commit credentials to repository

2. **Dependency Scanning**
   - OWASP Dependency Check in GitHub Actions
   - Review security reports regularly
   - Update vulnerable dependencies promptly

3. **Image Security**
   - Use specific base image versions (not `latest`)
   - Scan Docker images for vulnerabilities
   - Follow principle of least privilege

---

## Performance Optimization

- **Parallel Test Execution**: TestNG runs 4 tests in parallel
- **Docker Layer Caching**: Multi-stage build reduces image size
- **Maven Dependency Caching**: GitHub Actions caches Maven local repo
- **Quiet Build**: `-q` flag suppresses non-error output

---

## Monitoring & Maintenance

### Key Metrics to Track
- Build success rate
- Test pass rate
- Build time trends
- Code coverage percentage
- Docker image size

### Regular Maintenance Tasks
- Review and update dependencies monthly
- Archive old builds (Jenkins)
- Clean up Docker images regularly
- Review Allure test trends

---

## Support & Documentation

- **Maven**: https://maven.apache.org/
- **TestNG**: https://testng.org/
- **Allure**: https://docs.qameta.io/allure/
- **Jenkins**: https://www.jenkins.io/doc/
- **Docker**: https://docs.docker.com/
- **GitHub Actions**: https://docs.github.com/en/actions

---

## Quick Links

- **Jenkins Server**: (Configure URL)
- **GitHub Repository**: https://github.com/Nikkks2000/ai-qa-faang-agent
- **Docker Hub**: https://hub.docker.com/r/nikkks2000/ai-qa-faang-agent
- **Allure Reports**: (Configure GitHub Pages URL)

---

## Version History

- **v1.0** (2026-02-28): Initial CI/CD setup with Java 21, Maven, TestNG, Allure, Docker, Jenkins, GitHub Actions

