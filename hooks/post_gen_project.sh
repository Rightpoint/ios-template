#!/bin/sh

set -e

git init
bundle install
cd app
bundle exec pod install

bundle exec synx --no-sort-by-name "{{ cookiecutter.project_name | replace(' ', '') }}.xcodeproj"

cat <<EOF
Congratulations! Please perform the following tasks:

- Ensure your project name didn't include "-ios"
- Enable Circle CI
  - Create a Status token in "Settings -> API Permissions" and replace ZZCIRCLE_PROJECT_STATUS_KEYZZ in README.md
  - Under "Settings -> Advanced Settings", turn on "Only build pull requests"
- Configure Github
  - Protect "master" and "develop". Set "develop" as the default branch
- Ensure the AppCenter Apps created have the correct teams
- Review README.md architecture guidance
- Make a PR against ios-template fixing any issues encountered
  - Update fastlane / Cocoapods in the Gemfile
EOF


