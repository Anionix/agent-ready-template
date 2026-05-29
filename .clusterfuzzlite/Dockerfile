# Optional ClusterFuzzLite-compatible image for the repository fuzz harness.
# This is not part of the default runtime contract; use `mise run fuzz` locally.
FROM golang:1.22.12-bookworm@sha256:3d699e4d15d0f8f13c9195c0632a16702b8cbdece2955af1c23b37ae5d55a253

WORKDIR /src

COPY go.mod ./
COPY fuzz ./fuzz

ENV GOCACHE=/tmp/go-build

CMD ["go", "test", "./fuzz"]
