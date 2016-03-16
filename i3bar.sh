#!/bin/sh

readonly ticks=(▁ ▂ ▃ ▄ ▅ ▆ ▇ █)

i3status --config ~/.i3status.conf | while :
do
    read line
    memory_tick=$(free | grep Mem | awk '{print int($3/$2 * 8)}')
    memory_percent=$(free | grep Mem | awk '{print int($3/$2 * 100)}')    
    echo "🖥  ${ticks[$memory_tick]} ${memory_percent}% | $line" || exit 1
done
