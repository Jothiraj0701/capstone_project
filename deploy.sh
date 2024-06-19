#!/bin/bash

# Ensure necessary environment variables are set
if [ -z "$KEYFILE" ] || [ -z "$SSH_USER" ] || [ -z "$EC2_INSTANCE_IP" ]; then
    echo "Missing necessary environment variables (KEYFILE, SSH_USER, EC2_INSTANCE_IP)"
    exit 1
fi

# SSH into your EC2 instance and run the deployment commands
ssh -o StrictHostKeyChecking=no -i "$KEYFILE" "$SSH_USER@$EC2_INSTANCE_IP" << EOF
    cd /home/ubuntu/capstone_project
    docker-compose down
    docker-compose pull
    docker-compose up -d
EOF
