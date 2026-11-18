#!/bin/sh
# Detect explicit version bump from commit footers since last tag
# Outputs: major, minor, patch, or nothing if no footer found
#
# Usage: Add a footer line "bump: major", "bump: minor" or "bump: patch"
# to any commit. Any of these forces a release even if no commits are
# otherwise release-worthy.
#
# Why not use git-cliff's custom_minor_increment_regex?
# git-cliff's regex only matches against the conventional commit TYPE
# (the part before ':', '!', or '('), not the full commit message or body.
# This means footers like "bump: minor" can't be matched, and we'd have to
# use commit types like "minor:" which conflicts with semantic types like
# "feat:" or "fix:" that we want in the changelog.

LAST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "")

if [ -z "$LAST_TAG" ]; then
  COMMITS=$(git log --format=%B)
else
  COMMITS=$(git log "$LAST_TAG"..HEAD --format=%B)
fi

for type in major minor patch; do
  if echo "$COMMITS" | grep -qE "^bump: $type$"; then
    echo "$type"
    exit 0
  fi
done
