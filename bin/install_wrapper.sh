#!/bin/bash
 
TMP_FILE=$(mktemp)
URL="https://raw.githubusercontent.com/wk8/dev-reverse-tunnel/master/bin/install.sh"
 
wget $URL -O $TMP_FILE
 
bash $TMP_FILE

rm $TMP_FILE
