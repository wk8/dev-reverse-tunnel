#!/bin/bash

set -e

REPO_NAME='dev-reverse-tunnel'
REPO_BASE_DIR='/tmp'
REPO_DIR="$REPO_BASE_DIR/$REPO_NAME"
TMP_DIR="$REPO_DIR/.tmp"
DNA_FILE="$TMP_DIR/dna.json"
SOLO_CONFIG_FILE="$TMP_DIR/solo_config.rb"
COOKBOOKS_DIR="$REPO_DIR/vendor/cookbooks"

rm -rf "$REPO_DIR"
git clone "https://github.com/wk8/$REPO_NAME.git" "$REPO_DIR"
mkdir "$TMP_DIR"

cd "$REPO_DIR"

# create the DNA file
cp "$REPO_DIR/base_dna.json" "$DNA_FILE"
vi "$DNA_FILE"

# and a minimal config for solo
echo "cookbook_path ['$REPO_BASE_DIR', '$COOKBOOKS_DIR']" > "$SOLO_CONFIG_FILE"

chef-solo -c "$SOLO_CONFIG_FILE" -j "$DNA_FILE" -o 'recipe[dev-reverse-tunnel]'
