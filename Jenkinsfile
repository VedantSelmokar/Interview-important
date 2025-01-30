pipeline {
    agent any
    
    environment {
        SONARQUBE_SERVER = 'SonarQube'
        SONARQUBE_PROJECT_KEY = 'project_key'
        NEXUS_URL = 'http://nexus.example.com'
        NEXUS_REPO = 'maven-releases'
        DOCKER_IMAGE = 'docker_image'
    }
    
    stages {
        stage('git checkout') {
            steps {
                git branch: "main", url: "https://github.com/VedantSelmokar/project.git"
            }
        }
        
        stage('compile') {
            steps {
                sh "mvn compile -DskipTests=true"
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv(credentialsId: 'sonarqube-token') {
                    sh 'mvn sonar:sonar -Dsonar.projectKey=${SONARQUBE_PROJECT_KEY}'
                }
            }
        }

        stage('Build') {
            steps {
                sh "mvn package -DskipTests=true"
            }
        }
        
        stage('Upload Artifact to Nexus') {
            steps {
                sh "mvn deploy -DaltDeploymentRepository=${NEXUS_REPO}::default::${NEXUS_URL}/repository/${NEXUS_REPO}"
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    def artifact = sh(script: "ls target/*.jar | head -n 1", returnStdout: true).trim()
                    sh "docker build -t ${DOCKER_IMAGE}:latest --build-arg JAR_FILE=${artifact} ."
                }
            }
        }

        stage('Push image to Hub'){
            steps{
                script{
                   withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                   sh 'docker login -u vedantselmokar -p ${dockerhubpwd}'}
                   sh 'docker push vedantselmokar/docker_image:latest'
                }
            }
        }
        stage('EKS and Kubectl configuration'){
            steps{
                script{
                    sh 'aws eks update-kubeconfig --region us-east-1 --name vedant-cluster'
                }
            }
        }
        stage('Deploy to k8s'){
            steps{
                script{
                    sh 'kubectl apply -f deploymentservice.yml'
                }
            }
        }
        
    }
    
    post {
        success {
            echo 'Build, Analysis, and Deployment Successful!'
        }
        failure {
            echo 'Build Failed!'
        }
    }
}
