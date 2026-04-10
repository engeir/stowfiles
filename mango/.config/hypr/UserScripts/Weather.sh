#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# weather info from wttr. https://github.com/chubin/wttr.in
# Remember to add city

city=
cachedir="$HOME/.cache/rbn"
cachefile="${0##*/}-$1"

if [ ! -d "$cachedir" ]; then
    mkdir -p "$cachedir"
fi

if [ ! -f "$cachedir/$cachefile" ]; then
    touch "$cachedir/$cachefile"
fi

cacheage=$(($(date +%s) - $(stat -c '%Y' "$cachedir/$cachefile")))
if [ "$cacheage" -gt 1740 ] || ! grep -q '[^[:space:]]' "$cachedir/$cachefile" 2>/dev/null; then
    mapfile -t data < <(curl -s "https://en.wttr.in/${city}${1}?0qnT" 2>&1 | grep -v '^[[:space:]]*$')
    echo "${data[0]}" | cut -f1 -d, >"$cachedir/$cachefile"
    echo "${data[1]}" | sed -E 's/^.{15}//' >>"$cachedir/$cachefile"
    echo "${data[2]}" | sed -E 's/^.{15}//' >>"$cachedir/$cachefile"
fi

mapfile -t weather <"$cachedir/$cachefile"

temperature=$(echo "${weather[2]}" | sed -E 's/^[[:space:]]+//;s/[[:space:]]+$//;s/([[:digit:]]+)\.\./\1 to /g')
condition_name=$(echo "${weather[1]}" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

# https://fontawesome.com/icons?s=solid&c=weather
case $(echo "${weather[1]##*,}" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | tr '[:upper:]' '[:lower:]') in
    "clear" | "sunny")
        condition=""
        ;;
    "partly cloudy")
        condition="󰖕"
        ;;
    "cloudy")
        condition=""
        ;;
    "overcast")
        condition=""
        ;;
    "fog" | "freezing fog")
        condition=""
        ;;
    "patchy rain possible" | "patchy light drizzle" | "light drizzle" | "patchy light rain" | "light rain" | "light rain shower" | "mist" | "rain")
        condition="󰼳"
        ;;
    "moderate rain at times" | "moderate rain" | "heavy rain at times" | "heavy rain" | "moderate or heavy rain shower" | "torrential rain shower" | "rain shower")
        condition=""
        ;;
    "patchy snow possible" | "patchy sleet possible" | "patchy freezing drizzle possible" | "freezing drizzle" | "heavy freezing drizzle" | "light freezing rain" | "moderate or heavy freezing rain" | "light sleet" | "ice pellets" | "light sleet showers" | "moderate or heavy sleet showers")
        condition="󰼴"
        ;;
    "blowing snow" | "moderate or heavy sleet" | "patchy light snow" | "light snow" | "light snow showers")
        condition="󰙿"
        ;;
    "blizzard" | "patchy moderate snow" | "moderate snow" | "patchy heavy snow" | "heavy snow" | "moderate or heavy snow with thunder" | "moderate or heavy snow showers")
        condition=""
        ;;
    "thundery outbreaks possible" | "patchy light rain with thunder" | "moderate or heavy rain with thunder" | "patchy light snow with thunder")
        condition=""
        ;;
    *)
        condition=""
        echo -e "{\"text\":\"${condition}\", \"alt\":\"${weather[0]}\", \"tooltip\":\"${weather[0]}: ${temperature} ${weather[1]}\"}"
        ;;
esac

echo -e "{\"text\":\"${temperature} ${condition}\", \"alt\":\"${weather[0]}\", \"tooltip\":\"${weather[0]}: ${temperature} ${weather[1]}\"}"

cached_weather="<i>${weather[0]^}</i>\n${condition} ${temperature}\n${condition_name}"

echo -e "$cached_weather" >"$HOME/.cache/.weather_cache"
