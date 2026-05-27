#!/usr/bin/env bash
tw=$(timew get dom.active.tag.1 2>/dev/null)
[ -z "$tw" ] || [ "$tw" = "0" ] && echo "-" || echo "$tw"
