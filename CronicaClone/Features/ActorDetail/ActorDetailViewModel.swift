//
//  ActorDetailViewModel.swift
//  CronicaClone
//
//  Created by Hakan Or on 11.05.2024.
//

import Foundation

protocol ActorDetailViewModelDelegate: AnyObject {
}

protocol ActorDetailViewModelInterface {
    var actor: String? { get set }
}

final class ActorDetailViewModel: ActorDetailViewModelInterface {
    
    var coordinator: ActorDetailCoordinating?
    weak var delegate: ActorDetailViewModelDelegate?
    
    var actor: String?
    
    init(coordinator: ActorDetailCoordinating) {
        self.coordinator = coordinator
    }
    
    deinit {
        coordinator?.didFinish()
        print(#fileID + " deinit")
    }
}
