// Package handler implemetns lambda handler.
package handler

import (
	"context"
	"log/slog"
)

// Version is lambda version.
const Version = "0.0.0"

// Input is lambda handler input.
type Input struct{}

// Output is lambda handler output.
type Output struct {
	Count int `json:"count"`
}

var counter Output

// HandleRequest is lambda handler.
func HandleRequest(_ /*ctx*/ context.Context, _ /*in*/ Input) (Output, error) {
	counter.Count++
	slog.Info("handler", "count", counter.Count)
	return counter, nil
}
