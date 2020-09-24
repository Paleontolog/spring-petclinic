pipeline {
    agent none
    stages {
         stage('Build') {
            agent {
                node { 
		   label 'java-docker-slave'
       	     
		} 
            } 
            steps {
              git branch: 'main', credentialsId: 'git-creds', url: 'https://github.com/Paleontolog/spring-petclinic.git'
              sh 'ls'
              sh 'mvn --version'
              sh './mvnw package'
              sh 'ls'
              stash includes: 'target/**', name: 'compiledJAR'
              stash includes: 'Dockerfile', name: 'petcinic-jar-docker'
            }
        }
        stage('Example') {
             agent {
                    node { label 'master' } 
                }
                 
                steps {
                  //  dir('tmp'){
                                         
                          unstash 'petcinic-jar-docker'
                          unstash 'compiledJAR'
                          sh 'ls'
                          script {
                                def dockerHome = tool 'myDocker'
                             
                                env.PATH = "${dockerHome}/bin:${env.PATH}"
                             
                                def myDocker = docker.build("my-image:${env.BUILD_ID}")
                                      
                                myDocker.inside {
                                      sh 'ls'
                                }

               //    	 }
                    }
               }
        }
    }
}

