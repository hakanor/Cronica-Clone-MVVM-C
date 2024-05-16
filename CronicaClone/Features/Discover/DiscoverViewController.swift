//
//  DiscoverViewController.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import UIKit

class DiscoverViewController: UIViewController {
    // MARK: - Properties
    var viewModel: DiscoverViewModelInterface
    
    var dataSource: MoviesDiffableDataSource!
    var snapshot: NSDiffableDataSourceSnapshot<Section, MovieResponse.Movie>!
    
    // MARK: - Subviews
    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: CustomCompositionalLayouts.gridSection())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Life Cycle
    init(viewModel: DiscoverViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupCollectionView()
        setupDataSource()
        Task {
            await viewModel.fetchMovies()
        }
    }
    
    // MARK: - Functions
    private func configureUI() {
        title = "Discover"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame = view.frame
        collectionView.delegate = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
    }
    
    private func setupDataSource() {
        dataSource = MoviesDiffableDataSource(collectionView: collectionView)
        // Apply initial snapshot
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, MovieResponse.Movie>()
        initialSnapshot.appendSections([.nowPlaying,.popular,.topRated,.upcoming])
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    private func updateDataSource(with newData: [MovieResponse.Movie], section: Section) {
        DispatchQueue.main.async {
            // Get current snapshot
            var snapshot = self.dataSource.snapshot(for: section)
            snapshot.append(newData)
            self.dataSource.apply(snapshot, to: section, animatingDifferences: true, completion: nil)
        }
    }
}

extension DiscoverViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = dataSource.itemIdentifier(for: indexPath) else {
            print("No Movie")
            return
        }
        viewModel.showMovieDetail(with: movie)
    }
}

extension DiscoverViewController: DiscoverViewModelDelegate {
    func fetchMoviesDidFinish(result: Result<([MovieResponse.Movie]), HTTPError>) {
        switch result {
        case .success(let success):
            updateDataSource(with: success, section: .discover)
        case .failure(let failure):
            // handle error here
            print(failure)
        }
    }
}
