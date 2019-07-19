#!/bin/bash
set -euo pipefail


echo "--- :package: Downloading bk binary"
curl -Lfs -o bk https://github.com/buildkite/cli/releases/download/v1.0.0/bk-linux-amd64-1.0.0
chmod +x ./bk

echo "--- :package: Downloading built binary"
rm -rf pkg/*
buildkite-agent artifact download pkg/buildkite-agent-linux-amd64 .
mv pkg/buildkite-agent-linux-amd64 pkg/buildkite-agent
chmod +x pkg/buildkite-agent

export PATH="$PWD/pkg:$PATH"
./bk run --debug .buildkite/pipeline.bk-test.yml
