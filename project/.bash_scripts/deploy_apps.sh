#!/usr/bin/env bash

set -e

echo "Deploying apps based on descriptors"

for F in *.deployment.json
do
  NAME=$(jq -r '.name' ${F})
  echo "- stopping and removing old instance of $NAME"
  docker stop ${NAME} || true && docker rm ${NAME} || true
done

for F in *.deployment.json
do
  NAME=$(jq -r '.name' ${F})
  ID=$(jq -r '.imageId' ${F})
  PORT=$(jq -r '.port' ${F})
  echo "- running new instance of $NAME"
  docker run -d -p ${PORT}:80 --name ${NAME} ${ID}
  echo "- deployed ${NAME}: http://localhost:${PORT}/health-check.json"
done

rm *.deployment.json
