// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {

  enum Home {
    /// {{ cookiecutter.project_name | replace(' ', '') }}
    static let title = L10n.tr("Localizable", "Home.Title")
  }

  enum Onboarding {

    enum Buttons {
      /// Join
      static let join = L10n.tr("Localizable", "Onboarding.Buttons.Join")
      /// Already have an account? Sign in.
      static let signIn = L10n.tr("Localizable", "Onboarding.Buttons.SignIn")
      /// Skip
      static let skip = L10n.tr("Localizable", "Onboarding.Buttons.Skip")
    }

    enum Pages {

      enum Sample {
        /// This is body copy for the onboarding and should be replaced with real text!
        static let body = L10n.tr("Localizable", "Onboarding.Pages.Sample.Body")
        /// HEADING TEXT
        static let heading = L10n.tr("Localizable", "Onboarding.Pages.Sample.Heading")
      }
    }
  }

  enum Signin {
    /// Sign In
    static let title = L10n.tr("Localizable", "SignIn.Title")
  }

  enum Signup {
    /// Sign Up
    static let title = L10n.tr("Localizable", "SignUp.Title")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
