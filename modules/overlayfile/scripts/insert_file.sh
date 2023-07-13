mkdir -p $out

# Needed in case /nix is a symbolic link.
realOut="$(realpath -m "$out")"

echo "Creating file store for User $owner..."

function insertFile() {
  local source="$1"
  local relTarget="$2"

  # If the target already exists then we have a collision. Note, this
  # should not happen due to the assertion found in the 'files' module.
  # We therefore simply log the conflict and otherwise ignore it, mainly
  # to make the `files-target-config` test work as expected.
  if [[ -e "$realOut/$relTarget" ]]; then
    echo "File conflict for file '$relTarget'" >&2
    return
  fi
  
  # Figure out the real absolute path to the target.
  local target="$(realpath -m "$realOut/$relTarget")"
  echo "Copying file $relTarget to $target..."

  # Target path must be within $HOME.
  if [[ ! $target == $realOut* ]]; then
    echo "Error installing file '$relTarget' outside \$HOME" >&2
    exit 1
  fi

  mkdir -p "$(dirname "$target")"
  ln -s "$source" "$target"
}
