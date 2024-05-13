//
//  MockHTTPClient.swift
//  CronicaCloneTests
//
//  Created by Hakan Or on 13.05.2024.
//

import Foundation
@testable import CronicaClone

final class MockHTTPClient: HTTPClient {
    
    var performRequestCallCount = 0
    var performRequestCalled: Bool {
        performRequestCallCount > 0
    }

    var successResult: (data: Data, response: HTTPURLResponse)?
    var errorResult: HTTPError?
    
    func performRequest(_ request: URLRequest) async throws -> (data: Data, response: HTTPURLResponse) {
        performRequestCallCount += 1
        if let successResult {
            return successResult
        } else if let errorResult {
            throw errorResult
        } else {
            throw HTTPError.apiError
        }
    }
}
