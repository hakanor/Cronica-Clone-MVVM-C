//
//  URLBuilderTests.swift
//  CronicaCloneTests
//
//  Created by Hakan Or on 13.05.2024.
//

import XCTest
@testable import CronicaClone

final class URLBuilderTests: XCTestCase {
    
    func test_buildURL_shouldReturnValidURL() {
        // Given
        let endpoint: MovieListEndpoint = .discoverMovies
        let page = 1
        let expectedString = "https://api.themoviedb.org/3/discover/movie?api_key=\(Key.API_KEY)&include_adult=false&include_video=false&page=1"
        
        // When
        let url = URLBuilder.build(endpoint: endpoint, page: page)
        
        // Then
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.scheme, "https")
        XCTAssertEqual(url?.host, "api.themoviedb.org")
        XCTAssertEqual(url?.path, "/3/discover/movie")
        XCTAssertEqual(url?.absoluteString, expectedString)
    }
    
    func test_buildURL_withId_shouldReturnValidURL() {
        // Given
        let endpoint: MovieListEndpoint = .movie
        let id = 1
        let expectedString = "https://api.themoviedb.org/3/movie/\(id)?api_key=\(Key.API_KEY)&include_adult=false&include_video=false"
        
        // When
        let url = URLBuilder.build(endpoint: endpoint, id: 1)
        
        // Then
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.scheme, "https")
        XCTAssertEqual(url?.host, "api.themoviedb.org")
        XCTAssertEqual(url?.path, "/3/movie/1")
        XCTAssertEqual(url?.absoluteString, expectedString)
    }
    
    func test_buildURL_withStringAfterID_shouldReturnValidURL() {
        // Given
        let endpoint: MovieListEndpoint = .movie
        let id = 1
        let stringAfterId = "credits"
        let expectedString = "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(Key.API_KEY)&include_adult=false&include_video=false"
        
        // When
        let url = URLBuilder.build(endpoint: endpoint, id: 1, stringAfterId: stringAfterId)
        
        // Then
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.scheme, "https")
        XCTAssertEqual(url?.host, "api.themoviedb.org")
        XCTAssertEqual(url?.path, "/3/movie/1/credits")
        XCTAssertEqual(url?.absoluteString, expectedString)
    }
    
    func test_buildImageUrl_shouldReturnValidURL() {
        // Given
        let path = "/example_image_path.jpg"
        let expectedString = "https://image.tmdb.org/t/p/w500/example_image_path.jpg"
        
        // When
        let imageUrl = URLBuilder.buildImageUrl(path: path)
        
        // Then
        XCTAssertNotNil(imageUrl)
        XCTAssertEqual(imageUrl?.scheme, "https")
        XCTAssertEqual(imageUrl?.host, "image.tmdb.org")
        XCTAssertEqual(imageUrl?.path, "/t/p/w500\(path)")
        XCTAssertEqual(imageUrl?.absoluteString, expectedString)
    }
    
    func test_buildImageUrl_shouldReturnNilWithotPath() {

        // When
        let imageUrl = URLBuilder.buildImageUrl(path: nil)
        
        // Then
        XCTAssertNil(imageUrl)
    }
}
