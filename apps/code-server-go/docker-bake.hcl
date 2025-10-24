target "docker-metadata-action" {}

variable "APP" {
  default = "code-server-go"
}

variable "VERSION" {
  // renovate: datasource=github-releases depName=code/code-server
  default = "4.105.1"
}

variable "SOURCE" {
  default = "https://github.com/coder/code-server"
}

group "default" {
  targets = ["image-local"]
}

target "image" {
  inherits = ["docker-metadata-action"]
  args = {
    VERSION = "${VERSION}"
  }
  labels = {
    "org.opencontainers.image.source" = "${SOURCE}"
  }
}

target "image-local" {
  inherits = ["image"]
  output = ["type=docker"]
  tags = ["${APP}:${VERSION}"]
}

target "image-all" {
  inherits = ["image"]
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
}