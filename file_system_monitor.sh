#!/bin/bash
#Written by Chris Richardson 04/27/2018 - https://github.com/christr
#This script monitors for file systems over specified thresholds, and emails when the thresholds are met or exceeded. Schedule it to run from cron at least daily.
Hostname=`uname -n`
Threshold="9.%|100%"
MAILTO=example@domain.com

df -Ph | egrep "${Threshold}" | while read FileSystem
do
        Size=$(echo "${FileSystem}" | awk '{print $2}')
        Used=$(echo "${FileSystem}" | awk '{print $3}')
        Available=$(echo "${FileSystem}" | awk '{print $4}')
        PercentUsed=$(echo "${FileSystem}" | awk '{print $5}')
        Mount=$(echo "${FileSystem}" | awk '{print $6}')
        echo "File system ${Mount} is ${Size} in size. ${Used} are used and only ${Available} are available." | mailx -s "WARNING: ${Mount} on ${Hostname} is at ${PercentUsed}" ${MAILTO}
done

