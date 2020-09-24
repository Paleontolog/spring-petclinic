pipeline {
    agent none
    stages {
         stage('Build') {
            agent {
                node { 
		   label 'java-docker-slave'
       	           args '-v $HOME/.m2:/root/.m2'
		} 
            } 
            steps {
              git branch: 'main', credentialsId: 'git-creds', url: 'https://github.com/Paleontolog/spring-petclinic.git'
              sh 'ls'
              sh 'mvn --version'
              sh 'mvn clean compile'
              stash includes: '/target/spring-petclinic-2.3.0.BUILD-SNAPSHOT.jar', name: 'compiledJAR'
              stash includes: 'Dockerfile', name: 'petcinic-jar-docker'
            }
        }
        stage('Example') {
             agent {
                    node { label 'master' } 
                }
                 
                steps {
                    dir('tmp'){
                                          
                          sh 'ls'
                          unstash 'petcinic-jar-docker'
                          unstash 'compiledJAR'
                          script {
                                def dockerHome = tool 'myDocker'
                             
                                env.PATH = "${dockerHome}/bin:${env.PATH}"
                             
                                def myDocker = docker.build("my-image:${env.BUILD_ID}")
                                      
                                myDocker.inside {
                                      sh 'ls'
                                }

                   	 }
                    }
               }
        }
    }
}

