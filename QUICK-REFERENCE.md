# 🚀 Quick Reference - CI/CD Commands

## 📋 Local Development

### Build & Compile
```bash
# Clean build
mvn clean compile

# Quick compile
mvn compile

# Full build with tests
mvn clean verify
```

### Testing
```bash
# Run all tests
mvn test

# Run specific test class
mvn test -Dtest=TestRunner

# Skip tests during build
mvn clean package -DskipTests

# Run tests with parallel execution
mvn test -DparallelSuite
```

### Code Coverage
```bash
# Generate JaCoCo report
mvn clean verify -Djacoco.skip=false

# View coverage report
# Open target/site/jacoco/index.html
```

### Allure Reports
```bash
# Generate Allure report
mvn allure:report

# Serve Allure report (opens in browser)
mvn allure:serve

# View report directly
# Open target/allure-report/index.html
```

## 🐳 Docker Commands

### Build Docker Image
```bash
# Build with latest tag
docker build -t ai-qa-faang-agent:latest .

# Build with version tag
docker build -t ai-qa-faang-agent:v1.0 .

# Build with metadata
docker build -t ai-qa-faang-agent:latest \
             --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
             --build-arg VCS_REF=$(git rev-parse --short HEAD) \
             --build-arg VERSION=1.0 \
             .
```

### Run Docker Container
```bash
# Run basic container
docker run ai-qa-faang-agent:latest

# Run with interactive terminal
docker run -it ai-qa-faang-agent:latest /bin/bash

# Run with port mapping
docker run -p 8080:8080 ai-qa-faang-agent:latest

# Run with volume mount
docker run -v $(pwd)/target:/app/target ai-qa-faang-agent:latest

# View running containers
docker ps

# View logs
docker logs -f <container-id>

# Stop container
docker stop <container-id>

# Remove container
docker rm <container-id>
```

### Docker Compose
```bash
# Start services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Remove volumes
docker-compose down -v
```

### Docker Registry
```bash
# Login to Docker Hub
docker login

# Tag image for push
docker tag ai-qa-faang-agent:latest \
            nikkks2000/ai-qa-faang-agent:latest

# Push to registry
docker push nikkks2000/ai-qa-faang-agent:latest

# Pull from registry
docker pull nikkks2000/ai-qa-faang-agent:latest

# Logout
docker logout
```

## 🔄 Git Commands

### Repository Setup
```bash
# Initialize repository
git init

# Clone repository
git clone https://github.com/Nikkks2000/ai-qa-faang-agent.git

# Check status
git status

# View changes
git diff
```

### Branches
```bash
# Create new branch
git checkout -b feature/my-feature

# List branches
git branch -a

# Switch branch
git checkout branch-name

# Delete branch
git branch -d branch-name

# Push branch
git push origin feature/my-feature
```

### Commits
```bash
# Stage files
git add .

# Commit changes
git commit -m "commit message"

# View commit log
git log

# Push commits
git push origin master
```

## 🏗️ Pipeline Scripts

### Local Pipeline Execution

#### Unix/Linux/Mac
```bash
# Make script executable
chmod +x run-local-pipeline.sh

# Run basic pipeline
./run-local-pipeline.sh

# Run with Docker support
./run-local-pipeline.sh --docker
```

#### Windows
```powershell
# Run basic pipeline
run-local-pipeline.bat

# Run with Docker support
run-local-pipeline.bat --docker
```

## 🔧 Maven Commands

### Dependency Management
```bash
# Download all dependencies
mvn dependency:go-offline

# List dependencies
mvn dependency:list

# Check for vulnerabilities
mvn org.owasp:dependency-check-maven:check

# Update plugins
mvn org.codehaus.mojo:versions-maven-plugin:display-plugin-updates
```

### Building & Packaging
```bash
# Package as JAR
mvn clean package

# Package with dependencies
mvn clean assembly:assembly

# Skip tests during package
mvn clean package -DskipTests
```

### Plugins
```bash
# Clean target directory
mvn clean

# Display active profiles
mvn help:active-profiles

# Validate POM
mvn validate

# Compile and run source plugin
mvn org.codehaus.mojo:exec-maven-plugin:java
```

## 🧪 TestNG Commands

### Running Tests
```bash
# Run all tests from testng.xml
mvn test

# Run specific test class
mvn test -Dtest=com.faang.ai.TestRunner

# Run tests matching pattern
mvn test -Dtest=*Runner

# Run tests in specific group
mvn test -Dgroups=fast

# Run tests excluding a group
mvn test -DexcludedGroups=slow
```

## ☸️ Kubernetes Commands

### Helm Commands
```bash
# Validate Helm chart
helm lint k8s/helm/

# Dry run
helm install --dry-run --debug ai-qa k8s/helm/

# Install release
helm install ai-qa k8s/helm/ -n production

# Upgrade release
helm upgrade ai-qa k8s/helm/ -n production

# List releases
helm list -n production

# Uninstall release
helm uninstall ai-qa -n production

# View values
helm get values ai-qa -n production
```

### Kubectl Commands
```bash
# Check pod status
kubectl get pods -n production

# View pod logs
kubectl logs -f <pod-name> -n production

# Describe pod
kubectl describe pod <pod-name> -n production

# Port forward
kubectl port-forward <pod-name> 8080:8080 -n production

# Execute command in pod
kubectl exec -it <pod-name> -n production -- /bin/bash

# Scale deployment
kubectl scale deployment ai-qa-faang-agent --replicas=3 -n production

# Rollout status
kubectl rollout status deployment/ai-qa-faang-agent -n production
```

## 🏃 CI/CD Triggers

### Jenkins
```bash
# Trigger build from command line
curl -X POST http://jenkins.example.com/job/ai-qa/build \
     --user username:token

# Get build status
curl http://jenkins.example.com/job/ai-qa/lastBuild/api/json
```

### GitHub Actions
```bash
# Trigger workflow manually (via GitHub UI)
# Settings → Actions → Click 'Run workflow'

# Or via GitHub CLI
gh workflow run ci-cd-pipeline.yml
```

### GitLab CI
```bash
# Trigger pipeline via curl
curl -X POST https://gitlab.com/api/v4/projects/id/pipeline \
     --header "PRIVATE-TOKEN: token"
```

## 📊 Troubleshooting

### Java Issues
```bash
# Check Java version
java -version

# Set JAVA_HOME
export JAVA_HOME=/path/to/jdk-21  # Unix/Linux/Mac
set JAVA_HOME=C:\path\to\jdk-21   # Windows

# Verify JAVA_HOME
echo $JAVA_HOME
```

### Maven Issues
```bash
# Clear Maven cache
rm -rf ~/.m2/repository

# Offline mode
mvn -o clean test

# Debug mode
mvn -X clean test

# View effective POM
mvn help:effective-pom
```

### Docker Issues
```bash
# Clean images
docker image prune -a

# Clean volumes
docker volume prune

# Inspect image
docker inspect <image-id>

# View image layers
docker history <image-id>

# Check disk usage
docker system df
```

---

**For more details, see:**
- [README.md](README.md)
- [CI-CD-PIPELINE.md](CI-CD-PIPELINE.md)
- [PIPELINE-SETUP-SUMMARY.md](PIPELINE-SETUP-SUMMARY.md)

