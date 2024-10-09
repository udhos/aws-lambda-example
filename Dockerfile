FROM golang:1.23.2-alpine3.20 AS build
# Copy dependencies list
COPY ./cmd/ /app/cmd
COPY go.mod go.sum /app/
WORKDIR /app
# Build with optional lambda.norpc tag
RUN go build -tags lambda.norpc -o main ./cmd/aws-lambda-example-handler
# Copy artifacts to a clean image
FROM public.ecr.aws/lambda/provided:al2023
COPY --from=build /app/main ./main
ENTRYPOINT [ "./main" ]
