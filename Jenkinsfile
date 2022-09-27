pipeline {

	agent none
	triggers {
		pollSCM 'H/1 * * * *'
	}

	parameters {
		booleanParam(name: 'SKIP', defaultValue: false, description: 'skip this build?')
	}

	options {
		timestamps()
		timeout(time: 5, unit: 'MINUTES')
		disableConcurrentBuilds()
		buildDiscarder(logRotator(numToKeepStr: '14'))
	}

	stages {

		stage("pre step") {
			environment { NAME = "Daneil Wu" }
			when { expression { return !params.SKIP } }
			steps {
				echo "My name is $NAME"
			}
		}

		stage("test") {
			steps {
		 		 echo "test"
			}
		}

		stage('Building django site docker image') {
			agent any
			steps{
				script {
					dockerImage = docker.build  "danielsite:latest"
				}
			}
		}


		stage("test django site") {
			agent {
				// usermod -aG docker jenkins
				// or chmod 777 /var/run/docker.sock
				docker { image 'danielsite:latest' }
			}
			steps {
				sh "python --version"
			}
		}

		stage("get python version") {
			agent {
				// usermod -aG docker jenkins
				// or chmod 777 /var/run/docker.sock
				docker { image 'python:3.10.7-alpine3.16' }
			}
			steps {
				sh "python --version"
			}
		}


	}

	post {
		always {
			echo "complete"
		}
	}
}
