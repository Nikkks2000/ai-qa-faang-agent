pipeline {
    agent any

    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timeout(time: 1, unit: 'HOURS')
        timestamps()
    }

    parameters {
        booleanParam(name: 'DEPLOY_DOCKER', defaultValue: false, description: 'Build and Push Docker Image')
        string(name: 'DOCKER_REGISTRY', defaultValue: 'docker.io', description: 'Docker Registry URL')
    }

    environment {
        DOCKER_CREDENTIALS = credentials('docker-credentials')
        GIT_REPO = 'https://github.com/Nikkks2000/ai-qa-faang-agent.git'
        DOCKER_IMAGE = "${DOCKER_REGISTRY}/nikkks2000/ai-qa-faang-agent"
        BUILD_TAG = "${BUILD_NUMBER}-${GIT_COMMIT.take(7)}"
    }

    tools {
        maven 'Maven3.9.12'
        jdk 'JDK21'
    }

    stages {

        stage('📋 Checkout') {
            steps {
                echo "🔄 Cloning repository from GitHub..."
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/master']],
                    userRemoteConfigs: [[url: "${GIT_REPO}"]]
                ])
            }
        }

        stage('🔨 Build & Compile') {
            steps {
                echo "🏗️  Compiling source code with Java 21..."
                sh '''
                    mvn clean compile -q
                '''
            }
        }

        stage('🧪 Unit Tests & Code Coverage') {
            steps {
                echo "🧪 Running TestNG tests with Allure reporting..."
                sh '''
                    mvn test -q \
                        -Dorg.slf4j.simpleLogger.defaultLogLevel=warn \
                        -Dallure.link.type.issue.pattern=https://github.com/issues/%s
                '''
            }
        }

        stage('📊 Allure Report') {
            steps {
                echo "📈 Generating Allure Test Report..."
                allure([
                    includeProperties: false,
                    jdk: 'JDK21',
                    reportBuildPolicy: 'ALWAYS',
                    results: [[path: 'target/allure-results']],
                    name: "Allure Report #${BUILD_NUMBER}"
                ])
            }
        }

        stage('🐳 Docker Build & Push') {
            when {
                expression { params.DEPLOY_DOCKER == true }
            }
            steps {
                echo "🐳 Building Docker image..."
                sh '''
                    docker build -t ${DOCKER_IMAGE}:${BUILD_TAG} \
                                 -t ${DOCKER_IMAGE}:latest \
                                 --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
                                 --build-arg VCS_REF=$(git rev-parse --short HEAD) \
                                 --build-arg VERSION=${BUILD_TAG} \
                                 .
                '''

                echo "📤 Pushing image to Docker Registry..."
                sh '''
                    echo "${DOCKER_CREDENTIALS_PSW}" | docker login -u "${DOCKER_CREDENTIALS_USR}" --password-stdin ${DOCKER_REGISTRY}
                    docker push ${DOCKER_IMAGE}:${BUILD_TAG}
                    docker push ${DOCKER_IMAGE}:latest
                    docker logout ${DOCKER_REGISTRY}
                '''
            }
        }

        stage('🤖 AI Analysis') {
            steps {
                echo "🔍 Running AI-based analysis..."
                sh '''
                    if [ -f "target/allure-results/history.json" ]; then
                        echo "📊 Test history available for trend analysis"
                    fi
                '''
            }
        }

    }

    post {
        always {
            publishHTML([
                reportDir: 'target/allure-report',
                reportFiles: 'index.html',
                reportName: 'Allure Report'
            ])
            
            archiveArtifacts artifacts: 'target/allure-results/**', 
                             fingerprint: true,
                             allowEmptyArchive: true
            archiveArtifacts artifacts: 'target/site/jacoco/**',
                             fingerprint: true,
                             allowEmptyArchive: true
        }

        success {
            echo "✅ Pipeline completed successfully"
        }

        failure {
            echo "❌ Pipeline failed - check logs"
        }
    }
}