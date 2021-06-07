#!/bin/bash

set -euo pipefail

# USAGE: $0 <version> [tag...]
# * version is the full (i.e., patch-level) Composer version to build
# * tag is an additional image tag to use (e.g., 1 or latest)

repository=forumone/composer

# Save the major version specifically (we need it to target the Dockerfile)
version="$3"

# Capture the version and any other tags as --tag arguments for docker build
for tag in "$@"; do
  tag_args+=("--tag" "$repository:$tag")
done

echo '--- :docker: Build'
docker build  "./${version}" \
  "${tag_args[@]}"

if test "$BUILDKITE_BRANCH" == master && test "$BUILDKITE_PULL_REQUEST" == false; then
  echo "--- :docker: Push"
  docker push "$repository"
fi
