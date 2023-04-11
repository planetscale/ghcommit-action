# ghcommit-action

A GitHub Action to detect changed files during a Workflow run and to commit and
push them back to the GitHub repository using the [`ghcommit`](https://github.com/planetscale/ghcommit) utility.

The advantage of using `ghcommit` is that the commits will be signed by GitHub's
GPG key and show as **Verified**. This is important for repositories that require
signed commits.

The plugin is inspired by [stefanzweifel/git-auto-commit-action](https://github.com/stefanzweifel/git-auto-commit-action)
and uses some of the same input parameters. We expect to emulate more of its
parameters over time and PRs providing similar functionality will be considered.

## Usage

The plugin is currently implemented as a Docker style plugin. It must be run on
a Linux host, eg: `ubuntu-latest`.

```yaml
name: fmt

on:
  # NOTE: Need to run on a PR so that the ${{ github.head_ref }} (branch) is non-null
  pull_request:
    types:
      - opened
      - synchronize
      - reopened

jobs:
  fmt-code:
    runs-on: ubuntu-latest

    permissions:
      # Give the default GITHUB_TOKEN write permission to commit and push the
      # added or changed files to the repository.
      contents: write

    steps:
      - uses: actions/checkout@v3

      # Run steps that make changes to the local repo here.

      # Commit all changed files back to the repository
      - uses: planetscale/ghcommit-action@v0.0.6
        with:
          commit_message: "🤖 fmt"
          repo: ${{ github.repository }}
          branch: ${{ github.head_ref }}
```

> NOTE: These examples may not show the latest version. Check the [GitHub Releases](https://github.com/planetscale/ghcommit-action/releases) page to see the latest version tag

Example showing all options:


```yaml
      - uses: planetscale/ghcommit-action@v0.0.6
        with:
          commit_message: "🤖 fmt"
          repo: ${{ github.repository }}
          branch: ${{ github.head_ref }}
          file_pattern: '*.txt *.md *.json *.hcl'
```

See [`action.yaml`](./action.yaml) for current list of supported inputs.

## Releasing

Releases (version tags) are generated automatically on all successful `main` branch builds.
This project uses [autotag](https://github.com/pantheon-systems/autotag) to automate this process.

Semver (`vMajor.Minor.Patch`) is used for versioning and releases. By default, `autotag` will
bump the patch version on a successful main build, eg: `v1.0.0` -> `v1.0.1`.

To bump the major or minor release instead, include `[major]` or `[minor]` in the commit message.
Refer to the autotag [docs](https://github.com/pantheon-systems/autotag#incrementing-major-and-minor-versions)
for more details.
