#!/bin/bash

function checkroot {
    if [ "$UID" != 0 ]; then
        echo -e 'You must to run this script by root user.'
        exit
    fi
}


function main {
    # Pull image from docker
    sudo docker pull $DOCKER_USERNAME/$DOCKER_REPONAME

    # Apply configurations to k8s
    kubectl apply -f kubernetes/development/celery.yml
    kubectl apply -f kubernetes/development/channel.yml
    kubectl apply -f kubernetes/development/django.yml
    kubectl apply -f kubernetes/development/postgres.yml
    kubectl apply -f kubernetes/development/redis.yml
    kubectl apply -f kubernetes/ingress/nginx.yml
}