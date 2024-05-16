//
//  HTTPClientImplTests.swift
//  CronicaCloneTests
//
//  Created by Hakan Or on 12.05.2024.
//

import XCTest
@testable import CronicaClone

class HTTPClientImplTests: XCTestCase {

    var sut: HTTPClient!
    var urlSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        urlSession = MockURLSession()
        sut = HTTPClientImpl(session: urlSession)
    }
    
    override func tearDown() {
        sut = nil
        urlSession = nil
        super.tearDown()
    }
    
    func test_request_shouldSuccess() async throws {
        // Given
        urlSession.data = MockBuilder.movieData
        urlSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        
        let url = URLBuilder.build(endpoint: MovieListEndpoint.discoverMovies, page: 1)
        let urlRequest = URLRequest(url: url!)
        let expectation = expectation(description: "Wait for request")
        
        // When
        do {
            let movies = try await sut.performRequest(urlRequest)
            XCTAssertEqual(movies.data, MockBuilder.movieData)
            expectation.fulfill()
        } catch {
            XCTFail()
        }
        // Then
        await fulfillment(of: [expectation])
    }
    
    func test_request_shouldFailWithNilData() async throws {
        // Given
        urlSession.data = nil
        urlSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        
        let url = URLBuilder.build(endpoint: MovieListEndpoint.discoverMovies, page: 1)
        let urlRequest = URLRequest(url: url!)
        let expectation = expectation(description: "Wait for request")
        
        // When
        do {
            _ = try await sut.performRequest(urlRequest)
            XCTFail("The Request should fail")
        } catch {
            // Error should equal HTTPError.noData
            XCTAssertEqual((error as? HTTPError), .noData)
        }
        // Then
        expectation.fulfill()
        await fulfillment(of: [expectation])
    }
    
    func test_request_shouldFailWithInvalidResponse() async throws {
        // Given
        urlSession.data = Data()
        urlSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 400, httpVersion: nil, headerFields: nil)!
        
        let url = URLBuilder.build(endpoint: MovieListEndpoint.discoverMovies, page: 1)
        let urlRequest = URLRequest(url: url!)
        let expectation = expectation(description: "Wait for request")
        
        // When
        do {
            _ = try await sut.performRequest(urlRequest)
            XCTFail("The Request should fail with status code 400")
        } catch {
            // Error should equal HTTPError.invalidResponse
            XCTAssertEqual((error as? HTTPError), .invalidResponse)
        }
        // Then
        expectation.fulfill()
        await fulfillment(of: [expectation])
    }
}
