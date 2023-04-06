#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

export GIT_STUB_DEBUG=/dev/tty
export GHCOMMIT_STUB_DEBUG=/dev/tty

setup() {
  export GITHUB_WORKSPACE=/tmp
}

@test "parses git status output and generates correct flags for ghcommit"
  local commit_message='msg'
  local repo='org/repo'
  local branch='main'
  local file_pattern='.'

  stub git \
    "config --global --add safe.directory $GITHUB_WORKSPACE : echo stubbed" \
    "status -s --porcelain=v1 -z -- . : cat ./tests/fixtures/test-1 | tr '\n' '\0'"

  stub ghcommit \
    '-b main -r org/repo -m msg --add=README.md --add=foo.txt --delete=\""a path with spaces oh joy/file.txt\"" : echo Success'

  run ./entrypoint.sh "$commit_message" "$repo" "$branch" "$file_pattern"
  assert_success
  assert_output --partial "Success"
}