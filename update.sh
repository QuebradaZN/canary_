#!/bin/bash -e

main() {
	git pull
	git lfs pull

	source ~/.profile
	local branch=$(git rev-parse --abbrev-ref HEAD)
	local commit=$(git rev-parse HEAD)
	local artifact="canary-linux-release-${branch}-${commit}"

	url=$(curl -sL \
		-H "Accept: application/vnd.github+json" \
		-H "Authorization: Bearer $GITHUB_TOKEN"\
		-H "X-GitHub-Api-Version: 2022-11-28" \
		"https://api.github.com/repos/elysiera/canary/actions/artifacts?name=${artifact}&per_page=1" | jq -r '.artifacts[0].archive_download_url')
	if [ -z "$url" ] || [ "$url" = "null" ]; then
		echo "No artifact found for ${artifact}"
		exit 1
	fi
	echo "Downloading ${url}..."
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
