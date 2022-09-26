pipeline {
	agent none

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

	}

	post {
		always {
			        echo "complete"
		}
	}
}
