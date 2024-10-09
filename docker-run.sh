#!/bin/bash

cat <<EOF
Para testar:

curl -d '{}' localhost:9000/2015-03-31/functions/function/invocations

EOF

version=$(go run ./cmd/aws-lambda-example-app -version | awk '{print $2}')

docker run --rm -p 9000:8080 \
    --entrypoint /usr/local/bin/aws-lambda-rie \
    aws-lambda-example:$version ./main
