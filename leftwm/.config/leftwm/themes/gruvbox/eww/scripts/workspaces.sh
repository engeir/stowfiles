#!/usr/bin/env bash
# Streams JSON array of tags on every leftwm state change.
# Each element: {"name":"1","index":1,"focused":true,"busy":false}
leftwm-state -s '{% for ws in workspaces %}{% if ws.index == 0 %}{% for tag in ws.tags %}{{ tag.name }}:{{ tag.focused }}:{{ tag.busy }};{% endfor %}{% endif %}{% endfor %}' | \
python3 -u -c "
import sys, json
for line in sys.stdin:
    tags = []
    for i, part in enumerate(line.strip().split(';'), 1):
        if not part:
            continue
        name, focused, busy = part.split(':')
        tags.append({'name': name, 'index': i, 'focused': focused == 'true', 'busy': busy == 'true'})
    print(json.dumps(tags), flush=True)
"
