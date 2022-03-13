//
//  RepoBranchRequest.swift
//  
//
//  Created by Qasim Majeed on 27.02.22.
//

import Foundation

public struct RepoBranchRequest {
    // MARK: - Public Properties
    public var repoName: String
    public var param: RepoBranchRequestParam
    
    // MARK: - init
    public init(repoName: String, param: RepoBranchRequestParam) {
        self.repoName = repoName
        self.param = param
    }
}

public struct RepoBranchRequestParam: Encodable {
    // MARK: - Public Properties
    public var page: Int
    public var pageSize: Int
    
    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case pageSize = "per_page"
    }
    
    // MARK: - init
    public init(page: Int, pageSize: Int) {
        self.page = page
        self.pageSize = pageSize
    }
}
