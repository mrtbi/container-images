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
		testhelpers.TestCommandSucceeds(t, ctx, image, nil, "/bin/sh", "go -v")
	})
}
