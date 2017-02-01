import Regex

internal struct ArxivIdPost2007: Scheme, Extractable {
    public static let identifierPattern = "(?:arXiv:)?\\d{4}\\.\\d{4,5}(?:v\\d+)?"
    
    public static func normalize(value: String) -> String {
        let regex = Regex("\\Aarxiv:", options: .IgnoreCase)
        return value.replacingFirstMatching(regex, with: "")
    }
}
