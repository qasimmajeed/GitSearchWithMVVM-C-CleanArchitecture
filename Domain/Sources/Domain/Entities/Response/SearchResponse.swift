//
//  SearchResponse.swift
//  
//
//  Created by Qasim Majeed on 27.02.22.
//

import Foundation

public struct SearchResponse: Decodable {
    public var items: [Repository] = [Repository]()
    
    // MARK: - init
    public init(items: [Repository]) {
        self.items = items
    }
}
