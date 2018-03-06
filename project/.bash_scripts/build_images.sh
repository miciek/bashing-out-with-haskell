#!/usr/bin/env bash

set -e

echo "Building images"

for artifact in *.tar.gz
do
  mkdir -p tmp
  rm -rf tmp/*
  tar zxf "${artifact}" -C tmp
  cd tmp

  if [ -n "$(ls -A "Dockerfile" 2>/dev/null)" ]; then
    echo "- building Docker image for ${artifact}"
    docker build -t "${artifact%.*}" .
  fi
  
  cd ..
  rm -rf tmp
done
