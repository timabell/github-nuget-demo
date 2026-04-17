#!/bin/sh
set -e # exit on error

if ! git diff --cached --quiet; then
  echo "Aborted: staged changes detected in git"
  exit 1
fi

latest=`mise ls-remote dotnet-core | grep -P '^\d+\.\d+\.\d+$' | sort --version-sort | tail -n 1`
echo "Updating to dotnet-core@$latest"

mise use "dotnet-core@$latest"

# Extract major version (e.g., "10" from "10.0.100")
major_version=$(echo "$latest" | cut -d. -f1)
target_framework="net${major_version}.0"
echo "Updating TargetFramework to $target_framework"

# Update test & example project (single TFM - always tracks latest)
sed -i "s|<TargetFramework>net[0-9]*\.0</TargetFramework>|<TargetFramework>${target_framework}</TargetFramework>|g" src/GithubNugetDemo.Tests/GithubNugetDemo.Tests.csproj
sed -i "s|<TargetFramework>net[0-9]*\.0</TargetFramework>|<TargetFramework>${target_framework}</TargetFramework>|g" example-consumer/example-consumer.csproj

# Update src project (multi-TFM - append new version to keep backwards compatibility)
if ! grep -q "${target_framework}" src/GithubNugetDemo/GithubNugetDemo.csproj; then
  sed -i "s|</TargetFrameworks>|;${target_framework}</TargetFrameworks>|g" src/GithubNugetDemo/GithubNugetDemo.csproj
fi

if git diff --quiet mise.toml \
  example-consumer/example-consumer.csproj \
  src/GithubNugetDemo/GithubNugetDemo.csproj \
  src/GithubNugetDemo.Tests/GithubNugetDemo.Tests.csproj; then
  echo "Already on latest dotnet, nothing to do"
  exit 0
fi

echo "Running regression tests..."
dotnet test

echo "Committing upgrades..."
git commit --include mise.toml \
--include example-consumer/example-consumer.csproj \
--include src/GithubNugetDemo/GithubNugetDemo.csproj \
--include src/GithubNugetDemo.Tests/GithubNugetDemo.Tests.csproj \
--message "chore: Upgrade build to dotnet $latest"
