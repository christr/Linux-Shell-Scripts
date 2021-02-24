#!/bin/bash
##### Plex Preroll (plex_preroll.sh) version 1.0 #####
##### Written by Chris Richardson (https://github.com/christr) on 2021-02-21

### This Linux script will randomly change your Plex prerolls based on the time of year or holiday season. An excellent place to obtain Plex and other prerolls is at https://prerolls.video/plex.
### Schedule this script to run at any interval of your choosing in cron (https://www.howtogeek.com/101288/how-to-schedule-tasks-on-linux-an-introduction-to-crontab-files).
### shuf is required for the script to work. It's included in the coreutils package of nearly all Linux distributions.

# Enter the directory containing all your Preroll subdirectories. Example path given below.
Prerolls=/storage/Videos/Prerolls

# Enter the path to where the script will always copy the preroll to (see advanced instructions at https://support.plex.tv/articles/202920803-extras/) to match the full path you defined in Plex. Example path given below.
Preroll=/storage/Videos/preroll.mp4

# Adjust the dates below (MM-DD) for when you want seasons to start or end. Times are always at exactly midnight for the given date.
NewYearsStart=01-01
NewYearsEnd=01-08
ValentinesStart=02-07
ValentinesEnd=02-15
AprilFoolsStart=04-01
AprilFoolsEnd=04-02
SummerStart=06-01
SummerEnd=08-01
HalloweenStart=10-01
HalloweenEnd=11-01
ThanksgivingStart=11-01
ThanksgivingEnd=11-28
ChristmasStart=11-28
ChristmasEnd=12-28

Year=$(date +%Y)
Today=$(date +%s)

NewYearsStart=$(date -d "$Year-$NewYearsStart" +%s)
NewYearsEnd=$(date -d "$Year-$NewYearsEnd" +%s)
ValentinesStart=$(date -d "$Year-$ValentinesStart" +%s)
ValentinesEnd=$(date -d "$Year-$ValentinesEnd" +%s)
AprilFoolsStart=$(date -d "$Year-$AprilFoolsStart" +%s)
AprilFoolsEnd=$(date -d "$Year-$AprilFoolsEnd" +%s)
SummerStart=$(date -d "$Year-$SummerStart" +%s)
SummerEnd=$(date -d "$Year-$SummerEnd" +%s)
HalloweenStart=$(date -d "$Year-$HalloweenStart" +%s)
HalloweenEnd=$(date -d "$Year-$HalloweenEnd" +%s)
ThanksgivingStart=$(date -d "$Year-$ThanksgivingStart" +%s)
ThanksgivingEnd=$(date -d "$Year-$ThanksgivingEnd" +%s)
ChristmasStart=$(date -d "$Year-$ChristmasStart" +%s)
ChristmasEnd=$(date -d "$Year-$ChristmasEnd" +%s)

# Name your directories under the main Prerolls directory you defined earlier in this script. Use the names in the example below or modify them to match what you currently have.
if [[ ${NewYearsStart} -le ${Today} ]] && [[ ${Today} -lt ${NewYearsEnd} ]]; then
	Directory=NewYears
elif [[ ${ValentinesStart} -le ${Today} ]] && [[ ${Today} -lt ${ValentinesEnd} ]]; then
	Directory=Valentines
elif [[ ${AprilFoolsStart} -le ${Today} ]] && [[ ${Today} -lt ${AprilFoolsEnd} ]]; then
	Directory=AprilFools
elif [[ ${SummerStart} -le ${Today} ]] && [[ ${Today} -lt ${SummerEnd} ]]; then
	Directory=Summer
elif [[ ${HalloweenStart} -le ${Today} ]] && [[ ${Today} -lt ${HalloweenEnd} ]]; then
	Directory=Halloween
elif [[ ${ThanksgivingStart} -le ${Today} ]] && [[ ${Today} -lt ${ThanksgivingEnd} ]]; then
	Directory=Thanksgiving
elif [[ ${ChristmasStart} -le ${Today} ]] && [[ ${Today} -lt ${ChristmasEnd} ]]; then
	Directory=Christmas
else
	# This is the directory used when no holiday seasons are currently in progress. This is likely where you'll store most of your prerolls.
	Directory=Regular
fi

# The command below randomly selects a preroll out of the directory for the time period defined above.
TodayPreroll=$(ls ${Prerolls}/${Directory} | shuf -n 1)

# The command below copies the randomly selected preroll to the location you defined earlier in the script.
\cp "${Prerolls}/${Directory}/${TodayPreroll}" ${Preroll}
