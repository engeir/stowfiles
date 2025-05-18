#!/usr/bin/env bash

if command -v flameshot /dev/null 2>&1; then
    pass
else
    exit 1
fi

mkdir -p "$PDW"/pic/

flameshot gui -p "$PWD/pic/$1"
