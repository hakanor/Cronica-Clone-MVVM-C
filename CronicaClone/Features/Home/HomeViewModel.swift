//
//  HomeViewModel.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
}

protocol HomeViewModelInterface {
    
}

final class HomeViewModel: HomeViewModelInterface {
    
    weak var coordinator: HomeCoordinating?
    weak var delegate: HomeViewModelDelegate?
    
    init(coordinator: HomeCoordinating) {
        self.coordinator = coordinator
        test()
    }
    
    func test() {

    }
    
}
