#!/bin/bash

aws lambda invoke --function-name aws-lambda-example response.json

echo response.json:
cat response.json
echo
