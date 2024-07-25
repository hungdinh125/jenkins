properties([pipelineTriggers([githubPush()])])
node {
    checkout ([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'hungdinh.dean', url: 'https://github.com/hungdinh125/jenkins.git']]])

    stage('Build') {
        echo 'Build stage'
        sh "docker run -dit --name ansible_git netdevops/ansible_git_v1"
        
        // Wait for the container to be fully ready
        sleep(time: 30, unit: 'SECONDS')
        
        // Clone the repository inside the container
        sh 'docker exec -i ansible_git /bin/sh -c "git clone https://github.com/hungdinh125/jenkins.git"'
    }

    stage('Test') {
        echo 'Test stage'
        
        // Run ansible-playbook commands inside the container
        sh 'docker exec -i ansible_git /bin/sh -c "ansible-playbook /jenkins/config_interfaces_bgp.yaml -i /jenkins/inventory --syntax-check"'
        sh 'docker exec -i ansible_git /bin/sh -c "ansible-playbook /jenkins/config_interfaces_bgp.yaml -i /jenkins/inventory --check"'
    }

    stage('Clean up') {
        echo 'Clean up stage'
        sh "docker rm -f ansible_git"
    }
}
