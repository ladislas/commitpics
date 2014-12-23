#!/bin/zsh

# Set global variables & path
COMMIT_PICS_PATH=$(realpath $PWD)
COMMIT_IMG_DIR="$COMMIT_PICS_PATH/assets/img/commit"
COMMIT_POST_DIR="$COMMIT_PICS_PATH/_posts/commit"
COLORATION_SCRIPT="$COMMIT_PICS_PATH/script/coloration"

GITHUB_DOMAIN="https\:\/\/github.com"
NOW=$(date +"%F")

# Set time of day
if [ $(date +"%k") -lt 5 ] ; then
	TIME_OF_DAY="deep night"
elif [ $(date +"%k") -lt 8 ] ; then
	TIME_OF_DAY="early morning"
elif [ $(date +"%k") -lt 11 ] ; then
	TIME_OF_DAY="morning"
elif [ $(date +"%k") -lt 13 ] ; then
	TIME_OF_DAY="midday"
elif [ $(date +"%k") -lt 16 ] ; then
	TIME_OF_DAY="afternoon"
elif [ $(date +"%k") -lt 18 ] ; then
	TIME_OF_DAY="late afternoon"
elif [ $(date +"%k") -lt 21 ] ; then
	TIME_OF_DAY="evening"
elif [ $(date +"%k") -le 23 ] ; then
	TIME_OF_DAY="late evening"
fi

# Get commit info
COMMIT_HASH=$(git log -1 --pretty="%h")
COMMIT_HASH_LONG=$(git log -1 --pretty="%H")
COMMIT_AUTHOR_NAME=$(git log -1 --pretty="%an")
COMMIT_AUTHOR_EMAIL=$(git log -1 --pretty="%ae")
COMMIT_DATE=$(git log -1 --pretty="%ad")
COMMIT_MESSAGE=$(git log -1 --pretty="%s")
COMMIT_REPOSITORY_URL=$(git config --get remote.origin.url)
COMMIT_REPOSITORY=$(echo $COMMIT_REPOSITORY_URL | sed "s/$GITHUB_DOMAIN\///g")
COMMIT_BRANCH=$(git symbolic-ref --short HEAD)
COMMIT_PICTURE="$NOW-${PWD##*/}-$COMMIT_HASH"
COMMIT_POST="$COMMIT_PICTURE.markdown"

# Take picture - wait for 1 second to allow better lightning
imagesnap $COMMIT_IMG_DIR/$COMMIT_PICTURE.jpg -q -w 1

# Colorize picture based on number of seconds in the current minute
# HUE=$(($(date +%S)*359/59))
# eval "$COLORATION_SCRIPT" -h $HUE -s 75 -l 0 $COMMIT_IMG_DIR/$COMMIT_PICTURE.jpg $COMMIT_IMG_DIR/$COMMIT_PICTURE.jpg

# Create post
touch $COMMIT_POST_DIR/$COMMIT_POST

# Write content to post
echo \
"---
layout: commit
title:  \"$COMMIT_HASH\"
date:   $(date +"%c")
author: $COMMIT_AUTHOR_NAME
email:  $COMMIT_AUTHOR_EMAIL
categories:
- $COMMIT_AUTHOR_NAME
- $COMMIT_REPOSITORY
- $TIME_OF_DAY
- $(date +"%A")
- $(date +"%B")
- $(date +"%Y")
img: $COMMIT_PICTURE.jpg
hash: $COMMIT_HASH_LONG
commitdate: $COMMIT_DATE
message: $COMMIT_MESSAGE
repository: $COMMIT_REPOSITORY
url: $COMMIT_REPOSITORY_URL
branch: $COMMIT_BRANCH
---

~~~diff
$(git log -1 --stat)
~~~" >> $COMMIT_POST_DIR/$COMMIT_POST

