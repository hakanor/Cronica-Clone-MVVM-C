//
//  ActorDetailViewController.swift
//  CronicaClone
//
//  Created by Hakan Or on 11.05.2024.
//

import UIKit

final class ActorDetailViewController: UIViewController {
    // MARK: - Properties
    
    let viewModel: ActorDetailViewModelInterface
    // MARK: - Subviews
    
    // MARK: - Life Cycle
    init(viewModel: ActorDetailViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    // MARK: - Selectors
}
