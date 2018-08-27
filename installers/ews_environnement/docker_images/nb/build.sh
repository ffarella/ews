#!/bin/bash
#
tag=$(date --iso-8601 |  sed  's/-//g')
LOGFILE=../nb_$tag.log
echo "$(date): Starting build" > $LOGFILE
docker build --rm --force-rm --tag ewsconsulting/nb:latest . | tee -a $LOGFILE
echo "$(date): Finished" >> $LOGFILE 2>&1