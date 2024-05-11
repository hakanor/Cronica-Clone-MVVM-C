//
//  HomeViewController.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: - Properties
    let viewModel: HomeViewModelInterface
    
    // MARK: - Subviews
    
    // MARK: - Life Cycle
    init(viewModel: HomeViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
    
    // MARK: - Functions
    
    // MARK: - Selectors
}
