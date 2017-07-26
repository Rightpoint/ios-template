// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  typealias Image = UIImage
#elseif os(OSX)
  import AppKit.NSImage
  typealias Image = NSImage
#endif

// swiftlint:disable file_length
// swiftlint:disable line_length
// swiftlint:disable nesting

struct AssetType: ExpressibleByStringLiteral {
  fileprivate var value: String

  var image: Image {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = Image(named: value, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: value)
    #elseif os(watchOS)
    let image = Image(named: value)
    #endif
    guard let result = image else { fatalError("Unable to load image \(value).") }
    return result
  }

  init(stringLiteral value: String) {
    self.value = value
  }

  init(extendedGraphemeClusterLiteral value: String) {
    self.init(stringLiteral: value)
  }

  init(unicodeScalarLiteral value: String) {
    self.init(stringLiteral: value)
  }
}

// swiftlint:disable type_body_length
enum Asset {
  static let logoKennyLoggins: AssetType = "logo-kenny-loggins"
}
// swiftlint:enable type_body_length

extension Image {
  convenience init!(asset: AssetType) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.value, in: bundle, compatibleWith: nil)
    #elseif os(OSX) || os(watchOS)
    self.init(named: asset.value)
    #endif
  }
}

private final class BundleToken {}
