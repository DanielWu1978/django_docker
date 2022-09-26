pipeline {
	agent {
		// usermod -aG docker jenkins
		// or chmod 777 /var/run/docker.sock
		docker { image 'alpine:3.16' }
	}

	triggers {
		pollSCM 'H/1 * * * *'
	}

	options {
		timestamps()
		timeout(time: 5, unit: 'MINUTES')
		disableConcurrentBuilds()
		buildDiscarder(logRotator(numToKeepStr: '14'))
	}

	stages {
		stage("test") {
			steps {
		 		 echo "test"
			}
		}
		stage("get python version") {
			steps {
				sh "python -version"
			}
		}

	}

	post {
		always {
			echo "complete"
		}
	}
}
