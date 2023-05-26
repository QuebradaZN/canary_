#!/bin/bash -e

# cmake --preset linux-release
cmake --build --preset linux-release
cp build/linux-release/bin/canary .
