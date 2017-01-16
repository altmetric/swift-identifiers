import Regex

public struct ArxivId {
    public enum Errors: Error, Equatable {
        case invalidArxivId
    }
    
    /// The string representation of the Arxiv ID
    public private(set) var value: String
    
    public init(_ value: StaticString) {
        self.value = ArxivId.withoutPrefix(string: value.description)
    }
    
    public init(string: String) throws {
        if ArxivId.isValid(string) {
            self.value = ArxivId.withoutPrefix(string: string)
        } else {
            throw Errors.invalidArxivId
        }
    }
    
    public static func extract(from source: String) -> [ArxivId] {
        return extractPre2007ArxivIds(from: source) + extractPost2007ArxivIds(from: source)
    }
    
    private static func extractPre2007ArxivIds(from source: String) -> [ArxivId] {
        let pre2007regex = Regex("(?<=^|\\b|/)(?:arXiv:)?[a-z-]+(?:\\.[A-Z]{2})?/\\d{2}(?:0[1-9]|1[012])\\d{3}(?:v\\d+)?(?=$|\\b)", options: .IgnoreCase)
        return pre2007regex.allMatches(source)
            .map { $0.matchedString }
            .map(ArxivId.withoutPrefix(string:))
            .flatMap { try? ArxivId.init(string: $0) }
    }

    private static func extractPost2007ArxivIds(from source: String) -> [ArxivId] {
        let post2007regex = Regex("(?<=^|\\b|/)(?:arXiv:)?\\d{4}\\.\\d{4,5}(?:v\\d+)?(?=$|\\b)", options: .IgnoreCase)
        return post2007regex.allMatches(source)
            .map { $0.matchedString }
            .map(ArxivId.withoutPrefix(string:))
            .flatMap { try? ArxivId.init(string: $0) }
    }

    public static func isValid(_ text: String) -> Bool {
        return isValidPre2007(text) || isValidPost2007(text)
    }
    
    private static func isValidPre2007(_ text: String) -> Bool {
        let pre2007regex = Regex("\\A(?<=^|\\b|/)(?:arXiv:)?[a-z-]+(?:\\.[A-Z]{2})?/\\d{2}(?:0[1-9]|1[012])\\d{3}(?:v\\d+)?(?=$|\\b)\\z", options: .IgnoreCase)
        return pre2007regex.matches(text)
    }

    private static func isValidPost2007(_ text: String) -> Bool {
        let post2007regex = Regex("\\A(?<=^|\\b|/)(?:arXiv:)?\\d{4}\\.\\d{4,5}(?:v\\d+)?(?=$|\\b)\\z", options: .IgnoreCase)
        return post2007regex.matches(text)
    }

    private static func withoutPrefix(string: String) -> String {
        let regex = Regex("\\Aarxiv:", options: .IgnoreCase)
        return string.replacingFirstMatching(regex, with: "")
    }
}

extension ArxivId: Equatable {
    public static func ==(lhs: ArxivId, rhs: ArxivId) -> Bool {
        return lhs.value == rhs.value
    }
}
