# iOS Template

[![Swift 4.2](https://img.shields.io/badge/Swift-4.2-orange.svg?style=flat)](https://swift.org)
[![CircleCI](https://img.shields.io/circleci/project/github/Rightpoint/ios-template/master.svg)](https://circleci.com/gh/Rightpoint/ios-template) [![codecov](https://codecov.io/gh/Rightpoint/ios-template/branch/master/graph/badge.svg)](https://codecov.io/gh/Rightpoint/ios-template)

A template for new iOS projects at Raizlabs.

Inspired by [thoughtbot]/[ios-template]

[thoughtbot]: https://thoughtbot.com/
[ios-template]: https://github.com/thoughtbot/ios-template

### Quick Start

```bash
# Set up Ruby
$ brew install ruby
$ gem install bundler
# Set up Python
$ brew install python3
$ pip3 install cookiecutter
# Run Cookiecutter
$ cookiecutter https://github.com/Raizlabs/ios-template/archive/master.zip
```

### Template Output

[![CircleCI](https://img.shields.io/circleci/project/github/Rightpoint/ios-template-output/master.svg)](https://circleci.com/gh/Rightpoint/ios-template-output)

Pushing updates to this repository triggers CircleCI to build a blank template and push the result to the [ios-template-output](https://github.com/Raizlabs/ios-template-output) repository. If the badge above is failing, most likely there is a problem with the inner CircleCI script located in `PRODUCTNAME/.circleci/config.yml`.

## What's in the template?

 - Configures the project name, company name, lead name, an initial local repo, gitignore, and synx.
 - Option to configure [Hockey][hockey] apps automatically.
 - [Default Fastfile][fastfile] with test, develop, sprint, beta and release lanes and slack notifications.
 - Configuration for [CircleCI][CircleCI] with auto-triggered builds for merges to develop or tags prefixed with sprint, beta or release.
 - [Danger](https://danger.systems) to automatically enforce conventions on every pull request.
 - [APIClient Stub][apiclient] with functional OAuth implementation and APIEndpoint protocol.
 - [SwiftGen][SwiftGen] configured to generate localized strings and image enums.
 - Default [swiftlint][swiftlint] rules to help enforce code style standards across projects.
 - [Default set of Cocoapods][pods] including:
   - [Anchorage][anchorage] - "A lightweight collection of intuitive operators and utilities that simplify iOS layout code."
   - [BonMot][bonmot] - "Beautiful, easy attributed strings in Swift"
   - [Swiftilities][swiftilities] - Keyboard avoidance guides, lifecycle event code injection, about view, accessibility helpers, color helpers, device size detection, hairline views, logging
   - [KeychainAccess][keychainaccess] - Wrapper for keychain APIs. Used by the Oath implementation to protect credentials
   - [OHHTTPStubs][ohhttpstubs] - Stub API requests with edge case datasets for unit tests or to fake an endpoint while it is in development.

[pods]: PRODUCTNAME/app/Podfile
[anchorage]: https://github.com/Raizlabs/Anchorage
[swiftilities]: https://github.com/Raizlabs/Swiftilities
[bonmot]: httpss://github.com/Raizlabs/BonMot
[keychainaccess]: https://github.com/kishikawakatsumi/KeychainAccess
[ohhttpstubs]: https://github.com/AliSoftware/OHHTTPStubs
[fastfile]: PRODUCTNAME/app/fastlane/Fastfile
[apiclient]: PRODUCTNAME/app/PRODUCTNAME/API 
[CircleCI]: PRODUCTNAME/circle.yml
[swiftlint]: PRODUCTNAME/app/.swiftlint.yml
[hockey]: hooks/post_gen_project.sh
[swiftgen]: https://github.com/SwiftGen/SwiftGen

## Contributing

### Regenerating the Template

⚠️ **Do not** make changes to the `{{ cookiecutter.project_name | replace(' ', '') }}` directory directly! You must first make your changes in the `PRODUCTNAME` folder and then run the `generate_template.sh` script. 

If you place a cookie cutter expansion in a `.pbxproj` file, Xcode will no longer open the project file. To simplify managing the Xcode project, I have a more primitive expansion script in `generate_template.sh` that will replace a smaller set of words with cookiecutter variables. In particular, `PRODUCTNAME` is expanded to `{{ cookiecutter.project_name }}`. Using this simpler form of expansion allows the project in the `PRODUCTNAME` directory to continue to work in Xcode, and lets you manage your template just like any other Xcode project. 

**Every time** you make changes to the PRODUCTNAME folder, you must run `generate_template.sh`:

```bash
$ ./generate_template.sh
```

This script will regenerate the template from scratch, and then verify that it works by running cookiecutter on it, and building/testing the result.

If you are looking to do specific Xcode project modifications, I would recommend using `.xcconfig` files, and placing any expansion in those files. If you are looking to expand variables outside of the project file, you can use cookie cutters `{{ cookiecutter.whatever }}` variables directly.

Environmental variable options accepted by `generate_template.sh`:

* `VERBOSE=true`: Prints more verbose output.
* `SKIP_REGENERATION=true`: Does not alter the generated cookiecutter template.
* `SKIP_TESTS=true`: Does not perform tests after generating template.
* `KEEP_COOKIECUTTER_OUTPUT=true`: Do not delete cookiecutter output after running tests (final output is in `ProjectName` directory).
* `OUTPUT_DIR`: Use a different output directory (default is current directory)

#### Testing Your Changes

```bash
cookiecutter --no-input --overwrite-if-exists ./
```

After running the `generate_template.sh` script, you can manually run `cookiecutter` and examine the results in the `ProjectName` folder.

## Configuring the generated project
### Fastlane

### Crashlytics

### Instabug

### OAuth Endpoint

### APIClient 

### Code Coverage

`xcov` and `slather` build artifacts are stored on CircleCI with every build and can be accessed within the Artifacts tab of each build. For more information see the `PRODUCTNAME/README.md`.

#### Codecov

You can use [Codecov](https://codecov.io) automatically as long as the repository's owner is a paid Codecov member (assuming this is a private repo).

### Danger

To [set up Danger](http://danger.systems/guides/getting_started.html) on CircleCI you'll need to add a `DANGER_GITHUB_API_TOKEN` to the test environment. There are two bots already available for Raizlabs: for open source projects use our "OSS" bot, and for closed source projects use the "Private" bot.

## Cookie Cutter
Cookie Cutter is a python project for templating files and directories. Cookie cutter will ask a series of questions as defined in `cookiecutter.json` and then run the expansion on the contained files and directory names, and file contents. Anything with `{{ cookiecutter.variable }}` is expanded when the template is expanded. This is a powerful primitive but has some complications with Xcode

## Post processing
Cookie cutter follows a pattern of expand and prune, where the superset of the template is expanded, and then any specific functionality is pruned in a post in shell script `post_gen_project.sh`. You can also run shell scripts to integrate with web services. The included `post_gen_project.sh` is a good example of this, and it will create 2 apps on hockey and configure the `Fastfile`.
