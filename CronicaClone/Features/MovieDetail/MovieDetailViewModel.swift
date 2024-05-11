//
//  MovieDetailViewModel.swift
//  CronicaClone
//
//  Created by Hakan Or on 11.05.2024.
//

import Foundation

protocol MovieDetailViewModelDelegate: AnyObject {
}

protocol MovieDetailViewModelInterface {
    var movie: String? { get set }
}

final class MovieDetailViewModel: MovieDetailViewModelInterface {
 
    weak var coordinator: MovieDetailCoordinating?
    weak var delegate: MovieDetailViewModelDelegate?
    
    var movie: String?
    
    init(coordinator: MovieDetailCoordinating) {
        self.coordinator = coordinator
    }
}
