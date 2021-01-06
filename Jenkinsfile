pipeline {

    agent any

    environment {
        GIT_REPO = "https://github.com/julianddd/terraform-aws-s3-webapp"

    }

    stages {
        stage('Preparation') {
            steps {
                git "${GIT_REPO}"
               bat "ls"
            }
        }

        stage('Terraform Init') {
            steps {
                bat "cat main.tf"
                bat "terraform init"
            }
        }
        stage('Terraform Apply') {
            steps {
                bat "terraform apply -auto-approve"
            }
        }
    }
}
