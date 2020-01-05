
import Foundation

/// Find the API Keys in the ApiKeys.plist file
func valueForAPIKey(named keyname: String) -> String {
    let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let value = plist?.object(forKey: keyname) as! String
    return value
}

/// Edamam API keys needed for the URL Request
struct ApiKeys {
    static let appID = valueForAPIKey(named: "app_id")
    static let appKey = valueForAPIKey(named: "app_key")
}
