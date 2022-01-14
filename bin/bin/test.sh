#!/bin/bash

# sinkInputs=$(pacmd list-sink-inputs | grep -B 4 "sink: $1 " | awk '/index:/{print $2}')
sinkInputs="word for word"

echo "$sinkInputs"

for each in $sinkInputs; do
    echo "$each"
done
