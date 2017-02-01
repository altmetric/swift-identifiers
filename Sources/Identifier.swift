public enum IdentifierErrors: Error {
    case invalidIdentifier
}

/// Establishes a common interface across all identifier types
public struct Identifier<T: Scheme> {
    /// Internal representation of the identifier
    public let value: String
    
    /// Create an identifier with a string literal. Incorrectly structured identifiers should generate a precondition failure, as it is considered a developer error.
    public init(_ staticValue: StaticString) {
        let value = staticValue.description
        guard T.isValid(value: value) else {
            preconditionFailure("Value '\(value)' is not valid")
        }
        self.value = T.normalize(value: value)
    }
    
    /// Create an identifier from a supplied string. An invalid identifier is expected to throw an error
    public init(value: String) throws {
        guard T.isValid(value: value) else {
            throw IdentifierErrors.invalidIdentifier
        }
        self.value = T.normalize(value: value)
    }
    
    /// Extract any text strings matching the identifier's format, and return them as a collection of Identifiers.
    /// - parameters:
    ///   - from: a String to be scanned for all possible matches
    /// - returns:
    ///   - an array of identifiers located in the string, if any.
    ///   - if no matches are found, an empty array is returned
    public static func extract(from source: String) -> [Identifier<T>] {
        return T.extract(from: source)
            .map { $0.matchedString }
            .flatMap { try? Identifier<T>(value: $0) }
    }
}

extension Identifier: Equatable { }

public func ==<T: Scheme>(lhs: Identifier<T>, rhs: Identifier<T>) -> Bool {
    return lhs.value == rhs.value
}
