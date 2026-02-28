#!/bin/bash
# Local CI/CD Testing Script
# This script simulates the CI/CD pipeline locally for testing purposes

set -e

echo "========================================="
echo "   AI QA FAANG - Local CI/CD Pipeline"
echo "========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Step 1: Build & Compile
echo -e "${BLUE}[Step 1]${NC} Building and compiling..."
mvn clean compile -q
echo -e "${GREEN}✅ Compilation successful${NC}"
echo ""

# Step 2: Run Tests
echo -e "${BLUE}[Step 2]${NC} Running unit tests..."
mvn test -q -Dorg.slf4j.simpleLogger.defaultLogLevel=warn
TESTS_STATUS=$?
if [ $TESTS_STATUS -eq 0 ]; then
    echo -e "${GREEN}✅ All tests passed${NC}"
else
    echo -e "${YELLOW}⚠️  Some tests failed${NC}"
fi
echo ""

# Step 3: Generate Allure Report
echo -e "${BLUE}[Step 3]${NC} Generating Allure report..."
mvn allure:report -q
echo -e "${GREEN}✅ Allure report generated${NC}"
echo ""

# Step 4: Code Coverage
echo -e "${BLUE}[Step 4]${NC} Generating code coverage..."
mvn clean verify -Djacoco.skip=false -q -DskipTests
echo -e "${GREEN}✅ Code coverage report generated${NC}"
echo ""

# Step 5: Docker Build (optional)
if [ "$1" == "--docker" ]; then
    echo -e "${BLUE}[Step 5]${NC} Building Docker image..."
    docker build -t ai-qa-faang-agent:latest .
    echo -e "${GREEN}✅ Docker image built${NC}"
    echo ""
fi

echo "========================================="
echo -e "${GREEN}✅ Pipeline completed successfully!${NC}"
echo "========================================="
echo ""
echo "📊 Reports & Artifacts:"
echo "  - Allure Report: target/allure-report/index.html"
echo "  - Code Coverage: target/site/jacoco/index.html"
echo "  - Test Results: target/surefire-reports/"
echo ""
echo "To run with Docker: ./run-local-pipeline.sh --docker"
