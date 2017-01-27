import Regex

public protocol Scheme {
    static var validationRegex: Regex { get }
    static var extractionRegex: Regex { get }
    
    static func isValid(value: String) -> Bool
    static func normalize(value: String) -> String
}

extension Scheme {
    public static func isValid(value: String) -> Bool {
        return validationRegex.matches(value)
    }
    
    public static func normalize(value: String) -> String {
        return value
    }
}
