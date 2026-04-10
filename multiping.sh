#!/bin/bash
while IFS= read -r machine
do
  (
    if ping -c1 -W1 -q "$machine" &>/dev/null; then
      echo "$machine is online"
    else
      echo "$machine is offline"
    fi
  ) &
done < "$1"

wait
