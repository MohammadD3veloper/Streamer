#!/bin/bash

function main {
    # Pull image from docker
    docker pull $DOCKER_USERNAME/$DOCKER_REPONAME

    ls

    # Apply configurations to k8s
    kubectl apply -f kubernetes/deployments/celery.yml
    kubectl apply -f kubernetes/deployments/channels.yml
    kubectl apply -f kubernetes/deployments/django.yml
    kubectl apply -f kubernetes/deployments/postgres.yml
    kubectl apply -f kubernetes/deployments/redis.yml
    kubectl apply -f kubernetes/ingress/nginx.yml
}

main