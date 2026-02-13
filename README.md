# Github nuget demo

https://github.com/timabell/github-nuget-demo

A demo of automatic publishing of a c# nuget lib to the github package feeds.

## Automatic Releasing

Every commit to main triggers:

1. Build & test
2. Version calculation (via git-cliff)
3. NuGet package creation
4. Git tag creation
5. Push to [GitHub Packages](https://github.com/timabell/github-nuget-demo/pkgs/nuget/GithubNugetDemo)
6. [GitHub Release](https://github.com/timabell/github-nuget-demo/releases) with changelog

## Version Bumping

By default, each release increments the patch version (e.g. 0.0.1 → 0.0.2).

To bump minor or major versions, add a footer to your commit message:

```
feat: add new feature

bump: minor-version
```

```
feat!: breaking change

bump: major-version
```

## Local Commands

Preview release notes for the current version:

```sh
./release-notes.sh
```

Preview unreleased changes:

```sh
./release-notes.sh --preview
```

Show next version number:

```sh
./release-notes.sh --bumped
```
