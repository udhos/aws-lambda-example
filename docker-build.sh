#!/bin/bash

version=$(go run ./cmd/aws-lambda-example-app -version | awk '{print $2}')

docker build --platform linux/amd64 -t aws-lambda-example:$version .
