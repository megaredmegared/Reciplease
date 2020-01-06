
import Foundation

extension Collection where Element == String {
    /// Format array of string in one string with "," and a end "."
    func formatListNames() -> String {
        return self
            .joined(separator: ",")
            .appending(".")
    }
}
