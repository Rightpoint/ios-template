# iOS template

A template for new iOS projects at Raizlabs.

Inspired by [thoughtbot]/[ios-template]

[thoughtbot]: https://thoughtbot.com/
[ios-template]: https://github.com/thoughtbot/ios-template

## What's in the template?

 - [Default Cocoapods][pods]
 - [Default Fastfile][fastfile] with [curl][hockey] commands to create apps on Hockey
 - [APIClient Stub][apiclient]
 - Default [swiftlint]
 - SwiftGen configured for strings and images
 - Configuration for [CircleCI]

[pods]: %7B%7B%20cookiecutter.project_name%20%7D%7D/app/Podfile
[fastfile]: %7B%7B%20cookiecutter.project_name%20%7D%7D/app/fastlane/Fastfile
[apiclient]: %7B%7B%20cookiecutter.project_name%20%7D%7D/app/%7B%7B%20cookiecutter.project_name%20%7D%7D/API
[CircleCI]: %7B%7B%20cookiecutter.project_name%20%7D%7D/circle.yml
[swiftlint]: %7B%7B%20cookiecutter.project_name%20%7D%7D/app/.swiftlint.yml
[hockey]: cookiecutter.json

## Usage

1. [Install cookiecutter][cookiecutter] (`brew install cookiecutter` on
   macOS).
2. Run `cookiecutter gh:raizlabs/ios-template`

[cookiecutter]: http://cookiecutter.readthedocs.org/en/latest/installation.html



## Updating Template

Cookie cutter requires a lot of templating that is hard to work with. In particular, files with a variable name in them (`{{ cookiecutter.foo }}`) can not be opened in Xcode. To keep the template easy to update, there's a script `generate_template.sh | sh` which will transform the demo in `PRODUCTNAME` into the template directory. This is a bit meta, but it is very nice to be able to open the project in Xcode in order to maintain the template.
