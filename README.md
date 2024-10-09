# aws-lambda-example

# Usage

```
./build.sh

aws-lambda-example-app

./docker-build.sh

./docker-run.sh

curl -d '{}' localhost:9000/2015-03-31/functions/function/invocations

./ecr-push.sh

./lambda-create.sh

./lambda-run.sh

aws ecr delete-repository --repository-name aws-lambda-example --region us-east-1 --force
```