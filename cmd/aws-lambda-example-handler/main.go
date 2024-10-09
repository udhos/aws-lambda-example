// Package main implements the tool.
package main

import (
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/udhos/aws-lambda-example/cmd/internal/handler"
)

func main() {
	lambda.Start(handler.HandleRequest)
}
