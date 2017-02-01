import Regex


/**
 A representation of a **Digital Object Identifier**, or **DOI**.

 DOIs consist of a **prefix** and **suffix**, separated by a slash, `/`.

 * The _prefix_ consists of a **directory code**, `10`, and a numeric **registrant
 code**, separated by a full stop/period.

 The [DOI Handbook section on numbering][doi] allows for subdivision of the
 registrant code, with each subsection demarcated by an additional period.
 This structure is not supported by this object, and is not commonly seen or
 supported.

 * The _suffix_ is a character string of any length. There are no formal
 restrictions for acceptable characters within the suffix, which can make
 evaluation of the end of a DOI difficult.

 For example, the DOI `10.1038/issn.1476-4687` has:

 * a **prefix** of `10.1038`
 * a **registrant code** of `1038`
 * a **suffix** of `issn.1476-4687`

 DOIs are assumed to be case insensitive. Identifier strings are converted to
 lowercase upon instance creation.

 [doi]: http://www.doi.org/doi_handbook/2_Numbering.html#2.2.2
 */
public struct DOI: Scheme, Extractable {
    public static let identifierPattern = "10\\.(?:97[89]\\.\\d{2,8}/\\d{1,7}|\\d{4,9}/\\S+)"
    
    public static func normalize(value: String) -> String {
        return value.lowercased()
    }
}
