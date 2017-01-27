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
public struct ArxivId: Scheme {
    public static let validationRegex = Regex("\\A(?<=^|\\b|/)(?:arXiv:)?([a-z-]+(?:\\.[A-Z]{2})?/\\d{2}(?:0[1-9]|1[012])\\d{3}(?:v\\d+)?(?=$|\\b)|\\d{4}\\.\\d{4,5}(?:v\\d+)?(?=$|\\b))\\z", options: .IgnoreCase)
    public static let extractionRegex = Regex("\\b(?<=^|\\b|/)(?:arXiv:)?([a-z-]+(?:\\.[A-Z]{2})?/\\d{2}(?:0[1-9]|1[012])\\d{3}(?:v\\d+)?(?=$|\\b)|\\d{4}\\.\\d{4,5}(?:v\\d+)?(?=$|\\b))\\b", options: .IgnoreCase)
    
    public static func normalize(value: String) -> String {
        let regex = Regex("\\Aarxiv:", options: .IgnoreCase)
        return value.replacingFirstMatching(regex, with: "")
    }
}
