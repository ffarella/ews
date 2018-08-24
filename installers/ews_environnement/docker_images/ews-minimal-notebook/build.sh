#!/bin/bash
#
tag=$(date --iso-8601 |  sed  's/-//g')
LOGFILE=../minimal-notebook_$tag.log
echo "$(date): Starting build" > $LOGFILE
docker build --rm --force-rm --no-cache --tag ewsconsulting/minimal-notebook:latest . | tee -a $LOGFILE
echo "$(date): Finished" >> $LOGFILE 2>&1