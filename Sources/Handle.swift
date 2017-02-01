import Regex

/**
Identifiers for the Handle registry of digital objects. http://handle.net/

Handles have a very loose definition, being formed as `<prefix>/<local_name`:

* **Prefix**

 */
public struct Handle: Scheme, Extractable {
    public static let identifierPattern = "[0-9.]+/\\S+"
}
