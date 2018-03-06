#!/usr/bin/env bash

set -e

echo "Building images"

for F in *.tar.gz
do
  mkdir -p tmp
  rm -rf tmp/*
  tar zxf "${F}" -C tmp
  cd tmp

  if [ -n "$(ls -A "Dockerfile" 2>/dev/null)" ]; then
    echo "- building Docker image for ${F}"
    docker build -t "app-${F%.*.*}" .
  fi

  cd ..
  rm -rf tmp
done

rm *.tar.gz
