import Regex

/**
 A representation of an **ArXiv ID**.

The article identifier scheme used by arXiv has two distinct schemes, after 
being changed in mid-2007. These two schemes are referred to thoroughout
documentation as _pre-2007_ and _post-2007_ arXiv IDs.

**Post-2007** identifiers are structured as `arXiv:<year><month>.<number>`,
or as a versioned form `arXiv:<year><month>.<number>v<version>`, e.g., 
`arXiv:1501.00001` or `arXiv:0706.0001v2`:

* **Year** is the two-digit year
* **Month** is the two-digit month
* **Number** is a four or five digit number
* **Version** is one or more digits denoting a specific version of a paper, 
  separated from the number component by a literal letter `v`

**Pre-2007** identifiers are in the format `<archive>.<subject>/<year><month><number>`, 
e.g., `math.GT/0309136`:

* The **archive** is a top-level subject group
* The **subject** is a two-letter subcategory of the archive group
* **Year** is the two-digit year of publication
* **Month** is the two-digit month of publication
* **Number** is a three-digit sequential identifier

The post-2007 format officially includes an `arXiv:` prefix. This library does 
not require this; if found ahead of any (pre or post-2007) arXiv ID, the `arxiv:` 
prefix is not stored.

For more details, see [the ArXiv ID help page on identifier formats][arxiv]

[arxiv]: https://arxiv.org/help/arxiv_identifier

*/
public struct ArxivId: MultipleScheme {
    public static var schemes: [Scheme.Type] = [ArxivIdPre2007.self, ArxivIdPost2007.self]
    
    public static func normalize(value: String) -> String {
        let regex = Regex("\\Aarxiv:", options: .IgnoreCase)
        return value.replacingFirstMatching(regex, with: "")
    }
}
