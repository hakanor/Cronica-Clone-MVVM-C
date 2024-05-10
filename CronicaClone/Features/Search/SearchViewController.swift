//
//  SearchViewController.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK: - Properties
    let viewModel: SearchViewModelInterface
    weak var coordinator: Coordinator?
    
    // MARK: - Subviews
    
    // MARK: - Life Cycle
    init(viewModel: SearchViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    // MARK: - Functions
    
    // MARK: - Selectors
}
