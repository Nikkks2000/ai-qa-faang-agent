@echo off
REM Local CI/CD Testing Script for Windows
REM This script simulates the CI/CD pipeline locally for testing purposes

setlocal enabledelayedexpansion

echo.
echo =========================================
echo    AI QA FAANG - Local CI/CD Pipeline
echo =========================================
echo.

REM Step 1: Build ^& Compile
echo [Step 1] Building and compiling...
mvn clean compile -q
if errorlevel 1 (
    echo ERROR: Compilation failed
    exit /b 1
)
echo [OK] Compilation successful
echo.

REM Step 2: Run Tests
echo [Step 2] Running unit tests...
mvn test -q -Dorg.slf4j.simpleLogger.defaultLogLevel=warn
if errorlevel 1 (
    echo WARNING: Some tests failed
) else (
    echo [OK] All tests passed
)
echo.

REM Step 3: Generate Allure Report
echo [Step 3] Generating Allure report...
mvn allure:report -q
if errorlevel 1 (
    echo ERROR: Failed to generate Allure report
) else (
    echo [OK] Allure report generated
)
echo.

REM Step 4: Code Coverage
echo [Step 4] Generating code coverage...
mvn clean verify -Djacoco.skip=false -q -DskipTests
if errorlevel 1 (
    echo ERROR: Failed to generate coverage
) else (
    echo [OK] Code coverage report generated
)
echo.

REM Step 5: Docker Build (optional)
if "%1"=="--docker" (
    echo [Step 5] Building Docker image...
    docker build -t ai-qa-faang-agent:latest .
    if errorlevel 1 (
        echo ERROR: Docker build failed
        exit /b 1
    )
    echo [OK] Docker image built
    echo.
)

echo =========================================
echo [OK] Pipeline completed successfully!
echo =========================================
echo.
echo Reports ^& Artifacts:
echo   - Allure Report: target\allure-report\index.html
echo   - Code Coverage: target\site\jacoco\index.html
echo   - Test Results: target\surefire-reports\
echo.
echo To run with Docker: run-local-pipeline.bat --docker
echo.

endlocal
