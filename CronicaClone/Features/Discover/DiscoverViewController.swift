//
//  DiscoverViewController.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import UIKit

class DiscoverViewController: UIViewController {
    // MARK: - Properties
    let viewModel: DiscoverViewModelInterface
    weak var coordinator: Coordinator?
    
    // MARK: - Subviews
    
    // MARK: - Life Cycle
    init(viewModel: DiscoverViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
    }
    
    // MARK: - Functions
    
    // MARK: - Selectors
}
