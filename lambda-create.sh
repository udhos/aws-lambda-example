#!/bin/bash

repo_name=aws-lambda-example

lambda_function=aws-lambda-example

version=$(go run ./cmd/aws-lambda-example-app -version | awk '{print $2}')

account_id=$(aws sts get-caller-identity | gojq -r .Account)

ecr_tag=$account_id.dkr.ecr.us-east-1.amazonaws.com/$repo_name:$version

cat <<EOF
lambda_function: $lambda_function
version: $version
account_id: $account_id
ecr_tag: $ecr_tag
EOF

aws lambda delete-function \
  --function-name $lambda_function \

aws iam detach-role-policy \
    --role-name $lambda_function \
    --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

aws iam delete-role \
  --role-name $lambda_function

aws iam create-role \
  --role-name $lambda_function \
  --assume-role-policy-document '{"Version": "2012-10-17","Statement": [{ "Effect": "Allow", "Principal": {"Service": "lambda.amazonaws.com"}, "Action": "sts:AssumeRole"}]}'

aws iam attach-role-policy \
    --role-name $lambda_function \
    --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

interval=5
echo sleeping 5 seconds
sleep 5

aws lambda create-function \
  --function-name $lambda_function \
  --package-type Image \
  --code ImageUri=$ecr_tag \
  --role arn:aws:iam::$account_id:role/$lambda_function
