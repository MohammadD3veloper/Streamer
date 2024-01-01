#!/bin/bash

# Build docker files and adding them to local registery

function BuildAndPushRegistry {

}

# Run Kubernetes
function Run {
    kubectl apply -f kubernetes/development/celery.yml
    kubectl apply -f kubernetes/development/channel.yml
    kubectl apply -f kubernetes/development/django.yml
    kubectl apply -f kubernetes/development/postgres.yml
    kubectl apply -f kubernetes/development/redis.yml
    kubectl apply -f kubernetes/ingress/nginx.yml
}