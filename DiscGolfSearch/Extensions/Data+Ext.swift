//
//  Data+Ext.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 9/14/23.
//

import Foundation
import OSLog

extension Data {
    
    func printJson() {
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: [])
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            guard let jsonString = String(data: data, encoding: .utf8) else {
                os_log("Data is invalid: %@", log: OSLog.default, type: .error, "Invalid data")
                return
            }
            os_log("JSONString: %@", log: OSLog.default, type: .info, jsonString)
        } catch {
            os_log("Error: %@", log: OSLog.default, type: .error, error.localizedDescription)
        }
    }
}
