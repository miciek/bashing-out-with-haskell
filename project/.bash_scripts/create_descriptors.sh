#!/usr/bin/env bash

set -e

echo "Building deployment descriptors"

PORT=8080

for I in $(docker images --format "{{.ID}}:{{.Repository}}" "app-*");
do
  ID=$(echo $I | cut -d: -f1)
  NAME=$(echo $I | cut -d: -f2)
  echo "- creating deployment descriptor for ${NAME}"

  echo "{\"name\": \"${NAME}\", \"imageId\": \"$ID\", \"port\": \"${PORT}\"}" | jq . > "$NAME.deployment.json"
  ((PORT++))
done
