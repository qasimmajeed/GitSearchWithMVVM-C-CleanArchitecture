//
//  GitSearchRequest.swift
//  
//
//  Created by Qasim Majeed on 27.02.22.
//

import Foundation

public struct GitSearchRequest: Encodable {
    // MARK: - Public Properties
    public var searchQuery: String
    public var page: Int
    public var pageSize: Int
    
    private enum CodingKeys: String, CodingKey {
        case searchQuery = "q"
        case page = "page"
        case pageSize = "per_page"
    }
    
    // MARK: - init
    public init(searchQuery: String, page: Int, pageSize: Int) {
        self.searchQuery = searchQuery
        self.page = page
        self.pageSize = pageSize
    }
}
