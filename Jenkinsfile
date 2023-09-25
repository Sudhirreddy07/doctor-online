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
