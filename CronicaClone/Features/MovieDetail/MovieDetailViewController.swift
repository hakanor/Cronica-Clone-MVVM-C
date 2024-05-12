//
//  MovieDetailViewController.swift
//  CronicaClone
//
//  Created by Hakan Or on 11.05.2024.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    // MARK: - Properties
    let viewModel: MovieDetailViewModelInterface
    
    // MARK: - Subviews
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Life Cycle
    init(viewModel: MovieDetailViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        label.text = viewModel.movie ?? "error"
    }
    
    // MARK: - Methods
    private func configureUI() {
        view.backgroundColor = .systemPink
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    // MARK: - Selectors
}
