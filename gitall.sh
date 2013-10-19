#!/bin/bash

set -e

CREDENTIALS=$1

KEEPGOING=0
PAGE=1
while [ $PAGE -lt 4 ]
do
  URL="https://api.github.com/orgs/mosscode/repos?page=$PAGE"
  echo "FETCHING $URL"
  curl -vu $CREDENTIALS $URL >> repos.json
  KEEPGOING=$?
  PAGE=$[$PAGE + 1]
done

for FILE in "repos.json";
do
  echo "FILE: $FILE"
  URLS="$URLS
`grep git_url $FILE | awk '{print $2}' | sed 's|[",]||g'`"
done

for URL in $URLS;
do
  CMD="git clone $URL"
  echo $CMD
  eval "$CMD"
done

