#!/bin/bash
#
tag=$(date --iso-8601 |  sed  's/-//g')
LOGFILE=../notebook_$tag.log
echo "$(date): Starting build" > $LOGFILE
docker build --rm --force-rm --tag ewsconsulting/notebook:latest . | tee -a $LOGFILE
echo "$(date): Finished" >> $LOGFILE 2>&1