pipeline {

    agent any

    environment {
        GIT_REPO = "https://github.com/julianddd/terraform-aws-s3-webapp"

    }

    stages {
        stage('Preparation') {
            steps {
                git "${GIT_REPO}"
               sh "ls"
                sh 'curl -o tf.zip https://releases.hashicorp.com/terraform/0.12.28/terraform_0.12.28_linux_amd64.zip ; yes | unzip tf.zip'
                sh './terraform version'
            }
        }

        stage('Terraform Init') {
            steps {
                sh "cat main.tf" 
                sh "./terraform init"
            }
        }
        stage('Terraform Apply') {
            steps {
                sh "./terraform apply -auto-approve"
            }
        }
    }
}
