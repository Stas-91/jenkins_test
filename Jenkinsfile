pipeline {
    agent any
    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Choose whether to apply or destroy the infrastructure')
    }
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
                sh 'terraform plan -var "token=$YC_TOKEN" -var "ssh_public_key=$SSH_PUBLIC_KEY" -out=tfplan'
            }
        }
        stage('Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                sh 'terraform apply -auto-approve "tfplan"'
            }
        }
        stage('Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                sh 'terraform destroy -auto-approve -var "token=$YC_TOKEN" -var "ssh_public_key=$SSH_PUBLIC_KEY"'
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}