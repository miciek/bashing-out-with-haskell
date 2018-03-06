#!/usr/bin/env bash

set -e

echo "STAGE 1: build apps"
.bash_scripts/build_apps.sh
echo "STAGE 2: build images"
.bash_scripts/build_images.sh
echo "STAGE 3: deploy apps"
.bash_scripts/deploy_apps.sh
