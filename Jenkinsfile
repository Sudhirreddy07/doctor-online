pipeline {
    agent any
    parameters {
        choice(choices: ['Prod', 'Dev'], description: 'Choose the environment to deploy', name: 'envName')
    }

    stages {
        stage("Maven Build") {
            when {
                expression { params.envName == "Dev" }
            }
            steps {
                sh "mvn clean package"
            }
        }

        stage("Nexus Upload") {
            when {
                expression { params.envName == "Prod" }
            }
            steps {
                script {
                    def pom = readMavenPom file: 'pom.xml'
                    def pom_version_array = pom.version.split('\\.')

                    // Increment the minor version
                    pom_version_array[1] = "${pom_version_array[1].toInteger() + 1}"
                    
                    // Join the version parts back together
                    pom.version = pom_version_array.join('.')

                    writeMavenPom model: pom

                    nexusArtifactUploader artifacts: [[
                        artifactId: 'doctor-online',
                        classifier: '',
                        file: 'target/doctor-online.war',
                        type: 'war'
                    ]],
                    credentialsId: 'nexus',
                    groupId: 'in.javahome',
                    nexusUrl: 'http://54.242.184.150:8081',
                    nexusVersion: 'nexus3',
                    protocol: 'http',
                    repository: 'doctor-online-release',
                    version: pom.version // Use the version from the POM
                }
            }
        }

        stage("Deploy To Dev") {
            when {
                expression { params.envName == "Dev" }
            }
            steps {
                echo "Deploying to dev"
                // Add your deployment steps for the 'Dev' environment here
            }
        }
    }
}
