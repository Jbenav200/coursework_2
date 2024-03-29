pipeline {
         environment{
                  registry='jonathanba95/coursework_2'
                  registryCredential='099d1692-9196-4ca3-b4e2-11ba202d87bf'
                  image=''
         }
         agent any
         stages {
                 stage('Checkout') {
                 steps {
                     echo 'Retrieving Jenkinsfile from the github repository.'
                     
                     checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'LocalBranch', localBranch: 'dummy']], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/jbenav200/coursework_2']]])
                 }
                 }
                 stage('SonarQube') {
                 environment{
                    scannerHome = tool 'SonarQube'
                 }
                 steps {
                    withSonarQubeEnv('SonarQube') {
                        sh "${scannerHome}/bin/sonar-scanner"
                    
                        timeout(time: 1, unit: 'HOURS') {

                        waitForQualityGate abortPipeline: true
                        }
                    }
                 }
                 }
                 stage('Building image') {
                 
                 steps {
                       script {
                        dockerImage = docker.build registry + ":$BUILD_NUMBER"
                        }

                 }
                 }
                 stage('Deploy Image') {
                 steps{
                    script {
                        docker.withRegistry( '', registryCredential ){
                            dockerImage.push()
                            }
                    }

                 }
                 
                }
                stage('Remove unused docker image'){
                steps{
                    sh "docker rmi $registry:$BUILD_NUMBER"
                }
                }
        }
}
