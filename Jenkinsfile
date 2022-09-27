pipeline {

	agent any
	triggers {
		pollSCM 'H/1 * * * *'
	}

	parameters {
		booleanParam(name: 'pushToECR', defaultValue: false, description: 'push image to AWS ECR?')
	}

	environment {
        AWS_ACCOUNT_ID="617815228888"
        AWS_DEFAULT_REGION="us-east-1"
        IMAGE_REPO_NAME="danielsite"
        IMAGE_TAG="v1"
        REPOSITORY_URI = "617815228888.dkr.ecr.us-east-1.amazonaws.com/danielsite"
		DJANGO_PORT = "8000"
		MAPPING_PORT = "9000"
		AWS_CREDENTIALS = "ecr:us-east-1:aws-credentials"
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


		stage("test django site using curl") {
			steps {
				sh "docker stop test_run || echo 'stopped the test_run docker instance'"
				sh "docker rm test_run || echo 'removed the test_run docker instance'"
				sh "docker run -d --name test_run -p $MAPPING_PORT:$DJANGO_PORT danielsite:latest"
				sh "sleep 5"
				sh "curl http://localhost:$MAPPING_PORT"
				sh "docker stop test_run || echo 'stopped the test_run docker instance'"
				sh "docker rm test_run || echo 'removed the test_run docker instance'"
			}
		}

		stage("verify django process is running") {
			agent {
				// usermod -aG docker jenkins
				// or chmod 777 /var/run/docker.sock
				docker {
					image 'danielsite:latest'
					args "-p $MAPPING_PORT:$DJANGO_PORT"
				}
			}
			steps {
				sh "ps -ef|grep manager.py"
			}
		}

         stage('push the image to ecr') {
            steps {
				when { expression { return !params.pushToECR} }
                script {
					    docker.withRegistry("https://$REPOSITORY_URI", "$AWS_CREDENTIALS") {
							docker.image("$IMAGE_REPO_NAME").push('latest')
					    }
					// sh """aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"""
                }

            }
        }

	}

	post {
		always {
			echo "complete"
		}
	}
}
