import Regex

public protocol MultipleScheme: Scheme {
    static var schemes: [Scheme.Type] { get }
}

extension MultipleScheme {
    public static func isValid(value: String) -> Bool {
        for schemeType in schemes {
            if schemeType.isValid(value: value) {
                return true
            }
        }
        return false
    }
    
    public static func extract(from source: String) -> [MatchResult] {
        var extractedResults: [MatchResult] = []
        for schemeType in schemes {
            extractedResults.append(contentsOf: schemeType.extract(from: source))
        }
        return extractedResults
    }
}
