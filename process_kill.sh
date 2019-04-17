#!/bin/bash
#alias tue=~/Dropbox/Informatique/Scripts/process_kill.sh
tuer=$(pidof $1)
kill -9 $tuer
