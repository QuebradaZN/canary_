#!/bin/bash -e

main() {
	if [ -d "logs" ]
	then
		echo -e "\e[01;32m Starting server \e[0m"
	else
		mkdir -p logs
		sudo apt install -y gdb
	fi

	ulimit -c unlimited
	set -o pipefail

	if [ -f update ]; then
		echo -e "\e[01;32m Updating server \e[0m"
		./update.sh
		rm update
	fi

	./canary-current 2>&1 | awk '{ print strftime("%F %T - "), $0; fflush(); }' | tee "logs/$(date +"%F %H-%M-%S.log")"
	echo -e "\e[0;31m Exit code $?, wait 30 seconds... \e[0m"
}

main
