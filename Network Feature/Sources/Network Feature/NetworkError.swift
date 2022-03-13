//
//  NetworkError.swift
//  
//
//  Created by Qasim Majeed on 27.02.22.
//

import Foundation

public enum NetworkError: Int, Error {
    ///  Error when no internet
    case noInternet = -1009
    
    /// Error When no data connection
    case noDataConnection = -1020
    
    /// Error while the request is having some invalid information like url is nil
    case invalidRequest
    
    /// Error when the decoding data is failed
    case dataDecodingFail
    
    /// Something unknown
    case unknown
}

/// NetworkError Extension for localized description
extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noInternet, .noDataConnection:
            return "Can't connect to internet"
        case .invalidRequest:
            return "Bad input request"
        case .dataDecodingFail:
            return "Data decoding failed"
        case .unknown:
            return "Something went wrong!"
        }
    }
}
