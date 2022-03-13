//
//  APIRequestBuilder.swift
//  
//
//  Created by Qasim Majeed on 27.02.22.
//

import Foundation

/// Define to create the request for the network
public struct APIRequestBuilder {
    // MARK: - Private Properties
    private let scheme: String
    private let host: String
    private let path: String
    private let httpMethods: HttpMethods
    private let parameters: Encodable?
    private var headers: [String: String]?
    
    // MARK: - Init
    public init(scheme: String = "https", host: String, path: String, httpMethods: HttpMethods = .Get, parameters: Encodable? = nil, headers: [String: String]? = nil) {
        self.scheme = scheme
        self.host = host
        self.path = path
        self.httpMethods = httpMethods
        self.parameters = parameters
        self.headers = headers
    }
    
    // MARK: - Public Methods
    
    /// Make the request with the provided information
    /// - Returns  URLRequest: Convert the all provided information to the URLRequest
    public func makeRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        
        components.queryItems = self.parameters?.toDictionary?.map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }
        
        guard var request = components.url.map({ URLRequest(url: $0) }) else {
            return nil
        }
        _ = self.headers?.map { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}
