import Regex
import Foundation

internal struct ISBN10: Scheme {
    static var extractionRegex = Regex("\\b(?=[0-9X]{10}|(?=(?:[0-9]+[- ]){3})[- 0-9X]{13})\\d{1,5}[- ]?\\d+[- ]?\\d+[- ]?[0-9X]\\b", options: .IgnoreCase)
    static var validationRegex = Regex(
        "\\A(?=[0-9X]{10}|(?=(?:\\d+[- ]){3})[- 0-9X]{13})\\d{1,5}[- ]?\\d+[- ]?\\d+[- ]?[0-9X]\\z", options: .IgnoreCase)
    
    public static func isValid(value: String) -> Bool {
        guard validationRegex.matches(value) else {
            return false
        }
        
        let result = normalize(value: value).characters.enumerated().reduce(0) { total, character in
            return total + (Int(String(character.element)) ?? 10) * (character.offset + 1)
        }
        
        return (result % 11) == 0
    }
    
    public static func normalize(value: String) -> String {
        return value.replacingAllMatching("[ -]", with: "").uppercased()
    }
}
