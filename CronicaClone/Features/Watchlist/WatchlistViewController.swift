//
//  WatchlistViewController.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import UIKit

class WatchlistViewController: UIViewController {
    // MARK: - Properties
    let viewModel: WatchlistViewModelInterface
    weak var coordinator: Coordinator?
    
    // MARK: - Subviews
    
    // MARK: - Life Cycle
    init(viewModel: WatchlistViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
    
    // MARK: - Functions
    
    // MARK: - Selectors
}
