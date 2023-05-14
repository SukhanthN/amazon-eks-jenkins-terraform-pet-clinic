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
        stage ("build image") {
            steps {
                script {
                    sh "docker build -t sukhanth1/pet-clinc:2.0 ."
                }
            }
        }
        /*stage ("docker push") {
            steps {
                script {
                    withCredentials([string(credentialsId: 'newdocker', variable: 'docker')]) {
                    sh "docker login -u sukhanth1 -p ${docker}"
                    sh "docker push sukhanth1/pet-clinc:2.0"
}
                }
            }
        }*/
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
    }
}
