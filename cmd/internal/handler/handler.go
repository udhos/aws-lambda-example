// Package handler implemetns lambda handler.
package handler

import (
	"context"
	"log/slog"
	"time"

	"github.com/udhos/lambdacache/lambdacache"
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

	value, _, err := cache.Get("key1")
	if err != nil {
		slog.Error("cache error", "error", err)
	}

	slog.Info("handler", "count", counter.Count, "key1", value)
	return counter, nil
}

// in lambda function GLOBAL context: create cache
var cache = newCache()

func newCache() *lambdacache.Cache {
	options := lambdacache.Options{
		Retrieve: getInfo,
	}
	return lambdacache.New(options)
}

// getInfo retrieves key value when there is a cache miss
func getInfo(key string) (interface{}, time.Duration, error) {
	time.Sleep(500 * time.Millisecond) // add fake latency
	const ttl = 1 * time.Minute        // per-key TTL
	return key, ttl, nil
}
