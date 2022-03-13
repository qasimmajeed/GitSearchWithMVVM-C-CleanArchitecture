//
//  Encodable+Extension.swift
//  
//
//  Created by Qasim Majeed on 27.02.22.
//

import Foundation

extension Encodable {
    var toDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return nil }
        return json
    }
}
