fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios test
```
fastlane ios test
```
Runs tests
### ios coverage
```
fastlane ios coverage
```
Runs Code Coverage
### ios slackshots
```
fastlane ios slackshots
```
Posts screenshots to Slack
### ios develop
```
fastlane ios develop
```
Builds and submits a Develop release to AppCenter
### ios sprint
```
fastlane ios sprint
```
Builds and submits a Sprint release to AppCenter
### ios beta
```
fastlane ios beta
```

### ios synx
```
fastlane ios synx
```
Sync Project and Directory Structure
### ios sync_match
```
fastlane ios sync_match
```
Syncs all match credentials with the developer portal, generating any required credentials

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
