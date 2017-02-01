import Regex
import Foundation

public struct ORCID: Scheme, Extractable {
    public static let identifierPattern = "(?:\\d{4}-){3}\\d{3}[\\dX]"
    
    public static func isValid(value: String) -> Bool {
        guard validationRegex.matches(value) else {
            return false
        }
        return String(value.characters.suffix(1)) == checkDigit(value)
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
