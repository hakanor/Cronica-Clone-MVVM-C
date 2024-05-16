//
//  SearchViewModel.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
}

protocol SearchViewModelInterface {
    
}

final class SearchViewModel: SearchViewModelInterface {
    
    var coordinator: SearchCoordinating?
    weak var delegate: SearchViewModelDelegate?
    
    init(coordinator: SearchCoordinating) {
        self.coordinator = coordinator
    }
}
