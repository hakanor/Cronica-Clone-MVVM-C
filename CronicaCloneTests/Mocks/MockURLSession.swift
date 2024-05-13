//
//  MockURLSession.swift
//  CronicaCloneTests
//
//  Created by Hakan Or on 12.05.2024.
//

import Foundation
@testable import CronicaClone

final class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        guard let data = data else {
            throw HTTPError.noData
        }
        
        guard let response = response else {
            throw HTTPError.invalidResponse
        }
        return (data, response)
    }
}
