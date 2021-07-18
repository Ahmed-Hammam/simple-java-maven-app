def mvn
def server = Artifactory.server 'artifactory'
def rtMaven = Artifactory.newMavenBuild()
def buildInfo
pipeline {
  agent { label 'master' }
    tools {
      maven 'Maven'
      jdk 'JAVA_HOME'
    }
  options { 
    timestamps () 
    buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '10', numToKeepStr: '5')	
// numToKeepStr - Max # of builds to keep
// daysToKeepStr - Days to keep builds
// artifactDaysToKeepStr - Days to keep artifacts
// artifactNumToKeepStr - Max # of builds to keep with artifacts	  
}	  
/*environment {
    SONAR_HOME = "${tool name: 'sonar-scanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'}"
  }*/  

  stages {
    stage('Artifactory_Configuration') {
      steps {
        script {
		  rtMaven.tool = 'Maven'
		  //rtMaven.resolver releaseRepo: 'libs-release', snapshotRepo: 'libs-snapshot', server: server
		  buildInfo = Artifactory.newBuildInfo()
		  //rtMaven.deployer releaseRepo: 'libs-release-local', snapshotRepo: 'libs-snapshot', server: server
          buildInfo.env.capture = true
        }			                      
      }
    }
    stage('Execute_Maven') {
	  steps {
	    script {
		  rtMaven.run pom: 'pom.xml', goals: 'clean install -U -DskipTests', buildInfo: buildInfo
        }			                      
      }
    }	
    stage('SonarQube_Analysis') {
      steps {
	   /* script {
          scannerHome = tool 'sonar-scanner'
        }*/
        withSonarQubeEnv('sonar') {
      	  sh "./mvn sonarqube"
        }
      }	
    }	
	stage('Quality_Gate') {
	  steps {
	    timeout(time: 1, unit: 'MINUTES') {
		  waitForQualityGate abortPipeline: true
        }
      }
    }
}	
}
