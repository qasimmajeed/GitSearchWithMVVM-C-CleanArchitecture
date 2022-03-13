//
//  Repository.swift
//  
//
//  Created by Qasim Majeed on 27.02.22.
//

import Foundation

public struct Repository: Decodable {
    // MARK: - Public Properties
    public let id: Int
    public let name: String
    public let fullName: String
    public let likeCount: Int
    public let forkCount: Int
    public var branches: [Branch] = [Branch]()
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case likeCount = "stargazers_count"
        case forkCount = "forks_count"
    }
    
    // MARK: - init
    public init(id: Int, name: String, fullName: String, likeCount: Int, forkCount: Int, branches: [Branch]) {
        self.id = id
        self.name = name
        self.fullName = fullName
        self.likeCount = likeCount
        self.forkCount = forkCount
        self.branches = branches
    }
}
