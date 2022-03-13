//
//  Bundle+Extension.swift
//  
//
//  Created by Qasim Majeed on 27.02.22.
//

import Foundation

extension Bundle {
    /// Use to get the value from the .plist file by provided `key`.
    /// - Parameter key: Specify the key name.
    /// - Returns
    ///    - get the value from the provided key
    func infoForKey(_ key: String) -> String? {
        return (infoDictionary?[key] as? String)?
            .replacingOccurrences(of: "\\", with: "")
    }
}
