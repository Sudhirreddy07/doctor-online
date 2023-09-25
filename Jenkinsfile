pipeline{
    agent any
    stages{
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
