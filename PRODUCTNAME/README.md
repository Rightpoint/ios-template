# {{ cookiecutter.project_name }}

[![Develop](https://img.shields.io/badge/Hockey-Develop-green.svg)][develop-appcenter]
[![Sprint](https://img.shields.io/badge/Hockey-Sprint-green.svg)][sprint-appcenter]
[![CircleCI](https://circleci.com/gh/Rightpoint/{{ cookiecutter.company_name | replace(' ', '-') | lower }}-ios/tree/develop.svg?style=shield&circle-token=ZZCIRCLE_PROJECT_STATUS_KEYZZ)][circle-ci] [![codecov](https://codecov.io/gh/Rightpoint/{{ cookiecutter.company_name | replace(' ', '-') | lower }}-ios/branch/master/graph/badge.svg)](https://codecov.io/gh/Rightpoint/{{ cookiecutter.company_name | replace(' ', '-') | lower }}-ios)

## Development Process
All stories and bugs are tracked in [JIRA][]. Development occurs on branches that are tested with the `test` fastlane task once a PR is created. The PR is reviewed and then merged into the `develop` branch. This triggers the `develop` fastlane task which distributes a build to the [develop][develop-appcenter] hockey app for testing and PO approval. At the end of a sprint, a `sprint-X` tag is manually created which triggers the `sprint` fastlane task which distributes a build to the [sprint][sprint-appcenter] hockey app.

[circle-ci]: https://circleci.com/gh/Rightpoint/{{ cookiecutter.project_name }}-ios
[JIRA]: https://raizlabs.atlassian.net/secure/RapidBoard.jspa?projectKey={{ cookiecutter.jira_key }}
[sprint-appcenter]: https://rink.hockeyapp.net/apps/ZZAPPCENTER_SPRINT_IDZZ
[develop-appcenter]: https://rink.hockeyapp.net/apps/ZZAPPCENTER_DEVELOP_IDZZ

To get started, see [Contributing](#contributing)

## Setup

#### Codecov

You can use [Codecov](https://codecov.io) automatically as long as the repository's owner is a paid Codecov member (assuming this is a private repo).

#### Danger

To [set up Danger](http://danger.systems/guides/getting_started.html) on CircleCI you'll need to add a `DANGER_GITHUB_API_TOKEN` to the CI test environment. There are two bots already available for Rightpoint: for open source projects use our "OSS" bot, and for closed source projects use the "Private" bot. You'll find these tokens in our shared credential storage if you search for "GitHub Bot".

Similarly, you'll also need to set up the `CIRCLE_API_TOKEN` for build artifacts like screenshots and code coverage reports to show up in Danger.

* Find the entry "CircleCI API Tokens" in our shared credential storage. 
* Grab the "Open Source" token for open source projects, and the "Private Repos" token for closed source projects.
* Add the appropriate token as `CIRCLE_API_TOKEN` to the CircleCI build environment for this repo.

## Architecture


### Implementation Guidance

- Coordinators should:
  - Manage view controller transitions
- View Controllers should:
  - Delegate 'final' actions to a Coordinator
  - **Not** access the navigation controller or present view controllers
  - Model ViewState (ie: Value type view model)
  - Target Actions and UI Delegates should modify the controller state or delegate.
    - UI Should be configured in one one method when the state is changed.
  - Contain minimal layout functionality
- Views should:
  - Define constants only if re-used
  - Specify colors via UIAppearance
  - Prefer attributed strings for text configuration
  - Adapt to changes in text size
  - Not use constructor-injected values
  - Confirm there no ambiguous constraints in View Debugger before commit
  - Use Dynamic Type to exercise text wrapping
  - Collection View and Table View cells should be avoided in favor of a generic wrapper cell
- ViewModels should:
  - Use value semantics
  - Can be called an `Item` or `State` as needed
  - Use extensions to integration View integration
- Services Should
  - Expose contract via Protocol
  - Define domain specific logic
    - Validation
    - Entity Graph Management
    - Invoke server actions
    - Identifier management, uniquing and encapsulation
  - Encapsulate networking and persistence details
    - Transparently refresh OAuth tokens
    - Return persisted cache and refresh local store
    - Do not expose NSManagedObjectContext
    - Expose identifiers as opaque objects

To view dependencies, view the [Podfile](app/Podfile).

## Contributing

### Setup
```bash
git clone git@github.com:Rightpoint/{{ cookiecutter.project_name }}-ios.git
cd {{ cookiecutter.project_name }}-ios
bundle install
cd app
bundle exec fastlane test
```

### Dependencies
When adding a dependency is necessary it should be managed using Cocoapods. After running `bundle exec pod install` the built version should be committed to the repository to keep

### Branching

Both branches `develop` and `master` are protected and should only be modified by filing a pull request. `develop` represents the latest accepted changes and `master` should represent the latest **shippable** source.

Development should take place on a development branch cut from the existing `develop` branch. Before merging all development branches should be rebased off of `develop`. _Please_ do not merge `develop` upstream.

Development branches should follow the convention:
`{bugfix | feature}/{developer initials}-{JIRA_ID}`

Release branches should be tagged and cut from `master` as:
`release-0.0.0`

### Testing

All non-trivial code should be tested. Contributors are encouraged to use [TDD](https://en.wikipedia.org/wiki/Test-driven_development) where applicable.

All development branches must pass CI before merging. Save yourself some trouble and run `bundle exec fastlane test` before filing a pull request.

### Synx
To keep the Application structure orderly, organize code logically into groups using Xcode and run [synx](https://github.com/venmo/synx) (`bundle exec fastlane synx`) before commiting.

## Additional Notes

#### xcov

[xcov](https://github.com/nakiostudio/xcov) generates nicely formatted HTML code coverage reports, and is triggered with every `fastlane test`. The results are located in the `app/build/xcov` folder, just open `index.html`. When run on CircleCI they stored as build artifacts.

`xcov` also works with Danger to provide code coverage feedback on every pull request. You can also trigger it manually. The `include_targets` filtering is to exclude external stuff like CocoaPods, but for some reason thinks the target product name for `debug-PRODUCTNAME` is `develop-PRODUCTNAME.app`. 

You should add other internal frameworks to `include_targets` inside the `Dangerfile` and `Fastfile` as development progresses.

```bash
# Manually

# fastlane will run xcov for you
$ bundle exec fastlane test

# when run manually, you must first build via `fastlane test` to generate Xcode's internal code coverage reports
$ bundle exec xcov -w app/PRODUCTNAME.xcworkspace/ -s debug-PRODUCTNAME --include_targets "develop-PRODUCTNAME.app, Services.framework" -o app/build/xcov
```

```ruby
# Fastfile
  xcov(
    workspace: "PRODUCTNAME.xcworkspace",
    scheme: "debug-PRODUCTNAME",
    output_directory: "#{ENV['RZ_TEST_REPORTS']}/xcov",
     # For some reason coverage is on the "develop-" app target instead of "debug-"
    include_targets: "develop-PRODUCTNAME.app, Services.framework",
  )
```

```ruby
# Dangerfile
xcov.report(
  workspace: "#{src_root}/PRODUCTNAME.xcworkspace",
  scheme: "debug-PRODUCTNAME",
  output_directory: "#{ENV['RZ_TEST_REPORTS']}/xcov",
   # For some reason coverage is on the "develop-" app target instead of "debug-"
  include_targets: "develop-PRODUCTNAME.app, Services.framework",
  ignore_file_path: "#{src_root}/fastlane/.xcovignore"
) 
```

#### Slather

[Slather](https://github.com/SlatherOrg/slather) is an alternative to `xcov` and is capable of generating more comprensive HTML reports (located in `app/build/slather`), as well as uploading to a number of code coverage services like Codecov and  Coveralls. It is also integrated into `fastlane test` but you can run it manually.

There is a similar issue to `xcov` where the scheme for the app target cannot be found, so right now only `Services` is included.

```bash
# Using fastlane
$ bundle exec fastlane test

# Manually run and open HTML report
$ bundle exec slather coverage --show --html --scheme Services --workspace app/PRODUCTNAME.xcworkspace/ --output-directory app/build/slather app/PRODUCTNAME.xcodeproj/
```

```ruby
# Fastfile

slather(
	proj: "PRODUCTNAME.xcodeproj",
	workspace: "PRODUCTNAME.xcworkspace",
	# Only the Services scheme seems to work. It cannot find our app target schemes. 
	scheme: "Services",
	output_directory: "#{ENV['RZ_TEST_REPORTS']}/slather",
	html: "true",
)
```