//
//  HomeCoordinatorTests.swift
//  CronicaCloneTests
//
//  Created by Hakan Or on 12.05.2024.
//

import XCTest

@testable import CronicaClone
class HomeCoordinatorTests: XCTestCase {
    
    var sut: HomeCoordinator!
    var navigationController: UINavigationController!
    
    override func setUp() {
        navigationController = UINavigationController()
        sut = HomeCoordinator(navigationController)
    }
    
    override func tearDown() {
        navigationController = nil
        sut = nil
    }
    
    func test_start() {
        // When
        sut.start()
        
        // Then
        // HomeViewController should be added to UINavigationcontroller.
        XCTAssertTrue(navigationController.viewControllers.last is HomeViewController)
        
        let lastController = navigationController.viewControllers.last as! HomeViewController
        XCTAssertTrue(lastController.viewModel is HomeViewModel)
    }

    func test_showMovieDetailView() {
        // Given
        let movie = "The Matrix"
        
        // When
        sut.showMovieDetailView(with: movie)
        
        // Then
        // MovieDetailViewController should be added to UINavigationcontroller.
        XCTAssertTrue(navigationController.viewControllers.last is MovieDetailViewController)
        // MovieDetailViewController's movie should match.
        let lastController = navigationController.viewControllers.last as! MovieDetailViewController
        XCTAssertEqual(lastController.viewModel.movie, movie)
    }
}
