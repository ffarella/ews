#!/bin/bash
#
tag=$(date --iso-8601 |  sed  's/-//g')
LOGFILE=../notebook-r-julia_$tag.log
echo "$(date): Starting build" > $LOGFILE
docker build --rm --force-rm --tag ewsconsulting/notebook-r-julia:latest . | tee -a $LOGFILE
echo "$(date): Finished" >> $LOGFILE 2>&1