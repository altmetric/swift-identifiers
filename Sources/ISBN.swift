public struct ISBN: MultipleScheme {
    public static var schemes: [Scheme.Type] = [ISBN10.self, ISBN13.self]

    public static func normalize(value: String) -> String {
        // TODO: an ISBN10 scheme should be presented as an ISBN13
        return value
    }
}
