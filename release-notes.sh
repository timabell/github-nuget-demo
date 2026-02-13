#!/bin/sh
# Preview git-cliff output

case "$1" in
  --bumped)
    git cliff --config .github/cliff.toml --bumped-version
    ;;
  --preview)
    git cliff --config .github/cliff.toml --unreleased
    ;;
  "")
    git cliff --config .github/cliff.toml --latest
    ;;
  *)
    echo "Unknown flag: $1" >&2
    echo "Usage: $0 [--bumped|--preview]" >&2
    exit 1
    ;;
esac
