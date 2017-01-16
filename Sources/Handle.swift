import Regex

/**
Identifiers for the Handle registry of digital objects. http://handle.net/

Handles have a very loose definition, being formed as `<prefix>/<local_name`:

* **Prefix**

 */
public struct Handle: Identifier {
    public private(set) var value: String
    
    public init(_ value: StaticString) {
        if Handle.isValid(value.description) {
            self.value = value.description
        } else {
            preconditionFailure("Unexpected failure creating Handle '\(value)'")
        }
    }
    
    public init(string: String) throws {
        if Handle.isValid(string) {
            self.value = string
        } else {
            throw IdentifierErrors.invalidIdentifier
        }
    }
    
    public static func extract(from source: String) -> [Handle] {
        let regex = Regex("\\b[0-9.]+/\\S+\\b")
        
        return regex.allMatches(source).map { $0.matchedString }
            .flatMap { try? Handle.init(string: $0) }
    }
    
    public static func isValid(_ text: String) -> Bool {
        let regex = Regex("\\A[0-9.]+/\\S+\\z")
        
        return regex.matches(text)
    }
}

extension Handle: Equatable {
    public static func ==(lhs: Handle, rhs: Handle) -> Bool {
        return lhs.value == rhs.value
    }
}

public func ==(lhs: Handle, rhs: String) -> Bool {
    return lhs.value == rhs
}

public func ==(lhs: String, rhs: Handle) -> Bool {
    return lhs == rhs.value
}
