pipeline {
	agent {
		docker { image 'alpine:3.16' }
	}

	triggers {
		pollSCM 'H/1 * * * *'
	}

	options {
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
            echo "python -version"
		}

	}

	post {
		always {
			echo "complete"
		}
	}
}
