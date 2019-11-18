#!/bin/bash

set -euo pipefail

# USAGE: $0 <version> [tag...]
# * version is the full (i.e., patch-level) Composer version to build
# * tag is an additional image tag to use (e.g., 1 or latest)

repository=forumone/composer

# Save the version specially (we need it as a build arg)
version="$1"
shift

# Capture the version and any other tags as --tag arguments for docker build
tag_args=("--tag" "$repository:$version")
for tag in "$@"; do
  tag_args+=("--tag" "$repository:$tag")
done

echo '--- :docker: Build'
docker build . \
  --build-arg "COMPOSER_VERSION=$version" \
  "${tag_args[@]}"

if test "$BUILDKITE_BRANCH" == master && test "$BUILDKITE_PULL_REQUEST" == false; then
  echo "--- :docker: Push"
  docker push "$repository"
fi
