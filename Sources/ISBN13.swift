import Regex
import Foundation

internal struct ISBN13: Scheme, Extractable {
    static var identifierPattern = "(?=[0-9]{13}|(?=(?:[0-9]+[- ]){4})[- 0-9]{17})97[89][- ]?[0-9]{1,5}[- ]?[0-9]+[- ]?[0-9]+[- ]?[0-9]"
    
    public static func isValid(value: String) -> Bool {
        guard validationRegex.matches(value) else {
            return false
        }
        
        let result = normalize(value: value).characters.enumerated().reduce(0) { total, character in
            return total + (Int(String(character.element)) ?? 0) * (character.offset % 2 == 0 ? 1 : 3)
        }
        return (result % 10) == 0
    }
    
    public static func normalize(value: String) -> String {
        return value.replacingAllMatching("[ -]", with: "")
    }
    
    internal static func isbn13(from isbn10: String) -> String {
        let chopped = String(ISBN10.normalize(value: isbn10).characters.dropLast())
        let result = normalize(value: "978\(chopped)").characters.enumerated().reduce(0) { total, character in
            return total + (Int(String(character.element)) ?? 0) * (character.offset % 2 == 0 ? 1 : 3)
        }
        let checkValue = 10 - (result % 10)
        let checkDigit = checkValue == 10 ? "X" : String(checkValue)
        
        return "978\(chopped)\(checkDigit)"
    }
}

