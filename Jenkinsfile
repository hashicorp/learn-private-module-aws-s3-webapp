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
                bat 'curl -o tf.zip https://releases.hashicorp.com/terraform/0.12.28/terraform_0.12.28_linux_amd64.zip ; yes | unzip tf.zip'
                bat 'terraform version'
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
