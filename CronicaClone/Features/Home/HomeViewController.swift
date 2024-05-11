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
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Button", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
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
        configureUI()
    }
    
    // MARK: - Functions
    private func configureUI() {
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    // MARK: - Selectors
    @objc func buttonTapped(_ sender: UIButton) {
        viewModel.showMovieDetail(with: "TestString")
    }
}
