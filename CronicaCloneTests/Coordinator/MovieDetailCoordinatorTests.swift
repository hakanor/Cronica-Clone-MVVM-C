//
//  MovieDetailCoordinatorTests.swift
//  CronicaCloneTests
//
//  Created by Hakan Or on 12.05.2024.
//

import XCTest
@testable import CronicaClone

class MovieDetailCoordinatorTests: XCTestCase {
    
    var sut: MovieDetailCoordinator!
    var navigationController: UINavigationController!
    
    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
        let movie = "The Matrix"
        sut = MovieDetailCoordinator(navigationController, movie: movie)
    }
    
    override func tearDown() {
        navigationController = nil
        sut = nil
        super.tearDown()
    }
    
    func test_didFinish_shouldRemoveChild() {
        // Given
        let parentCoordinator = HomeCoordinator(UINavigationController())
        parentCoordinator.childCoordinators.append(sut)
        sut.parentCoordinator = parentCoordinator
        
        // When
        sut.didFinish()
        
        // Then
        // Parent should not have sut in childCoordinators
        XCTAssertFalse(parentCoordinator.childCoordinators.contains { $0 === sut })
    }
}
