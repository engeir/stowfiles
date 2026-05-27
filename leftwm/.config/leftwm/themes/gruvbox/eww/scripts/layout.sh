#!/usr/bin/env bash
leftwm-state -s '{% for ws in workspaces %}{% if ws.index == 0 %}{{ ws.layout }}{% endif %}{% endfor %}'
