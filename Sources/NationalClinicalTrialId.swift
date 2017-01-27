import Regex

public struct NationalClinicalTrialId: Scheme {
    public static let validationRegex = Regex("\\ANCT\\d+\\z", options: .IgnoreCase)
    public static let extractionRegex = Regex("\\bNCT\\d+\\b", options: .IgnoreCase)
    
    public static func normalize(value: String) -> String {
        return value.uppercased()
    }
}
