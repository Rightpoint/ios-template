# iOS template

A template for new iOS projects at Raizlabs.

Inspired by [thoughtbot]/[ios-template]

[thoughtbot]: https://thoughtbot.com/
[ios-template]: https://github.com/thoughtbot/ios-template

## What's in the template?

 - Configures the project name, company name, lead name, an initial local repo, gitignore, and synx.
 - Option to configure [Hockey][hockey] apps automatically.
 - [Default Fastfile][fastfile] with test, develop, sprint, beta and release lanes and slack notifications.
 - Configuration for [CircleCI][CircleCI] with auto-triggered builds for merges to develop or tags prefixed with sprint, beta or release.
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

## Usage

1. [Install cookiecutter][cookiecutter] (`brew install cookiecutter` on
   macOS).
1. Run `cookiecutter gh:raizlabs/ios-template`.
1. Answer the questions.
1. Delete anything that is not of interest to your project.

[cookiecutter]: http://cookiecutter.readthedocs.org/en/latest/installation.html

## Configuring the generated project
### Fastlane

### Crashlytics

### Instabug

### OAuth Endpoint

### APIClient 

## Cookie Cutter
Cookie Cutter is a python project for templating files and directories. Cookie cutter will ask a series of questions as defined in `cookiecutter.json` and then run the expansion on the contained files and directory names, and file contents. Anything with `{{ cookiecutter.variable }}` is expanded when the template is expanded. This is a powerful primitive but has some complications with Xcode

## Post processing
Cookie cutter follows a pattern of expand and prune, where the superset of the template is expanded, and then any specific functionality is pruned in a post in shell script `post_gen_project.sh`. You can also run shell scripts to integrate with web services. The included `post_gen_project.sh` is a good example of this, and it will create 2 apps on hockey and configure the `Fastfile`.

## Contributing to the template

### Managing an XCode Project Template
If you place a cookie cutter expansion in a `.pbxproj` file, Xcode will no longer open the project file. To simplify managing the Xcode project, I have a more primitive expansion script in `generate_template.sh` that will replace a smaller set of words with cookiecutter variables. In particular, `PRODUCTNAME` is expanded to `{{ cookiecutter.project_name }}`. Using this simpler form of expansion allows the project in the `PRODUCTNAME` directory to continue to work in Xcode, and lets you manage your template just like any other Xcode project. When you are done with modifications, run `generate_template.sh | sh`.

If you are looking to do specific Xcode project modifications, I would recommend using `.xcconfig` files, and placing any expansion in those files. If you are looking to expand variables outside of the project file, you can use cookie cutters `{{ cookiecutter.whatever }}` variables directly.


