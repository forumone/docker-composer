#!/bin/bash

set -euo pipefail
shopt -s extglob

# Matrix of supported Composer versions. The array keys are the full (patch-level)
# version of Composer, and the values are any additional versions to use as tags - with
# the sole exception of minor versions, since those can be auto-generated safely. This
# versioning scheme matches what's on the Docker Hub.
declare -A composer_versions=(
  [1.7.3]=""
  [1.8.6]=""
  [1.9.3]=""
  [1.10.4]="1 latest"
)

# Usage: create-step <version>
# * version is a full (patch-level) version specifier
function create-step() {
  local version="$1"

  # Removes the patch level from the specifier (X.Y.Z ==> X.Y), which we use as a step
  local minor="${version%.+([0-9])}"

  cat <<YAML
  - label: ":docker: :composer: v$minor"
    commands:
      - bash .buildkite/build.sh $version $minor ${composer_versions[$version]}
    plugins:
      - seek-oss/aws-sm#v2.0.0:
          env:
            DOCKER_LOGIN_PASSWORD: buildkite/dockerhubid
      - docker-login#v2.0.1:
          username: f1builder
          password-env: DOCKER_LOGIN_PASSWORD
YAML
}

# Create a build step for each Composer version
{
  echo "steps:"
  for version in "${!composer_versions[@]}"; do
    create-step "$version"
  done
} | buildkite-agent pipeline upload
