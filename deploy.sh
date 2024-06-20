#!/bin/bash
# SSH into your EC2 instance and run the deployment commands
ssh -i C:\Users\jothiraj\Downloads\testvm.pem ubuntu@3.109.49.240 << EOF
    cd /home/ubuntu/capstone_project
    docker-compose down
    docker-compose pull
    docker-compose up -d
EOF
