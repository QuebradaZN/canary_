#!/bin/bash

main() {
	sudo apt update -y
	sudo apt install -y gdb git jq unzip libtool ca-certificates curl zip unzip tar
}

main
