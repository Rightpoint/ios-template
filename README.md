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
2. Run `cookiecutter gh:raizlabs/ios-template`.
3. Delete anything that is not of interest to your project.

[cookiecutter]: http://cookiecutter.readthedocs.org/en/latest/installation.html


## Cookie Cutter
Cookie Cutter is a python project for templating files and directories. Cookie cutter will ask a serires of questions as defined in `cookiecutter.json` and then run the expansion on the contained files and directory names, and file contents. Anything with `{{ cookiecutter.variable }}` is expanded when the template is expanded. This is a powerful primitive, but has some complications with Xcode

## Managing an XCode Project Template
If you place a cookie cutter expansion in a `.pbxproj` file, Xcode will no longer open the project file. To simplify managing the Xcode project, I have a more primitive expansion script in `generate_template.sh` that will replace a smaller set of words with cookiecutter variables. In particular `PRODUCTNAME` is expanded to `{{ cookiecutter.project_name }}`. Using this simpler form of expansion allows the project in the `PRODUCTNAME` directory to continue to work in Xcode, and lets you manage your template just like any other Xcode project. When you are done with modifications, run `generate_template.sh | sh`.

If you are looking to do specific Xcode project modifications, I would recommend using `.xcconfig` files, and placing any expansion in those files. If you are looking to expand variables outside of the project file, you can use cookie cutters `{{ cookiecutter.whatever }}` variables directly.

## Post processing
Cookie cutter follows a pattern of expand and prune, where the superset of the template is expanded, and then any specific functionality is pruned in a post in shell script `post_gen_project.sh`. You can also run shell scripts to integrate with webservices. The included `post_gen_project.sh` is a good example of this and it will create 2 apps on hockey and configure the `Fastfile`.


