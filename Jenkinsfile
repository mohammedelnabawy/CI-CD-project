pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-west-2' 
    }

    stages {
        stage('Terraform Init') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-credentials', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    script {
                        sh 'terraform init \
                            -backend-config="access_key=${AWS_ACCESS_KEY_ID}" \
                            -backend-config="secret_key=${AWS_SECRET_ACCESS_KEY}"'
                    }
                }
            }
        }
        stage('after') {
            steps {
                sh 'sleep 5'
            }
        }

        // Add additional stages for your Terraform pipeline
    }
}
