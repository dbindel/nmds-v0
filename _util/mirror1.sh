#!/bin/bash

if [[ -z $DBUS_SESSION_BUS_ADDRESS ]]; then
  dbus_file=/home/bindel/.dbus/session-bus/$(dbus-uuidgen --get)-0
  if [[ -f $dbus_file ]]; then
    source $dbus_file
    export DBUS_SESSION_BUS_ADDRESS
  fi
fi

cd /home/bindel/work/class/nmds
git pull origin
quarto render . |& tee _build.out
rsync -avzL _book/ cslinux:/people/dsb253/nmds
scp _build.out cslinux:/people/dsb253/build-nmds.txt
