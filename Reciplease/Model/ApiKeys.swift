
import Foundation

func valueForAPIKey(named keyname: String) -> String {
    let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let value = plist?.object(forKey: keyname) as! String
    return value
}

struct ApiKeys {
    static let appID = valueForAPIKey(named: "app_id")
    static let appKey = valueForAPIKey(named: "app_key")
}
