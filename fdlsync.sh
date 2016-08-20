#!/bin/bash

rsync -av eai@pimaster.cloudapp.net:/home/eai/master/fdl/ /usr/local/fdl > rsync-log
cat rsync-log | mail -s "Rsync-log-$HOSTNAME" 

exit 0
