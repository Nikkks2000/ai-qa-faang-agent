FROM maven:3.9.6-eclipse-temurin-21 AS builder

WORKDIR /app

# Copy pom.xml and download dependencies (cache layer)
COPY pom.xml .
COPY testng.xml .
RUN mvn dependency:go-offline -q

# Copy source code
COPY src ./src

# Build and run tests, generate Allure results
RUN mvn clean verify -q -DskipTests=false

#------- FINAL IMAGE --------
FROM eclipse-temurin:21-jdk-jammy

WORKDIR /app

# Copy test results and reports from builder
COPY --from=builder /app/target ./target
COPY --from=builder /app/pom.xml .
COPY --from=builder /app/testng.xml .
COPY --from=builder /app/src ./src

# Install curl for health checks
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Set labels for container metadata
LABEL maintainer="QA Team" version="1.0" description="AI QA FAANG Agent - Java 21 with TestNG and Allure"

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD java -version 2>/dev/null || exit 1

# Entry point - execute tests if provided, otherwise keep container running
ENTRYPOINT ["java", "-cp", "target/classes:target/test-classes:/app/target/dependency/*", "com.faang.ai.TestRunner"]
CMD []