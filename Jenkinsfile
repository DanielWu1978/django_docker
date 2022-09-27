pipeline {

	agent any
	triggers {
		pollSCM 'H/1 * * * *'
	}

	parameters {
		booleanParam(name: 'SKIP', defaultValue: false, description: 'skip this build?')
	}

	environment {
        AWS_ACCOUNT_ID="617815228888"
        AWS_DEFAULT_REGION="us-east-1"
        IMAGE_REPO_NAME="danielsite"
        IMAGE_TAG="v1"
        REPOSITORY_URI = "617815228888.dkr.ecr.us-east-1.amazonaws.com/danielsite"
		DJANGO_PORT = "8000"
		MAPPING_PORT = "9000"
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
			steps{
				script {
					dockerImage = docker.build  "danielsite:latest"
				}
			}
		}


		stage("verify django process is running") {
			agent {
				// usermod -aG docker jenkins
				// or chmod 777 /var/run/docker.sock
				docker {
					image 'danielsite:latest'
					args "-p 9000:8000"
					// args  "-p " + $MAPPING_PORT + ":" + $DJANGO_PORT
				}
			}
			steps {
				sh "ps -ef|grep manager.py"
			}
		}

		stage("test django site using curl") {
			agent any
			steps {
				sh "docker run -d --name -p 9000:8000 danielsite:latest"
				sh "sleep 5"
				sh "curl http://localhost:$DJANGO_PORT"
				sh "docker stop --name"
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
