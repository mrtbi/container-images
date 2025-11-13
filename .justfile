#!/usr/bin/env -S just --justfile

set quiet := true
set shell := ['/bin/zsh', '-eu', '-o', 'pipefail', '-c']

export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE := "/var/run/docker.sock"
export TESTCONTAINERS_HOST_OVERRIDE := `colima ls docker -j | jq -r '.address'`
export DOCKER_HOST := "unix://"+env('HOME')+"/.config/colima/docker/docker.sock"

bin_dir := justfile_dir() + '/.bin'

[private]
default:
  just --list

[doc('Build and test an app locally')]
[working-directory('.cache')]
local-build app:
    rsync -aqIP {{ justfile_dir() }}/include/ {{ justfile_dir() }}/apps/{{ app }}/ .
    @docker buildx bake --no-cache --metadata-file docker-bake.json --set="*.output=type=docker" --load
    TEST_IMAGE="$(jq -r '."image-local"."image.name" | sub("^docker.io/library/"; "")' docker-bake.json)" go test -v {{ justfile_dir() }}/apps/{{ app }}/...

[doc('Trigger a remote build')]
remote-build app release="false":
  gh workflow run release.yaml -f app={{app}} -f release={{release}}
