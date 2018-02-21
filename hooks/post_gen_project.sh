#!/bin/sh

set -e

git init
bundle install
cd app
bundle exec pod install
if [[ "{{ cookiecutter.hockey_key }}" =~ .*[nN][oO].* ]]
then
    echo "Skipping hockey app generation"
else
    export DEVELOP_KEY=`curl -F "title={{ cookiecutter.project_name }}" -F "bundle_identifier={{ cookiecutter.bundle_identifier }}" -F "platform=iOS" -F "custom_release_type=Develop" -H "X-HockeyAppToken: {{ cookiecutter.hockey_key }}" https://rink.hockeyapp.net/api/2/apps/new | jq '.public_identifier' | sed -e 's/\"//g'`
    echo "Hockey App Develop Key: $DEVELOP_KEY"
    export SPRINT_KEY=`curl -F "title={{ cookiecutter.project_name }}" -F "bundle_identifier={{ cookiecutter.bundle_identifier }}" -F "platform=iOS" -F "custom_release_type=Sprint" -H "X-HockeyAppToken: {{ cookiecutter.hockey_key }}" https://rink.hockeyapp.net/api/2/apps/new | jq '.public_identifier' | sed -e 's/\"//g'`
    echo "Hockey App Sprint Key: $DEVELOP_KEY"
    perl -p -i -e "s/ZZHOCKEY_DEVELOP_IDZZ/$DEVELOP_KEY/g" fastlane/Fastfile
    perl -p -i -e "s/ZZHOCKEY_SPRINT_IDZZ/$SPRINT_KEY/g" fastlane/Fastfile
    echo "Fastfile updated"
    perl -p -i -e "s/ZZHOCKEY_DEVELOP_IDZZ/$DEVELOP_KEY/g" ../README.md
    perl -p -i -e "s/ZZHOCKEY_SPRINT_IDZZ/$SPRINT_KEY/g" ../README.md
    echo "README updated"
fi

bundle exec synx --no-sort-by-name "{{ cookiecutter.project_name | replace(' ', '') }}.xcodeproj"

cat <<EOF
Congratulations! Please perform the following tasks:

- Ensure your project name didn't include "-ios"
- Enable Circle CI
  - Create a Status token in "Settings -> API Permissions" and replace ZZCIRCLE_PROJECT_STATUS_KEYZZ in README.md
  - Under "Settings -> Advanced Settings", turn on "Only build pull requests"
- Configure Github
  - Protect "master" and "develop". Set "develop" as the default branch
- Ensure the Hockey Apps created have the correct teams
- Review README.md architecture guidance
- Make a PR against ios-template fixing any issues encountered
  - Update fastlane / Cocoapods in the Gemfile
EOF


