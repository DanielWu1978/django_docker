pipeline {
	agent none

	triggers {
		pollSCM 'H/10 * * * *'
	}

	options {
		disableConcurrentBuilds()
		buildDiscarder(logRotator(numToKeepStr: '14'))
	}

	stages {
		stage("test") {
			step {
		 		 echo "test"
			}
		}

	}

	post {
        echo "complete"
	}
}
