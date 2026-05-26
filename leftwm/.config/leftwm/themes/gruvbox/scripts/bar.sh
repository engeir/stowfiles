#!/usr/bin/env bash
# lemonbar feed — tags, layout, cpu, mem, disk, net, vol, bat, timew, clock

BG="#201b14"
FG="#D1B88E"
ORANGE="#DA7510"
GREY="#444444"
DIM="#c9b890"
GREEN="#b8bb26"
PURPLE="#d3869b"
BLUE="#83a598"
AQUA="#8ec07c"
YELLOW="#fabd2f"
RED="#fb4934"

FIFO=$(mktemp -u /tmp/leftwm-bar-XXXXXX)
mkfifo "$FIFO"
exec 3<>"$FIFO"         # keep FIFO alive (O_RDWR never blocks)
trap 'rm -f "$FIFO"; kill $(jobs -p) 2>/dev/null' EXIT INT TERM

# Wait for leftwm pipe to be ready
until leftwm-state -s "{{ window_title }}" --quit >/dev/null 2>&1; do sleep 0.5; done

# ── Tags + layout producer ───────────────────────────────────────────
TAGS_TMPL="TAGS:{% for ws in workspaces %}{% if ws.index == 0 %}{% for tag in ws.tags %}{% if tag.focused %}%{B${ORANGE}}%{F${BG}} {{ tag.name }} %{F-}%{B-}{% elsif tag.busy %}%{F${DIM}} {{ tag.name }} %{F-}{% else %}%{F${GREY}} {{ tag.name }} %{F-}{% endif %}{% endfor %}{% endif %}{% endfor %}|LAY|{% for ws in workspaces %}{% if ws.index == 0 %}{{ ws.layout }}{% endif %}{% endfor %}"

( exec >"$FIFO"; leftwm-state -s "$TAGS_TMPL" ) &

# ── Status producer ──────────────────────────────────────────────────
(
    exec >"$FIFO"
    while true; do
        # cpu load (1min average)
        cpu=$(uptime | awk -F'load average: ' '{split($2,a,","); printf "%.1f", a[1]}')
        cpu_str="%{F${GREEN}}CPU ${cpu}%{F-}"

        # memory used/total
        mem=$(free -h | awk 'NR==2{printf "%s/%s", $3, $2}')
        mem_str="%{F${PURPLE}}MEM ${mem}%{F-}"

        # disk free on /
        disk=$(df -h / | awk 'NR==2{print $4}')
        disk_str="%{F${BLUE}}DSK ${disk}%{F-}"

        # network: prefer wifi, fallback to eth
        net_str=""
        for wf in /sys/class/net/wl*; do
            [ -f "$wf/operstate" ] && [ "$(cat "$wf/operstate")" = "up" ] || continue
            ssid=$(iwgetid -r "$(basename "$wf")" 2>/dev/null)
            net_str="%{F${AQUA}}NET ${ssid:-wifi}%{F-}"
            break
        done
        if [ -z "$net_str" ]; then
            for ef in /sys/class/net/e*; do
                [ -f "$ef/operstate" ] && [ "$(cat "$ef/operstate")" = "up" ] || continue
                net_str="%{F${AQUA}}NET eth%{F-}"
                break
            done
        fi
        [ -z "$net_str" ] && net_str="%{F${GREY}}NET --%{F-}"

        # volume
        vol=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | grep -oP '\d+%' | head -1 | tr -d '%')
        muted=$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | awk '{print $2}')
        if [ "$muted" = "yes" ]; then
            vol_str="%{F${GREY}}VOL muted%{F-}"
        elif [ -n "$vol" ]; then
            if   [ "$vol" -lt 33 ]; then vol_str="%{F${ORANGE}}VOL ${vol}%%%{F-}"
            elif [ "$vol" -lt 66 ]; then vol_str="%{F${ORANGE}}VOL ${vol}%%%{F-}"
            else                          vol_str="%{F${ORANGE}}VOL ${vol}%%%{F-}"
            fi
        else
            vol_str=""
        fi

        # battery
        cap=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
        sta=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)
        if [ -n "$cap" ]; then
            if [ "$sta" = "Charging" ]; then
                bat_str="%{F${YELLOW}}BAT +${cap}%%%{F-}"
            elif [ "$cap" -lt 15 ]; then
                bat_str="%{F${RED}}BAT ${cap}%%%{F-}"
            elif [ "$cap" -lt 40 ]; then
                bat_str="%{F${ORANGE}}BAT ${cap}%%%{F-}"
            elif [ "$cap" -lt 75 ]; then
                bat_str="%{F${YELLOW}}BAT ${cap}%%%{F-}"
            else
                bat_str="%{F${YELLOW}}BAT ${cap}%%%{F-}"
            fi
        else
            bat_str=""
        fi

        # timew
        tw=$(timew get dom.active.tag.1 2>/dev/null)
        if [ -z "$tw" ] || [ "$tw" = "0" ]; then
            tw_str="%{F${DIM}}TW -%{F-}"
        else
            tw_str="%{F${DIM}}TW ${tw}%{F-}"
        fi

        # clock
        clk="%{F${FG}}$(date '+%a %d %b  %H:%M')%{F-}"

        echo "STATUS:${cpu_str}  ${mem_str}  ${disk_str}  ${net_str}  ${vol_str}  ${bat_str}  ${tw_str}  ${clk}"
        sleep 10
    done
) &

# ── Merger → lemonbar ────────────────────────────────────────────────
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
