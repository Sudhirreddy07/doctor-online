pipeline{
    agent any
    parameters {
      choice choices: [ 'Prod','Dev'], description: 'Choose the environment to deploy', name: 'envName'
    }

    stages{
        stage("Maven Build"){
            when {
                expression { params.envName == "Dev" }
            }
            steps{
               sh "mvn clean package" 
            }
        }
        stage("nexus upload"){
            when {
                expression { params.envName == "Prod" }
            }
            steps{
                script{
                    def pom = readMavenPom file: 'pom.xml'
                    def version = pom.version
                    def repoName = "doctor-online-release"
                    if(params.envName == "Prod"){
                       repoName = "doctor-online-release"
                    }
                    elif{
                       repoName = "doctor-online-snapshot"
                    }
                        
                    
                    pom_version_array = pom.version.split('\\.')
                    
                    // You can choose any part of the version you want to update
                    pom_version_array[1] = "${pom_version_array[1]}".toInteger() + 1
                    
                    pom.version = pom_version_array.join('.')
                    
                    writeMavenPom model: pom
                    
                nexusArtifactUploader artifacts: [[artifactId: 'doctor-online', classifier: '', file: 'target/doctor-online.war', type: 'war']],
                credentialsId: 'nexus',
                groupId: 'in.javahome',
                nexusUrl: '54.242.184.150:8081',
                nexusVersion: 'nexus3',
                protocol: 'http', 
                repository: rapoName,
                version: '1.0-SNAPSHOT'
            
                }
               }
        }
        stage("Deploy To Dev"){
            when {
                expression { params.envName == "Dev" }
            }
            steps{
                echo params.envName
                echo "Deploy to dev"
            }
        }
     
    }
}
