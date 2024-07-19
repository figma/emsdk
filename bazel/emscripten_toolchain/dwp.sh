#!/bin/bash

# We find llvm-dwp through a relative path, which depends on platform

# First, check if we're on a mac
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Now, check if this is an intel mac
  if [[ $(uname -m) == "x86_64" ]]; then
    emscripten_bin="emscripten_bin_mac"
  elif [[ $(uname -m) == "arm64" ]]; then
    emscripten_bin="emscripten_bin_mac_arm64"
  else
    echo "Unknown architecture: $(uname -m)"
    exit 1
  fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Now, check if this is intel
  if [[ $(uname -m) == "x86_64" ]]; then
    emscripten_bin="emscripten_bin_linux"
  elif [[ $(uname -m) == "aarch64" ]]; then
    emscripten_bin="emscripten_bin_linux_arm64"
  else
    echo "Unknown architecture: $(uname -m)"
    exit 1
  fi
else
  echo "Unknown OS: $OSTYPE"
  exit 1
fi

exec "$(dirname $0)"/../../"$emscripten_bin"/bin/llvm-dwp "$@"
