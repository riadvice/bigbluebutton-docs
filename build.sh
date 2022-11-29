#!/bin/sh

git branch | sed -n 's/^.*v\(.*\).x-release/\1/p' \
  | while read version; do

  echo "Adding documentation for $version"
  git checkout "v${version}.x-release"
  npm run docusaurus docs:version "${version}"

done

git checkout develop
npm start
