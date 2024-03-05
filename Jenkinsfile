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
       stage('build') {
          steps {
            withCredentials([string(credentialsId: 'DOCKER', variable: 'docker')]) {
                sh 'docker login -u bhargavramaraju123 -p ${docker} '
                sh 'docker image build -t bhargavramaraju123/sivaji:${BUILD_ID} .'
                sh 'docker image push bhargavramaraju123/sivaji:${BUILD_ID}'
            }       
          }
       }
       stage('updated docker images') {
          steps {
            sh "cd ~/NOP/ && yq eval -i '.spec.template.spec.containers[0].image= \"bhargavramaraju123/sivaji:${BUILD_ID}\"' ~/NOP/Deployment.yaml"
            sh "cd ~/NOP/"
            sh "git add --all"
            sh 'git commit -m "updated to git docker images"'
            sh "git push --force origin main"
          }
       }
    }      
}
