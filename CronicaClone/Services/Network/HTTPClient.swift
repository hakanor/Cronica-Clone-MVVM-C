//
//  HTTPClient.swift
//  CronicaClone
//
//  Created by Hakan Or on 12.05.2024.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    
}

protocol HTTPClient: AnyObject {
    func performRequest(_ request: URLRequest) async throws -> (data: Data, response: HTTPURLResponse)
}

final class HTTPClientImpl: HTTPClient {
    
    var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    public func performRequest(_ request: URLRequest) async throws -> (data: Data, response: HTTPURLResponse) {
        
        var result: (data: Data, response: HTTPURLResponse)
        
        do {
            let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw HTTPError.invalidResponse
            }
            result = (data, httpResponse)
        } catch {
            throw HTTPError.noData
        }
        
        guard (200..<300).contains(result.response.statusCode) else {
            throw HTTPError.invalidResponse
        }
        
        return result
    }
}
