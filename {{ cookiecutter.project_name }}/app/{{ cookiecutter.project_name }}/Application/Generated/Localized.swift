// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable type_body_length
enum Localized {
  /// {{ cookiecutter.project_name }}
  case titleNavigation
}
// swiftlint:enable type_body_length

extension Localized: CustomStringConvertible {
  var description: String { return self.string }

  var string: String {
    switch self {
      case .titleNavigation:
        return Localized.tr(key: "Title.Navigation")
    }
  }

  private static func tr(key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

func tr(key: Localized) -> String {
  return key.string
}
