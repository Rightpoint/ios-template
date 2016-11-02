#!/bin/bash
KEY=$1
NAME=$2
BUNDLE=$3
TRACK=$4


JSON=`curl -F "title=$NAME" -F "bundle_identifier=$BUNDLE" -F "platform=iOS" -F "custom_release_type=$TRACK" -H "X-HockeyAppToken: $KEY" https://rink.hockeyapp.net/api/2/apps/new`
ID=`echo "$JSON" | jq '.public_identifier'`

echo $ID
