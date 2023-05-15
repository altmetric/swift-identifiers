# THIS PROJECT IS DEPRECATED

swift-identifiers is not maintained anymore.

# Swift Identifiers

A work-in-progress Swift library for handling and extracting scholarly identifiers from text.

**Current version:** Unreleased
**Supported Swift versions:** 3.0x

# Usage

```swift
import Identifiers

// Extracting from a larger text element
let dois = DOI.extract("I love 10.1234/foobar and 10.1234/bazquux")

// Instantiating with a literal string
// (failures are assumed to be developer error)
let doi = DOI("10.1234/foobar")

// Instantiating from a variable
do {
  let doi = try DOI("10.1234/bazquux")
} catch(let error) {
  // throws an IdentifierError.invalidIdentifier
}
```

# Versions in other languages

We also maintain a [version of this library for Ruby](https://github.com/altmetric/identifiers) and [for PHP](https://github.com/altmetric/php-identifiers).

A further version [for Rust](https://github.com/altmetric/rust-identifiers) is currently in development.

## License

Copyright © 2017 Altmetric LLP.

Distributed under the MIT License.
