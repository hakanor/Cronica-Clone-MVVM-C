//
//  DiscoverViewModel.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import Foundation

protocol DiscoverViewModelDelegate: AnyObject {
}

protocol DiscoverViewModelInterface {
    
}

final class DiscoverViewModel: DiscoverViewModelInterface {

    var coordinator: DiscoverCoordinating?
    weak var delegate: DiscoverViewModelDelegate?

    init(coordinator: DiscoverCoordinating) {
        self.coordinator = coordinator
    }
}
