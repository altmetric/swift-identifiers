import Regex
import Foundation

internal struct ISBN13: Scheme {
    static var extractionRegex = Regex("\\b(?=[0-9]{13}|(?=(?:[0-9]+[- ]){4})[- 0-9]{17})97[89][- ]?[0-9]{1,5}[- ]?[0-9]+[- ]?[0-9]+[- ]?[0-9]\\b", options: .IgnoreCase)
    static var validationRegex = Regex("\\A(?=[0-9]{13}|(?=(?:[0-9]+[- ]){4})[- 0-9]{17})97[89][- ]?[0-9]{1,5}[- ]?[0-9]+[- ]?[0-9]+[- ]?[0-9]\\z", options: .IgnoreCase)
    
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
}
