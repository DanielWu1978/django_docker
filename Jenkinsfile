pipeline {
	agent {
		// usermod -aG docker jenkins
		// or chmod 777 /var/run/docker.sock
		docker { image 'python:3.10.7-alpine3.16' }
	}

	triggers {
		pollSCM 'H/1 * * * *'
	}

	parameters {
		booleanParam(name: 'SKIP', defaultValue: true, description: 'skip this build?')
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
	}

	stages {
		stage("test") {
			steps {
		 		 echo "test"
			}
		}
		stage("get python version") {
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
