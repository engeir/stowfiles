#!/usr/bin/env bash
# lemonbar feed — tags, layout, timew, battery, volume, clock

BG="#201b14"
FG="#D1B88E"
ORANGE="#DA7510"
GREY="#444444"
DIM="#c9b890"

FIFO=$(mktemp -u /tmp/leftwm-bar-XXXXXX)
mkfifo "$FIFO"
exec 3<>"$FIFO"         # keep FIFO alive (O_RDWR never blocks)
trap 'rm -f "$FIFO"; kill 0' EXIT INT TERM

# Wait for leftwm pipe to be ready
until leftwm-state -w 0 -t "{{layout}}" >/dev/null 2>&1; do sleep 0.5; done

# ── Tags + layout producer ───────────────────────────────────────
TAGS_TMPL="TAGS:{{#tags}}{{#focused}}%{B${ORANGE}}%{F${BG}} {{name}} %{F-}%{B-}{{/focused}}{{^focused}}{{#occupied}}%{F${DIM}} {{name}} %{F-}{{/occupied}}{{^occupied}}%{F${GREY}} {{name}} %{F-}{{/occupied}}{{/focused}}{{/tags}}|LAY|{{layout}}"

( exec >"$FIFO"; leftwm-state -w 0 -s -t "$TAGS_TMPL" ) &

# ── Status producer ──────────────────────────────────────────────
(
    exec >"$FIFO"
    while true; do
        # volume
        vol=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | grep -oP '\d+%' | head -1 | tr -d '%')
        muted=$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | awk '{print $2}')
        if [ "$muted" = "yes" ]; then
            vol_str=" muted"
        elif [ -n "$vol" ]; then
            if   [ "$vol" -lt 33 ]; then vol_str=" ${vol}%"
            elif [ "$vol" -lt 66 ]; then vol_str=" ${vol}%"
            else                          vol_str=" ${vol}%"
            fi
        else
            vol_str=""
        fi

        # battery
        cap=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
        sta=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)
        if [ -n "$cap" ]; then
            [ "$sta" = "Charging" ] && bat_str=" +${cap}%" || bat_str=" ${cap}%"
        else
            bat_str=""
        fi

        # timew
        tw=$(timew get dom.active.tag.1 2>/dev/null)
        if [ -z "$tw" ] || [ "$tw" = "0" ]; then
            tw_str=" -"
        else
            tw_str="  ${tw}"
        fi

        # clock
        clk=" $(date '+%a %d %b  %H:%M')"

        echo "STATUS:${vol_str}  ${bat_str}  ${tw_str}  ${clk}"
        sleep 10
    done
) &

# ── Merger → lemonbar ────────────────────────────────────────────
tags=""
layout=""
status=""
while IFS= read -r line; do
    case "$line" in
        TAGS:*)
            rest="${line#TAGS:}"
            tags="${rest%%|LAY|*}"
            layout="%{F${ORANGE}}  ${rest##*|LAY|}%{F-}"
            ;;
        STATUS:*)
            status="${line#STATUS:}"
            ;;
    esac
    printf '%%{l}%s%%{c}%s%%{r}%s\n' "$tags" "$layout" "$status"
done <"$FIFO"
