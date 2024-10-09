// Package main implements the tool.
package main

import (
	"context"
	"flag"
	"fmt"
	"log/slog"

	"github.com/udhos/aws-lambda-example/cmd/internal/handler"
)

func main() {

	var version bool
	flag.BoolVar(&version, "version", false, "show version")
	flag.Parse()

	if version {
		fmt.Printf("version %s\n", handler.Version)
		return
	}

	out, err := handler.HandleRequest(context.TODO(), handler.Input{})
	if err != nil {
		slog.Error("handler error", "error", err.Error())
	}
	fmt.Println("Lambda handler output:")
	fmt.Println(out)
}
