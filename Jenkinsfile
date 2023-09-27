pipeline{
    agent any
    parameters {
      choice choices: ['Dev', 'Test', 'Prod'], description: 'Choose the environment to deploy', name: 'envName'
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
            steps{
                script{
                    def pom = readMavenPom file: 'pom.xml'
                    def version = pom.version
                    def repoName = "doctor-online-release"
                    if(version.endsWith("SNAPSHOT")){
                       repoName = "doctor-online-snapshot"
                    }
                    
                nexusArtifactUploader artifacts: [[artifactId: 'doctor-online', classifier: '', file: 'target/doctor-online.war', type: 'war']],
                credentialsId: 'nexus',
                groupId: 'in.javahome',
                nexusUrl: '54.242.184.150:8081',
                nexusVersion: 'nexus3',
                protocol: 'http', 
                repository: 'doctor-online-snapshot',
                version: '1.0-SNAPSHOT'
            
                }
                
               }
        
        }
        
        stage("copy tomcat"){
            steps{
                  sshagent(['tomcat']) {
                    sh "scp -o StrictHostKeyChecking=no target/doctor-online.war ec2-user@54.80.252.4:/opt/tomcat9/webapps"
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
        stage("Deploy To Test"){
            when {
                expression { params.envName == "Test" }
            }
            steps{
                echo "Deploy to test"
            }
        }
        stage("Deploy To Prod"){
            when {
                expression { params.envName == "Prod" }
            }
            steps{
                echo "Deploy to prod"
            }
        }
    }
}
