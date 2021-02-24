#!/bin/bash

# Written by Chris Richardson - 07/27/2016 - https://github.com/christr

# Automatically sorts video files in my torrent downloads directory. Scheduled as a cron job that runs every five minutes.

# Variables
STORAGE_PATH="/storage"
TORRENTS_PATH="${STORAGE_PATH}/Torrents"
TVSHOWS_PATH="${STORAGE_PATH}/Videos/TV Shows"
MOVIES_PATH="${STORAGE_PATH}/Videos/Movies/Movies - Not Viewed"
DATA_PATH="${STORAGE_PATH}/Data"
LISTOFSHOWS="${DATA_PATH}/List_of_Shows.txt"
TMP_PATH="/ramfs"
LISTOFFILES="${TMP_PATH}/listoffiles"
LISTOFMOVIES="${TMP_PATH}/listofmovies"
VIDEO_FILE_TYPES=".mkv|.mp4|.avi|.mov|.wmv|.mpg|.mpeg|.divx"

# Find video files in Torrents download folder
find $TORRENTS_PATH | egrep "${VIDEO_FILE_TYPES}" | egrep -iv "part|sample" > $LISTOFFILES

# Sort TV Shows
while read -u 3 FILE; do
        exec < $LISTOFSHOWS
        while read SHOW ; do
                MATCH=0
                SHOWARRAY=($SHOW)
                for x in "${SHOWARRAY[@]}"
                do
                        echo "${FILE}" | grep -iq "$x" || MATCH=1
                done
                if [ $MATCH == 0 ]; then
                        if [ ! -d "${TVSHOWS_PATH}/${SHOW}" ]; then
                                mkdir -p "${TVSHOWS_PATH}/${SHOW}"
                        fi
                        mv "${FILE}" "${TVSHOWS_PATH}/${SHOW}"
                fi
        done
done 3< $LISTOFFILES

# Sort Movies
egrep "YTS|YIFY" $LISTOFFILES > $LISTOFMOVIES
exec < $LISTOFMOVIES
while read MOVIE ; do
        mv "${MOVIE}" "${MOVIES_PATH}"
done
