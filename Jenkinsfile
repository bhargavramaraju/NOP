pipeline {
    agent { label 'DOTNET'}
    stages {
       stage('clean') {
          steps {
            cleanWs()
          }
       }
       stage('git') {
           steps {
             checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/bhargavvegesna/NOP.git']])
           }
       } 
    }
}
