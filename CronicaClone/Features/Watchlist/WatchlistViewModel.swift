//
//  WatchlistViewModel.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import Foundation

protocol WatchlistViewModelDelegate: AnyObject {
}

protocol WatchlistViewModelInterface {
    
}

final class WatchlistViewModel: WatchlistViewModelInterface {
    
    weak var coordinator: WatchlistCoordinating?
    weak var delegate: WatchlistViewModelDelegate?
    
    init(coordinator: WatchlistCoordinating) {
        self.coordinator = coordinator
    }
}
