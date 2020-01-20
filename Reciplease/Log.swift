
import Foundation

/// print only for Debug
func logPrint(_ object: Any,
              file: String = #file,
              function: String = #function,
              line: Int = #line) {
    
    var sign = "🖨 "
    if let _ = object as? Error {
        sign = "⚠️ Debug Error: "
    }
    
    #if DEBUG
    print("""
        
        file: \(file)
        function: \(function), line: \(line)
        \(sign)\(object)
        
        """)
    #endif
}
