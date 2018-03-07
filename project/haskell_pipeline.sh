#!/usr/bin/env bash

set -e

echo "STAGE 1: build apps"
.haskell_scripts/build_apps.hs
# echo "STAGE 2: build images"
# .haskell_scripts/build_images.hs
# echo "STAGE 3: create deployment descriptors"
# .haskell_scripts/create_descriptors.hs
# echo "STAGE 4: deploy apps"
# .haskell_scripts/deploy_apps.hs
