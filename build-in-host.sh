#!/usr/bin/env bash
docker build -t localhost:8443/django .
docker push localhost:8443/django
docker-compose up -d
