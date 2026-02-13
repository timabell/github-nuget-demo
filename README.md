# Github nuget demo

https://github.com/timabell/github-nuget-demo

A demo of automatic publishing of a C# NuGet library to both GitHub Packages and nuget.org.

## Setup

To use this template for your own project, configure these repository secrets (Settings → Secrets → Actions):

| Secret | Description |
|--------|-------------|
| `NUGET_API_KEY` | API key from https://www.nuget.org/account/apikeys with push permissions |

The `GITHUB_TOKEN` for GitHub Packages is provided automatically.

### Why both registries?

GitHub Packages requires authentication even for public packages, making it impractical for public distribution. nuget.org allows anonymous access, so consumers can simply run:

```sh
dotnet add package GithubNugetDemo
```

## Automatic Releasing

Every commit to main triggers a build & test.

If there are release-worthy changes (commits with `feat:`, `fix:`, etc.), a release is created:

1. Version calculation (via [git-cliff](https://git-cliff.org/))
2. NuGet package creation
3. Git tag creation
4. [GitHub Release](https://github.com/timabell/github-nuget-demo/releases) with changelog
5. Push to [GitHub Packages](https://github.com/timabell/github-nuget-demo/pkgs/nuget/GithubNugetDemo)
6. Push to [nuget.org](https://www.nuget.org/packages/GithubNugetDemo)

Commits with internal prefixes (`ci:`, `refactor:`, etc.) do not trigger a release.

If there are no release-worthy commits then no release is generated.

## Commit Messages

This project uses [Conventional Commits](https://www.conventionalcommits.org/) format. Optionally include a scope in parentheses: `feat(subsystem): add support for arrays`.

### Prefixes that appear in release notes

| Prefix | Description |
|--------|-------------|
| `feat:` | ✨ New features |
| `fix:` | 🐛 Bug fixes |
| `perf:` | ⚡ Performance improvements |
| `doc:` | 📚 Documentation changes |
| `style:` | 🎨 Code style/formatting |

See [cliff.toml](.github/cliff.toml) for definitive list.

### Internal prefixes (not shown in release notes)

These are recommended for consistency but won't appear in user-facing changelogs:

| Prefix | Description |
|--------|-------------|
| `refactor:` | Code restructuring without behaviour change |
| `test:` | Adding or updating tests |
| `ci:` | CI/CD pipeline changes |
| `build:` | Build system changes |
| `chore:` | Maintenance tasks |

### How it works

Release notes are generated from all commits since the last tag, regardless of whether they're on main, in branches, or merge commits. When committing, think about what you want in the release notes:

- Use a release-note prefix (like `feat:` or `fix:`) when the change is meaningful to library users
- Use an internal prefix (like `refactor:` or `ci:`) for changes that don't affect users
- Non-semantic commit messages (e.g. "WIP", "typo fix", "cleanup") are also ignored

This means you can commit freely during development without worrying about polluting release notes.

## Version Bumping

By default, each release increments the patch version (e.g. 0.0.1 → 0.0.2).

To bump minor or major versions, add a footer to your commit message:

```
feat: add new feature

bump: minor
```

```
feat: breaking change

bump: major
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
