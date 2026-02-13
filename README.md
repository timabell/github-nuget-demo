# Github nuget demo

A demo of automatic publishing of a c# nuget lib to the github package feeds

- Every commit to main publishes new version
- Automatic patch version bump on every commit to main
- Bump minor/major with commit footers
- Automatic release notes with git-cliff and published github releases
