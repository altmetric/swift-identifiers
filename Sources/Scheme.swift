import Regex

public protocol Scheme {
    static func isValid(value: String) -> Bool
    static func extract(from: String) -> [MatchResult]
    static func normalize(value: String) -> String
}

public protocol Extractable {
    static var identifierPattern: String { get }
    static var validationRegex: Regex { get }
    static var extractionRegex: Regex { get }
}

extension Extractable {
    public static var validationRegex: Regex {
        do {
            return try Regex(string: "\\A\(identifierPattern)\\z", options: .IgnoreCase)
        } catch {
            preconditionFailure("Could not use identifierPattern '\(identifierPattern)' for validation")
        }
    }

    public static var extractionRegex: Regex {
        do {
            return try Regex(string: "\\b\(identifierPattern)\\b", options: .IgnoreCase)
        } catch {
            preconditionFailure("Could not use identifierPattern '\(identifierPattern)' for extraction")
        }
    }
}

extension Scheme where Self: Extractable {
    public static func isValid(value: String) -> Bool {
        return validationRegex.matches(value)
    }
    
    static func extract(from source: String) -> [MatchResult] {
        return extractionRegex.allMatches(source)
            .filter { isValid(value: $0.matchedString) }
    }
    
    public static func normalize(value: String) -> String {
        return value
    }
}

