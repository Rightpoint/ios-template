#!/bin/sh

set -e

git init
bundle install
cd app
bundle exec pod install
if [[ "{{ cookiecutter.hockey_key }}" =~ .*[nN][oO].* ]]
then
    echo "Skipping hockey app generationg"
else
    export DEVELOP_KEY=`curl -F "title={{ cookiecutter.project_name }}" -F "bundle_identifier={{ cookiecutter.bundle_identifier }}" -F "platform=iOS" -F "custom_release_type=Develop" -H "X-HockeyAppToken: {{ cookiecutter.hockey_key }}" https://rink.hockeyapp.net/api/2/apps/new | jq '.public_identifier' | sed -e 's/\"//g'`
    echo "Hockey App Develop Key: $DEVELOP_KEY"
    export SPRINT_KEY=`curl -F "title={{ cookiecutter.project_name }}" -F "bundle_identifier={{ cookiecutter.bundle_identifier }}" -F "platform=iOS" -F "custom_release_type=Sprint" -H "X-HockeyAppToken: {{ cookiecutter.hockey_key }}" https://rink.hockeyapp.net/api/2/apps/new | jq '.public_identifier' | sed -e 's/\"//g'`
    echo "Hockey App Sprint Key: $DEVELOP_KEY"
    perl -p -i -e "s/ZZHOCKEY_DEVELOP_IDZZ/$DEVELOP_KEY/g" fastlane/Fastfile
    perl -p -i -e "s/ZZHOCKEY_SPRINT_IDZZ/$SPRINT_KEY/g" fastlane/Fastfile
    echo "Fastfile updated"
fi

synx --no-sort-by-name "{{ cookiecutter.project_name | replace(' ', '') }}.xcodeproj"



