import Regex

/**
 A representation of an **ArXiv ID.
 
 The article identifier scheme used by arXiv has two distinct schemes, after 
 being changed in 2007. These two schemes are distinguished in code as 
 `pre2007` and `post2007`.
 
 **Post-2007** identifiers are structured as `arXiv:<year><month>.<number>`,
 or as a versioned form `arXiv:<year><month>.<number>v<version>`, e.g. `arXiv:1501.00001` or `arXiv:0706.0001v2`:
 
 * **Year** is the two-digit year
 * **Month** is the two-digit month
 * **Number** is a four or five digit number
 * **Version** is one or more digits denoting a specific version of a paper, separated from the number component by a literal letter `v`
 
 **Pre-2007** identifiers are in the format `<archive>.<subject>/<year><month><number>`, e.g., `math.GT/0309136`:
 
 * The **archive** is a top-level subject group
 * The **subject** is a two-letter subcategory of the archive group
 * **Year** is the two-digit year of publication
 * **Month** is the two-digit month of publication
 * **Number** is a three-digit sequential identifier

 The post-2007 format officially includes an `arXiv:` prefix. This library does not require this; if found ahead of any (pre or post-2007) arXiv ID, the `arxiv:` prefix is not stored.
 
 For more details, see [the ArXiv ID help page on identifier formats][arxiv]
 
 [arxiv]: https://arxiv.org/help/arxiv_identifier
*/
public struct ArxivId: Identifier {
    public enum Errors: Error, Equatable {
        case invalidArxivId
    }
    
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

public func ==(lhs: ArxivId, rhs: String) -> Bool {
    return lhs.value == rhs
}

public func ==(lhs: String, rhs: ArxivId) -> Bool {
    return lhs == rhs.value
}
