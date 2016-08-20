#!/bin/bash
i=0

while [ $i -lt 120 ]; do
  /usr/local/fdl/getthatdamntemp.sh &
  sleep .5
  i=$(( i + 1 ))
done





