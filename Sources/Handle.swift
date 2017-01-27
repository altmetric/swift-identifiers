import Regex

/**
Identifiers for the Handle registry of digital objects. http://handle.net/

Handles have a very loose definition, being formed as `<prefix>/<local_name`:

* **Prefix**

 */
public struct Handle: Scheme {
    public static let extractionRegex = Regex("\\b[0-9.]+/\\S+\\b")
    public static let validationRegex = Regex("\\A[0-9.]+/\\S+\\z")
}
