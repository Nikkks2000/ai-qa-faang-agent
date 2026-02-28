
# 🤖 AI QA FAANG Agent

> **Autonomous AI-Driven API Testing Framework** | Enterprise-Grade QA Automation with Java 21, TestNG, and Allure

[![CI/CD Pipeline](https://github.com/Nikkks2000/ai-qa-faang-agent/actions/workflows/ci-cd-pipeline.yml/badge.svg)](https://github.com/Nikkks2000/ai-qa-faang-agent/actions)
[![Java 21](https://img.shields.io/badge/Java-21-brightgreen)](https://www.oracle.com/java/technologies/javase/jdk21-archive.html)
[![Maven](https://img.shields.io/badge/Maven-3.9.12-blue)](https://maven.apache.org/)
[![Docker](https://img.shields.io/badge/Docker-Latest-blue)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Quick Start](#quick-start)
- [Project Structure](#project-structure)
- [Technology Stack](#technology-stack)
- [CI/CD Pipeline](#cicd-pipeline)
- [Running Tests](#running-tests)
- [Docker Deployment](#docker-deployment)
- [Jenkins Integration](#jenkins-integration)
- [Reports & Analytics](#reports--analytics)
- [Contributing](#contributing)
- [License](#license)

## Overview

**AI QA FAANG Agent** is an enterprise-grade API testing framework designed for FAANG (Facebook, Apple, Amazon, Netflix, Google) companies and organizations requiring:

- ✅ **Autonomous Test Execution**: Intelligent test case generation and execution
- ✅ **Enterprise-Grade CI/CD**: Jenkins, GitHub Actions, Docker integration
- ✅ **Advanced Reporting**: Allure reports with insights and trends
- ✅ **Code Quality**: JaCoCo code coverage, OWASP security scanning
- ✅ **Scalability**: Containerized architecture with Kubernetes-ready design

## Features

### 🧪 Testing
- **TestNG** test framework with parallel execution (4 threads)
- **REST Assured** for API testing
- **Allure** test reporting with interactive dashboards
- **JaCoCo** code coverage analysis
- Comprehensive test suite configuration (`testng.xml`)

### 🔄 CI/CD Pipeline
- **Jenkins**: Complete declarative pipeline with 6+ stages
- **GitHub Actions**: Automated testing on push/PR with security scanning
- **Docker**: Multi-stage builds with slim image optimization
- **Docker Compose**: Local development environment setup

### 🔒 Security & Quality
- OWASP Dependency Check for vulnerability scanning
- Code quality gates and coverage thresholds
- Secure secret management (Docker credentials, GitHub tokens)
- SonarQube integration ready

### 📊 Reporting
- Allure test reports with rich visualization
- JaCoCo code coverage reports
- Test trend analysis and historical data
- GitHub Pages integration for report hosting

### 🐳 Containerization
- Optimized multi-stage Docker build
- Consistent development and production environments
- Docker Compose for local orchestration
- Container health checks and metadata

## Quick Start

### Prerequisites

- **Java 21** (JDK)
- **Maven 3.9.12+**
- **Git**
- **Docker** (optional, for containerization)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Nikkks2000/ai-qa-faang-agent.git
   cd ai-qa-faang-agent
   ```

2. **Build the project**
   ```bash
   mvn clean compile
   ```

3. **Run tests**
   ```bash
   mvn test
   ```

4. **Generate Allure report**
   ```bash
   mvn allure:report
   mvn allure:serve
   ```

5. **Run with Docker**
   ```bash
   docker-compose up -d
   ```

## Project Structure

```
ai-qa-faang-agent/
├── .github/
│   └── workflows/
│       └── ci-cd-pipeline.yml          # GitHub Actions CI/CD
├── src/
│   ├── main/java/com/faang/ai/
│   │   └── OllamaClient.java           # API client implementation
│   └── test/java/com/faang/ai/
│       └── TestRunner.java             # Test cases
├── pom.xml                              # Maven POM (Java 21, TestNG, Allure)
├── testng.xml                           # TestNG suite configuration
├── Dockerfile                           # Multi-stage Docker build
├── docker-compose.yml                   # Local Docker setup
├── Jenkinsfile                          # Jenkins pipeline
├── run-local-pipeline.sh                # Local test execution script
├── CI-CD-PIPELINE.md                    # Detailed CI/CD documentation
└── .dockerignore                        # Docker build exclusions
```

## Technology Stack

### Core Technologies
| Component | Version | Purpose |
|-----------|---------|---------|
| Java | 21 LTS | Runtime environment |
| Maven | 3.9.12 | Build automation |
| TestNG | 7.10.0 | Test framework |
| REST Assured | 5.4.0 | API testing library |
| OkHttp3 | 4.12.0 | HTTP client |

### CI/CD & DevOps
| Tool | Version | Purpose |
|------|---------|---------|
| Jenkins | 2.426+ | CI/CD orchestration |
| GitHub Actions | Latest | Cloud CI/CD |
| Docker | Latest | Containerization |
| Maven Surefire | 3.2.5 | Test runner plugin |

### Reporting & Analytics
| Tool | Version | Purpose |
|------|---------|---------|
| Allure | 2.24.0 | Test reporting |
| JaCoCo | 0.8.11 | Code coverage |
| Log4j2 | 2.23.1 | Logging |

## CI/CD Pipeline

### Pipeline Flow

```
GitHub Push → GitHub Actions / Jenkins
    ↓
├─ Checkout Code
├─ Compile & Build
├─ Run Tests (TestNG + Allure)
├─ Generate Reports
├─ Build Docker Image
├─ Push to Registry
├─ Security Scanning
└─ Notify Status
```

### Stages

| Stage | Purpose | Tools |
|-------|---------|-------|
| **Checkout** | Clone repository | Git |
| **Build & Compile** | Compile Java source | Maven, JDK 21 |
| **Unit Tests** | Execute test suite | TestNG, Allure listener |
| **Allure Report** | Generate test report | Allure Maven Plugin |
| **Docker Build** | Create container image | Docker |
| **Docker Push** | Push to registry | Docker Hub |
| **AI Analysis** | Run analysis on results | Custom tools |
| **Security Scan** | Check vulnerabilities | OWASP Dependency Check |

### Jenkins Pipeline Configuration

To use with Jenkins:

1. **Install Required Plugins**
   ```
   Pipeline, Git, Maven, Allure, Docker
   ```

2. **Create New Pipeline Job**
   - Pipeline script from SCM (Git)
   - Repository: `https://github.com/Nikkks2000/ai-qa-faang-agent.git`
   - Script path: `Jenkinsfile`

3. **Configure Tools**
   - JDK 21 path
   - Maven 3.9.12 path

4. **Add Credentials**
   - Docker Hub credentials for image push

### GitHub Actions Workflow

Workflow triggered on:
- Push to `master`, `main`, `develop`
- Pull requests
- Daily schedule (2 AM UTC)

Artifacts:
- Allure reports (published to GitHub Pages)
- Code coverage reports
- OWASP dependency reports

## Running Tests

### Local Execution

```bash
# Compile only
mvn clean compile

# Run tests
mvn clean test

# Run tests with coverage
mvn clean verify -Djacoco.skip=false

# Generate Allure report
mvn allure:report

# Serve Allure report
mvn allure:serve

# Run pipeline locally
chmod +x run-local-pipeline.sh
./run-local-pipeline.sh --docker
```

### Parallel Test Execution

Tests run in parallel (4 threads) as configured in `testng.xml`:

```xml
<suite name="AI QA FAANG Test Suite" parallel="tests" thread-count="4">
```

### Test Configuration

Edit `testng.xml` to:
- Add/remove test classes
- Change parallel execution settings
- Configure test dependencies
- Set up test groups

### CI/CD Execution

**GitHub Actions:**
- Tests run automatically on push/PR
- Results published to GitHub Pages
- Coverage reports archived

**Jenkins:**
- Trigger via pipeline job
- View results in Jenkins UI
- Download artifacts from build

## Docker Deployment

### Build Image

```bash
# Build locally
docker build -t ai-qa-faang-agent:latest .

# Build with tagging
docker build -t ai-qa-faang-agent:v1.0 \
             -t ai-qa-faang-agent:latest \
             --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
             .
```

### Run Container

```bash
# Run with Docker
docker run ai-qa-faang-agent:latest

# Run with Docker Compose
docker-compose up -d

# View logs
docker logs -f <container-id>

# Pull image from Docker Hub
docker pull nikkks2000/ai-qa-faang-agent:latest
```

### Docker Image Details

- **Base Image**: `eclipse-temurin:21-jdk-jammy`
- **Multi-stage Build**: Reduces final image size
- **Health Checks**: Built-in container health monitoring
- **Metadata Labels**: Build date, version, maintainer info

## Jenkins Integration

### Pipeline Features

✅ **Parallel Stages**: Compile, test, and report in parallel
✅ **Conditional Execution**: Docker push only on master branch
✅ **Environment Variables**: Build metadata, Docker credentials
✅ **Post-Build Actions**: Artifact archival, report publishing
✅ **Error Handling**: Comprehensive logging and notifications

### Setup Guide

See [CI-CD-PIPELINE.md](CI-CD-PIPELINE.md) for detailed Jenkins setup instructions

## Reports & Analytics

### Allure Reports

View detailed test results with:
- ✅ Test execution timeline
- 🔴 Failed test analysis
- 📊 Test trends and history
- 🎯 Category breakdowns

**Location**: `target/allure-report/index.html`

### Code Coverage

JaCoCo generates coverage reports showing:
- Line coverage
- Branch coverage
- Complexity analysis

**Location**: `target/site/jacoco/index.html`

### GitHub Pages

Allure reports published to:
```
https://<username>.github.io/<repo>/
```

## Contributing

### Branch Strategy

- `master`: Production-ready code
- `develop`: Development branch
- `feature/*`: Feature branches
- `bugfix/*`: Bug fix branches

### Pull Request Process

1. Create feature branch
2. Make changes and commit
3. Push to GitHub
4. Create Pull Request
5. Wait for CI/CD pipeline
6. Merge after approval

### Code Standards

- Java 21 compatibility
- Follow Maven conventions
- Include unit tests
- Run `mvn clean verify` before PR

## Troubleshooting

### Common Issues

**SLF4J Logger Warning**
```
SLF4J: Failed to load class "org.slf4j.impl.StaticLoggerBinder"
```
→ Add SLF4J binding or use Log4j2 (already configured)

**Test Failures**
→ Check test reports: `target/surefire-reports/`

**Docker Build Failures**
→ Clear Docker cache: `docker system prune -a`

**Jenkins Pipeline Errors**
→ Check Jenkins logs and Jenkinsfile syntax

See [CI-CD-PIPELINE.md](CI-CD-PIPELINE.md) for more troubleshooting

## Performance Metrics

- ⚡ **Build Time**: ~2-3 minutes (with cache)
- 🧪 **Test Execution**: ~1-2 minutes (parallel)
- 📦 **Docker Image Size**: ~500MB (optimized)
- ✅ **Test Pass Rate**: 100% (when service available)

## Security

- ✅ OWASP Dependency Scanning
- ✅ Secure credential management
- ✅ Container security scanning
- ✅ SLF4J logging with no sensitive data

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support & Documentation

- 📚 [CI/CD Pipeline Guide](CI-CD-PIPELINE.md)
- 📖 [Maven Documentation](https://maven.apache.org/)
- 🧪 [TestNG Documentation](https://testng.org/)
- 📊 [Allure Documentation](https://docs.qameta.io/allure/)
- 🐳 [Docker Documentation](https://docs.docker.com/)
- 🔗 [Jenkins Documentation](https://www.jenkins.io/doc/)

## Roadmap

- [ ] Kubernetes deployment templates (Helm)
- [ ] Lambda test integration
- [ ] Slack notifications
- [ ] Performance benchmarking
- [ ] AI-driven test optimization
- [ ] Multi-cloud deployment

---

**Built with ❤️ for Enterprise QA Teams**

*Last Updated: February 28, 2026*
