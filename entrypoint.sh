#!/bin/bash

function main {
    # Pull image from docker
    docker pull $DOCKER_USERNAME/$DOCKER_REPONAME

    ls

    # Apply configurations to k8s
    kubectl apply -f kubernetes/development/celery.yml
    kubectl apply -f kubernetes/development/channel.yml
    kubectl apply -f kubernetes/development/django.yml
    kubectl apply -f kubernetes/development/postgres.yml
    kubectl apply -f kubernetes/development/redis.yml
    kubectl apply -f kubernetes/ingress/nginx.yml
}

main