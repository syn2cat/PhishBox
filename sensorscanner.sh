#!/bin/bash
# run in background, install into inittab, anything goes
# example for inittab:
# P0:2345:respawn:/root/buttonscanner.sh
COUNTER=/home/pi/website/counter.txt
WiringPIN=18   # physical pin 12
PATH=/bin:/usr/bin:/usr/local/bin
gpio -g mode $WiringPIN in    # set to input mode 
gpio -g mode $WiringPIN down  # set internal pulldown
echo "Sensor scanner starting"
while true
do
  echo "scanning..." 
  gpio -g wfi $WiringPIN falling   # wait for detection (uses no cpu, but interrupt)
  echo "got event"
  gpio -g read $WiringPIN
  if [ $(gpio -g read $WiringPIN) -eq 0 ]
  then
    counter="$(head "$COUNTER")"
    counter=$((counter+1))
    cp -p "$COUNTER" "$COUNTER".new
    echo "$counter" > "$COUNTER".new
    mv "$COUNTER".new "$COUNTER"
    echo "counter is now $counter"
    echo "sleeping for 10s"
    sleep 10
  fi
done

