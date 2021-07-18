pipeline {
  agent any
  tools {
    maven 'Maven'
  }
  stages {
    stage('Build') {
      steps {
        sh 'mvn -B -DskipTests clean package'
      }
    }
    stage('Build Docker Image'){
    steps{
      sh 'docker.build -t dileep95/dileep-spring:$BUILD_NUMBER .'
    }
  }
  }
}
