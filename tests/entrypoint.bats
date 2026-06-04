#!/usr/bin/env bats

load "${BATS_PLUGIN_PATH}/load.bash"

# uncomment to debug these stubs:
# export GIT_STUB_DEBUG=/dev/tty
# export GHCOMMIT_STUB_DEBUG=/dev/tty

setup() {
  export GITHUB_WORKSPACE="$BATS_TEST_DIRNAME/.."
  #export DEBUG=1
}

@test "parses git status output and generates correct flags for ghcommit" {
  local commit_message='msg'
  local repo='org/repo'
  local branch='main'
  local empty='false'
  local file_pattern='.'

  export GITHUB_OUTPUT="$BATS_TEST_TMPDIR/github-output"

  # NOTE: we are passing our hand-crafted fixture through `tr` to convert newlines to nulls since
  # we run `git status -z` which uses null terminators. The newlines are meant to make the file easier
  # to modify and prevent cat from removing the leading space on lines/entries since that is a part
  # of the git status output.
  stub git \
    "config --global --add safe.directory $GITHUB_WORKSPACE/. : echo stubbed" \
    "status -s --porcelain=v1 -z -- . : cat ./tests/fixtures/git-status.out-1 | tr '\n' '\0'"

  stub ghcommit \
    '-b main -r org/repo -m msg --add=README.md --add=foo.txt --add=new.file --delete=old.file --delete=\""a path with spaces oh joy/file.txt\"" : echo Success. New commit: https://localhost/foo'

  run ./entrypoint.sh "$commit_message" "$repo" "$branch" "$empty" "$file_pattern"
  assert_success
  assert_output --partial "Success"
  assert_file_exist "$GITHUB_OUTPUT"
  assert_file_contains "$GITHUB_OUTPUT" "commit-url=https://localhost/foo"
}

@test "no changes" {
  local commit_message='msg'
  local repo='org/repo'
  local branch='main'
  local empty='false'
  local file_pattern='.'

  stub git \
    "config --global --add safe.directory $GITHUB_WORKSPACE/. : echo stubbed" \
    "status -s --porcelain=v1 -z -- . : echo"

  run ./entrypoint.sh "$commit_message" "$repo" "$branch" "$empty" "$file_pattern"
  assert_success
  assert_output --partial "No changes detected"
}

@test "no changes with --empty flag creates empty commit" {
  local commit_message='msg'
  local repo='org/repo'
  local branch='main'
  local empty='true'
  local file_pattern='.'

  export GITHUB_OUTPUT="$BATS_TEST_TMPDIR/github-output"

  stub git \
    "config --global --add safe.directory $GITHUB_WORKSPACE/. : echo stubbed" \
    "status -s --porcelain=v1 -z -- . : echo"

  stub ghcommit \
    '-b main -r org/repo -m msg --empty : echo Success. New commit: https://localhost/foo'

  run ./entrypoint.sh "$commit_message" "$repo" "$branch" "$empty" "$file_pattern"
  assert_success
  assert_output --partial "Success"
  assert_file_exist "$GITHUB_OUTPUT"
  assert_file_contains "$GITHUB_OUTPUT" "commit-url=https://localhost/foo"
}

@test "switches to repository subdirectory when repository input is set" {
  local commit_message='msg'
  local repo='org/repo'
  local branch='main'
  local empty='false'
  local file_pattern='.'
  local repository='tests/fixtures'

  export GITHUB_OUTPUT="$BATS_TEST_TMPDIR/github-output"

  stub git \
    "config --global --add safe.directory $GITHUB_WORKSPACE/tests/fixtures : echo stubbed" \
    "status -s --porcelain=v1 -z -- . : echo"

  stub ghcommit \
    '-b main -r org/repo -m msg --empty : echo Success. New commit: https://localhost/sub'

  # Use --empty to force ghcommit to run even without staged changes, so we can
  # verify the working directory change took effect (otherwise the stub for
  # ghcommit would not be exercised).
  run ./entrypoint.sh "$commit_message" "$repo" "$branch" "true" "$file_pattern" "$repository"
  assert_success
  assert_output --partial "Repository path: $GITHUB_WORKSPACE/tests/fixtures"
  assert_output --partial "Success"
}

@test "handles untracked files" {
  local commit_message='msg'
  local repo='org/repo'
  local branch='main'
  local empty='false'
  local file_pattern='.'

  export GITHUB_OUTPUT="$BATS_TEST_TMPDIR/github-output"

  stub git \
    "config --global --add safe.directory $GITHUB_WORKSPACE/. : echo stubbed" \
    "status -s --porcelain=v1 -z -- . : cat ./tests/fixtures/git-status.out-2 | tr '\n' '\0'"

  stub ghcommit \
    '-b main -r org/repo -m msg --add=untracked.txt --add=new-file.md --add=modified.txt : echo Success. New commit: https://localhost/bar'

  run ./entrypoint.sh "$commit_message" "$repo" "$branch" "$empty" "$file_pattern"
  assert_success
  assert_output --partial "Success"
  assert_file_exist "$GITHUB_OUTPUT"
  assert_file_contains "$GITHUB_OUTPUT" "commit-url=https://localhost/bar"
}
