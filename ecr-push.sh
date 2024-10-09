#!/bin/bash

repo_name=aws-lambda-example

version=$(go run ./cmd/aws-lambda-example-app -version | awk '{print $2}')

account_id=$(aws sts get-caller-identity | gojq -r .Account)

ecr_tag=$account_id.dkr.ecr.us-east-1.amazonaws.com/$repo_name:$version

cat <<EOF
repo: $repo_name
version: $version
account_id: $account_id
ecr_tag: $ecr_tag
EOF

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $account_id.dkr.ecr.us-east-1.amazonaws.com

aws ecr create-repository --repository-name $repo_name --region us-east-1

docker tag $repo_name:$version $ecr_tag

docker push $ecr_tag
