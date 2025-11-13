package main

import (
	"context"
	"testing"

	"github.com/mrtbi/container-images/testhelpers"
)

func Test(t *testing.T) {
	ctx := context.Background()
	image := testhelpers.GetTestImage("ghcr.io/mrtbi/code-server-go:rolling")

	t.Run("Go binary version check", func(t *testing.T) {
		// Pass the entire shell command as a single string after -c so the shell executes
		// `go version` (not `go` with an extra positional argument `version`).
		testhelpers.TestCommandSucceeds(t, ctx, image, nil, "/bin/sh", "-c", "go version")
	})
}
