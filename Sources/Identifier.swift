public enum IdentifierErrors: Error {
    case invalidIdentifier
}

/// Establishes a common interface across all identifier types
public protocol Identifier: Equatable {
    /// Internal representation of the identifier
    var value: String { get }
    
    /// Create an identifier with a string literal. Incorrectly structured identifiers should generate a precondition failure, as it is considered a developer error.
    init(_ value: StaticString)
    
    /// Create an identifier from a supplied string. An invalid identifier is expected to throw an error
    init(string: String) throws
    
    /// Extract any text strings matching the identifier's format, and return them as a collection of Identifiers.
    /// - parameters:
    ///   - from: a String to be scanned for all possible matches
    /// - returns:
    ///   - an array of identifiers located in the string, if any.
    ///   - if no matches are found, an empty array is returned
    static func extract(from: String) -> [Self]
    
    /// Establish whether the given text is a valid identifier
    /// - parameters:
    ///   - text: Possible identifier value
    /// - returns:
    ///   - `true` if the entire supplied string matches the identifier's structure
    ///   - `false` if the identifier does not match the syntax, or if it has extraneous text either side of a valid identifier
    static func isValid(_ text: String) -> Bool
}
