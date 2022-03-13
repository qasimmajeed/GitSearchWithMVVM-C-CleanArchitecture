//
//  FakeData.swift
//  Github SearchTests
//
//  Created by Qasim Majeed on 27.02.22.
//

import Domain

struct FakeGitSearchData {
    static let fakeData = SearchResponse(items:
                                            [Repository(id: 1,
                                                        name: "swift",
                                                        fullName: "apple/swift",
                                                        likeCount: 2,
                                                        forkCount: 2,
                                                        branches: [Branch(name: "master")]
                                                       )])
}
