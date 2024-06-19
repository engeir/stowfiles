#!/usr/bin/env -S just --justfile
# just reference  : https://just.systems/man/en/

default:
    just --list

[linux]  # This is an attribute that specify running on linux
build:
    echo "This is an {{arch()}} machine"

[macos]  # This is an attribute that specify running on macos
build:
    echo "This is a {{arch()}} machine"

[unix]  # This is an attribute that specify running on any unix system
build-unix:
    echo "This is a(n) {{arch()}} machine"
