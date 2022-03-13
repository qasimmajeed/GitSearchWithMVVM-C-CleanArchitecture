//
//  Networking.swift
//  
//
//  Created by Qasim Majeed on 27.02.22.
//

import Foundation
import Combine

/// This protocol the use to implement for remote networking api
public protocol Networking {
    
    /// Create a request and perform over the provided network api
    /// - Parameter request: APIRequestBuilder that have all the information for the call api request
    /// - Returns  AnyPublisher: Publisher which will be having the T generic type for response as decodable  or error in case of
    func request<T: Decodable>(request: APIRequestBuilder) -> AnyPublisher<T, NetworkError>
}

public final class Network: Networking {
    
    // MARK: - init
    public init() { }
    
    // MARK: - Networking Implementation
    public func request<T: Decodable>(request: APIRequestBuilder) -> AnyPublisher<T, NetworkError> {
        guard let request = request.makeRequest() else {
            return Fail(error: NetworkError.invalidRequest).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { NetworkError(rawValue: $0.code.rawValue) ?? NetworkError.unknown }
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { $0 as? NetworkError ?? NetworkError.dataDecodingFail }
            .eraseToAnyPublisher()
    }
}
