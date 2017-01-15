import Regex

public struct DOI {
  public enum Errors: Error, Equatable {
    /// Does not match the accepted standard format of DOIs
    case invalidDOI
  }

  public private(set) var value: String

  /// Create a `DOI` based on a static string within code.
  ///
  /// Unlike `DOI.init(string:)` this initialiser is not failable. if `value`
  /// is not a valid DOI, it is considered a programmer error rather than a
  /// programmable runtime error, so a precondition failure is raised instead.
  ///
  /// - requires: `value` is a valid DOI expressed as a string literal
  /// - parameters:
  ///   - value: a valid DOI
  public init(_ value: StaticString) {
    if DOI.isValid(value.description) {
      self.value = value.description.lowercased()
    } else {
      preconditionFailure("Unexpected failure creating DOI '\(value)'")
    }
  }

  /// Create a `DOI` based on a string variable.
  ///
  /// Unlike `DOI.init(_:)`, this initializer is failable, and will throw a
  /// `DOI.Errors.invalidDOI` if the supplied string does not match a complete
  /// and valid DOI. If a valid DOI is supplied, it will be stored with all
  /// text characters lowercased.
  ///
  /// - Throws: `DOI.Errors.invalidDOI`
  public init(string: String) throws {
    if DOI.isValid(string) {
      self.value = string.lowercased()
    } else {
      throw Errors.invalidDOI
    }
  }

  /// Find all valid DOIs in a given string.
  /// - Returns: an array of matching `DOI` objects
  public static func extract(from source: String) -> [DOI] {
    let regex = Regex("\\b10\\.\\d{3,}/\\S+\\b")
    return regex.allMatches(source).map { $0.matchedString }
      .flatMap { try? DOI.init(string: $0) }
  }

  /// Check a given piece of text for DOI validity
  public static func isValid(_ text: String) -> Bool {
    let regex = Regex("\\A10\\.\\d{3,}/\\S+\\z")

    return regex.matches(text)
  }
}

extension DOI: Equatable {
  public static func ==(lhs: DOI, rhs: DOI) -> Bool {
    return lhs.value == rhs.value
  }
}

public func ==(lhs: DOI, rhs: String) -> Bool {
  return lhs.value == rhs
}

public func ==(lhs: String, rhs: DOI) -> Bool {
  return lhs == rhs.value
}
