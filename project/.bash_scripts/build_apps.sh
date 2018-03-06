#!/usr/bin/env bash

set -e

VERSION=$(date +%y%m%d%H%M%S);
echo "Building apps version: $VERSION"

for D in *; do
  if [ -d "${D}" ]; then
    echo "- building ${D}"
    cd "${D}"
    mkdir -p build
    for f in {data,html,Dockerfile}; do
      cp -R $f build/ 2>/dev/null || :
    done
    find ./build -type f -exec sed -i '' "s/VERSION_PLACEHOLDER/${VERSION}/g" {} \;
    tar -cvf "../${D}.tar.gz" -C "build" .
    rm -rf build
    cd ..
  fi
done
