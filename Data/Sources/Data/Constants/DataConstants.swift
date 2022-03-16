//
//  DataConstants.swift
//  
//
//  Created by Qasim Majeed on 27.02.22.
//

import Foundation

public struct DataConstants {
    /// Defines all the base api urls
    public struct APIUrls {
        public static let baseURL  = Bundle.main.infoForKey("Api URL") ?? ""
    }
    
    /// Define all the paths for the urls
    public struct APIPaths {
        public static let searchRepositories  = "/search/repositories"
        public static let branches  = "/repos/%@/branches"
    }
    
    /// Define all the constant data related to api
    public struct APIData {
        public static let apiToken =  "token " + "apend the github token here"
    }
}
