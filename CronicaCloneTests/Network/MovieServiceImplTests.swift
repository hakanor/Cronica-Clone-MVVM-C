//
//  MovieServiceTests.swift
//  CronicaCloneTests
//
//  Created by Hakan Or on 13.05.2024.
//

import XCTest
@testable import CronicaClone

final class MovieServiceImplTests: XCTestCase {
    
    var sut: MovieServiceImpl!
    var client: MockHTTPClient!

    override func setUp() {
        super.setUp()
        client = MockHTTPClient()
        sut = MovieServiceImpl(client: client)
    }
    
    override func tearDown() {
        sut = nil
        client = nil
        super.tearDown()
    }
    
    func test_fetchMovies_shouldSuccess() async throws {
        // Given
        client.successResult = (MockBuilder.movieData, HTTPURLResponse())
        let expectation = expectation(description: "Wait for request")
        
        // When
        do {
            let movies = try await sut.fetchMovies(path: .discoverMovies)
            // Then
            XCTAssertNotNil(movies)
            XCTAssertTrue(client.performRequestCalled)
            XCTAssertEqual(client.performRequestCallCount, 1)
            expectation.fulfill()
        } catch {
            XCTFail()
        }
        await fulfillment(of: [expectation])
    }
    
    func test_fetchMovies_shouldFail() async throws {
        // Given
        client.errorResult = HTTPError.apiError
        let expectation = expectation(description: "Wait for request")
        
        // When
        do {
            let movies = try await sut.fetchMovies(path: .discoverMovies)
        } catch {
            // Then
            XCTAssertNotNil(error)
            XCTAssertEqual(error as? HTTPError, .apiError)
            XCTAssertTrue(client.performRequestCalled)
            XCTAssertEqual(client.performRequestCallCount, 1)
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
    func test_fetchMovieDetails_shouldSuccess() async throws {
        // Given
        client.successResult = (MockBuilder.movieData, HTTPURLResponse())
        let expectation = expectation(description: "Wait for request")
        
        // When
        do {
            let movies = try await sut.fetchMovieDetails(id: 1)
            // Then
            XCTAssertNotNil(movies)
            XCTAssertTrue(client.performRequestCalled)
            XCTAssertEqual(client.performRequestCallCount, 1)
            expectation.fulfill()
        } catch {
            XCTFail()
        }
        await fulfillment(of: [expectation])
    }
    
    func test_fetchMovieDetails_shouldFail() async throws {
        // Given
        client.errorResult = HTTPError.apiError
        let expectation = expectation(description: "Wait for request")
        
        // When
        do {
            let movies = try await sut.fetchMovieDetails(id: 1)
        } catch {
            // Then
            XCTAssertNotNil(error)
            XCTAssertEqual(error as? HTTPError, .apiError)
            XCTAssertTrue(client.performRequestCalled)
            XCTAssertEqual(client.performRequestCallCount, 1)
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
    func test_fetchCredits_shouldSuccess() async throws {
        // Given
        client.successResult = (MockBuilder.creditsData, HTTPURLResponse())
        let expectation = expectation(description: "Wait for request")
        
        // When
        do {
            let credits = try await sut.fetchCredits(id: 1)
            // Then
            XCTAssertNotNil(credits)
            XCTAssertTrue(client.performRequestCalled)
            XCTAssertEqual(client.performRequestCallCount, 1)
            expectation.fulfill()
        } catch {
            XCTFail()
        }
        await fulfillment(of: [expectation])
    }
    
    func test_fetchCredits_shouldFail() async throws {
        // Given
        client.errorResult = HTTPError.apiError
        let expectation = expectation(description: "Wait for request")
        
        // When
        do {
            let credits = try await sut.fetchCredits(id: 1)
        } catch {
            // Then
            XCTAssertNotNil(error)
            XCTAssertEqual(error as? HTTPError, .apiError)
            XCTAssertTrue(client.performRequestCalled)
            XCTAssertEqual(client.performRequestCallCount, 1)
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 5.0)
    }
}
