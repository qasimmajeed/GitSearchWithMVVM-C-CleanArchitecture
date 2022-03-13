//
//  Branch.swift
//  
//
//  Created by Qasim Majeed on 27.02.22.
//

import Foundation

public struct Branch: Decodable {
    // MARK: - Public Properties
    public let name: String
    
    // MARK: - init
    public init(name: String) {
        self.name = name
    }
}
