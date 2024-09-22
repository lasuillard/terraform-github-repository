#!/usr/bin/env bash

root_dir="$(dirname "$(dirname "$0")")"
tf_dirs="$(find "$root_dir" -name '*.tf' -exec sh -c 'dirname {}' \; | sort | uniq)"

for tf_dir in $tf_dirs; do
  echo "Validating $tf_dir"
  terraform -chdir="$tf_dir" init
  terraform -chdir="$tf_dir" validate
done
