pipeline {
    agent any 
    stages {
        stage ('git checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/SukhanthN/pet-clinic.git']])
            }
        }   
        stage("build") {
            steps {
                sh "mvn clean install"
            }
        }
        stage ("Code Review") {
            steps {
                withSonarQubeEnv('SonarQube') {
                bat 'mvn sonar:sonar' 
                }   
            }
        }
        stage ("build image") {
            steps {
                script {
                    sh "docker build -t sukhanth1/pet-clinc:2.0 ."
                }
            }
        }
        stage('Push image to Hub'){
            steps {
                script {
                   withCredentials([string(credentialsId: 'docker_pwd', variable: 'docker')])  {
                   sh 'docker login -u sukhanth1 -p ${docker}'
}
                   sh 'docker push sukhanth1/pet-clinc:2.0'
                }
            }
        }
        stage ("k8s deploy") {
            steps {
                script {
                    kubernetesDeploy (configs: 'petclinc_nodeport.yml',kubeconfigId: 'll')
                }
            }
        }
        stage ("Save Artifact") {
            steps {
                nexusArtifactUploader artifacts: [[artifactId: 'taxi-booking-1.0.1', classifier: '', file: 'target/taxi-booking-1.0.1.war', type: 'war']], credentialsId: 'nexus', groupId: 'com.example.maven-project', nexusUrl: 'localhost:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'sukhanth', version: '1.0-SNAPSHOT'
            }
        }
    }
}
