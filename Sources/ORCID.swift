import Regex
import Foundation

public struct ORCID {
    public let value: String
    
    public init(_ value: StaticString) {
        self.value = value.description
    }
    
    public init(string: String) throws {
        if ORCID.isValid(string) {
            self.value = string.uppercased()
        } else {
            throw IdentifierErrors.invalidIdentifier
        }
    }
    
    public static func isValid(_ text: String) -> Bool {
        let regex = Regex("\\A(?:\\d{4}-){3}\\d{3}[\\dX]\\z")
        guard regex.matches(text) else {
            return false
        }
        return String(text.characters.suffix(1)) == checkDigit(text)
    }
    
    private static func checkDigit(_ text: String) -> String {
        let baseDigits = String(text.characters.dropLast())
            .replacingOccurrences(of: "-", with: "")
        let total = baseDigits.characters.reduce(0) {
            ($0 + (Int(String($1)) ?? 0)) * 2
        }
        
        let remainder = total % 11
        let result = (12 - remainder) % 11
        if result == 10 {
            return "X"
        } else {
            return String(result)
        }
    }
}
