#!/bin/bash -e

main() {
  git pull

	source ~/.profile

  url=$(curl -sL \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $GITHUB_TOKEN"\
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/repos/elysiera/canary/actions/artifacts?per_page=1 | jq -r '.artifacts[0].archive_download_url')
  curl -Lo canary.zip \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $GITHUB_TOKEN"\
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "${url}"
  unzip canary.zip
  rm -f canary.zip
  chmod a+x canary
  rm -f canary-previous
  mv canary-current canary-previous || true
  mv canary canary-current || true
}

main
