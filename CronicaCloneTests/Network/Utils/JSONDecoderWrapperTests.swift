//
//  JSONDecoderWrapperTests.swift
//  CronicaCloneTests
//
//  Created by Hakan Or on 13.05.2024.
//

import XCTest
@testable import CronicaClone

final class JSONDecoderWrapperTests: XCTestCase {

    var sut: JSONDecoderWrapper!
    
    override func setUp() {
        super.setUp()
        sut = JSONDecoderWrapper()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_decode_shouldSuccess() {
        // Given
        let movieData = MockBuilder.movieData // data
        let movieResponse = MockBuilder.movieResponse // obj
        
        // When
        do {
            let decodedData: MovieResponse = try sut.decode(MovieResponse.self, from: movieData)
            
            // Then
            XCTAssertNotNil(decodedData)
            XCTAssertEqual(movieResponse.results.count, decodedData.results.count)
            
            for (index, movie) in movieResponse.results.enumerated() {
                let decodedMovie = decodedData.results[index]
                
                XCTAssertEqual(movie.id, decodedMovie.id)
                XCTAssertEqual(movie.title, decodedMovie.title)
            }
        } catch {
            // Catch block should not catch error
            XCTFail()
        }
    }
    
    func test_decode_shouldFailWithNoData() {
        // Given
        let movieData = Data()
        let movieResponse = MockBuilder.movieResponse
        
        // When
        do {
            let decodedData: MovieResponse = try sut.decode(MovieResponse.self, from: movieData)
            XCTFail()
        } catch {
            // Catch block should catch HTTPError.seralization
            XCTAssertEqual(error as? HTTPError, HTTPError.serializationError)
        }
    }
    
    func test_decode_shouldFailWithInvalidType() {
        // Given
        let movieData = MockBuilder.movieData
        let movieResponse = MockBuilder.movieResponse
        
        struct MockModel: Decodable {
            let mock: String
        }
        
        // When
        do {
            let decodedData: MockModel = try sut.decode(MockModel.self, from: movieData)
            XCTFail()
        } catch {
            // Catch block should catch HTTPError.seralization
            XCTAssertEqual(error as? HTTPError, HTTPError.serializationError)
        }
    }
    
}
