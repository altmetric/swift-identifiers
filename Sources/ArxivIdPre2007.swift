import Regex

internal struct ArxivIdPre2007: Scheme, Extractable {
    public static let identifierPattern = "(?:arXiv:)?([a-z-]+(?:\\.[A-Z]{2})?/\\d{2}(?:0[1-9]|1[012])\\d{3}(?:v\\d+)?)"
    
    public static func normalize(value: String) -> String {
        let regex = Regex("\\Aarxiv:", options: .IgnoreCase)
        return value.replacingFirstMatching(regex, with: "")
    }
}
