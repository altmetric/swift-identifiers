import Regex

public struct NationalClinicalTrialId: Scheme, Extractable {
    public static let identifierPattern = "NCT\\d+"
    
    public static func normalize(value: String) -> String {
        return value.uppercased()
    }
}
