pipeline {
    agent any
    environment {
        YC_TOKEN = credentials('YANDEX_TOKEN')
        SSH_PUBLIC_KEY = credentials('SSH_PUBLIC_KEY')
    }
    stages {
        stage('Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Plan') {
            steps {
                sh 'terraform plan -var "token=$YC_TOKEN" -var "ssh_public_key=$SSH_PUBLIC_KEY"'
            }
        }
        stage('Apply') {
            steps {
                sh 'terraform apply -auto-approve -var "token=$YC_TOKEN" -var "ssh_public_key=$SSH_PUBLIC_KEY"'
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}