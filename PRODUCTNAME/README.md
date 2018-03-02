# {{ cookiecutter.project_name }}

[![Develop](https://img.shields.io/badge/Hockey-Develop-green.svg)][develop-hockey]
[![Sprint](https://img.shields.io/badge/Hockey-Sprint-green.svg)][sprint-hockey]
[![CircleCI](https://circleci.com/gh/Raizlabs/{{ cookiecutter.project_name }}-ios/tree/develop.svg?style=shield&circle-token=ZZCIRCLE_PROJECT_STATUS_KEYZZ)][circle-ci]

## Development Process
All stories and bugs are tracked in [JIRA][]. Development occurs on branches that are tested with the `test` fastlane task once a PR is created. The PR is reviewed and then merged into the `develop` branch. This triggers the `develop` fastlane task which distributes a build to the [develop][develop-hockey] hockey app for testing and PO approval. At the end of a sprint, a `sprint-X` tag is manually created which triggers the `sprint` fastlane task which distributes a build to the [sprint][sprint-hockey] hockey app.

[circle-ci]: https://circleci.com/gh/Raizlabs/{{ cookiecutter.project_name }}-ios
[JIRA]: https://raizlabs.atlassian.net/secure/RapidBoard.jspa?projectKey={{ cookiecutter.jira_key }}
[sprint-hockey]: https://rink.hockeyapp.net/apps/ZZHOCKEY_SPRINT_IDZZ
[develop-hockey]: https://rink.hockeyapp.net/apps/ZZHOCKEY_DEVELOP_IDZZ

To get started, see [Contributing](#contributing)

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
git clone git@github.com:Raizlabs/{{ cookiecutter.project_name }}-ios.git
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
