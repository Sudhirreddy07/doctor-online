pipeline{
    agent any
    stages{
        stage("git colab"){
            steps{
                git branch: 'main', credentialsId: 'b1986d74-467e-4153-877d-bf6d081ead7a', url: 'https://github.com/Sudhirreddy07/doctor-online'            
            }
        }
        stage("maven build"){
            steps{
                  sh "mvn clean package" 

            }
        }
        stage("copy tomcat"){
            steps{
                  sshagent(['tomcat']) {
                    sh "scp -o StrictHostKeyChecking=no target/doctor-online.war ec2-user@172.31.46.80:/opt/tomcat9/webapps"
                    sh "ssh ec2-user@172.31.46.80 /opt/tomcat9/bin/shutdown.sh"
                    sh "ssh ec2-user@172.31.46.80 /opt/tomcat9/bin/startup.sh"
                }

            }
        }
    }
}
