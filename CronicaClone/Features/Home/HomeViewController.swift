//
//  HomeViewController.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import UIKit

enum Section: String, Hashable {
    case nowPlaying = "Now Playing"
    case upcoming = "Upcoming"
    case topRated = "Top Rated"
    case popular = "Popular"
    case cast = "Cast & Crew"
    case discover = "Discover"
}

final class HomeViewController: UIViewController {
    // MARK: - Properties
    var viewModel: HomeViewModelInterface
    
    var dataSource: MoviesDiffableDataSource!
    var snapshot: NSDiffableDataSourceSnapshot<Section, MovieResponse.Movie>!
    
    // MARK: - Subviews
    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: CustomCompositionalLayouts.listSection())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Life Cycle
    init(viewModel: HomeViewModelInterface) {
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
        setupDataSourceHeader()
        Task {
            await viewModel.fetchMovies()
        }
    }
    
    // MARK: - Functions
    private func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Home"
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame = view.frame
        collectionView.delegate = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
        collectionView.register(SimpleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SimpleHeaderView.reuseIdentifier)
    }
    
    private func setupDataSource() {
        dataSource = MoviesDiffableDataSource(collectionView: collectionView)
        // Apply initial snapshot
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, MovieResponse.Movie>()
        initialSnapshot.appendSections([.nowPlaying,.popular,.topRated,.upcoming])
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
        
    private func setupDataSourceHeader() {
        dataSource.supplementaryViewProvider = { [unowned self] (collectionView, kind, indexPath) in

            let sectionMappings: [Section] = [.nowPlaying, .upcoming, .topRated, .popular]

            let section = sectionMappings[indexPath.section]

            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SimpleHeaderView.reuseIdentifier, for: indexPath) as? SimpleHeaderView else {
                fatalError("Cannot create header view")
            }
            
            header.configure(with: section.rawValue)
            
            return header
        }
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

extension HomeViewController: HomeViewModelDelegate {
    func fetchMoviesDidFinish(result: Result<(nowPlaying: [MovieResponse.Movie], upcoming: [MovieResponse.Movie], topRated: [MovieResponse.Movie], popular: [MovieResponse.Movie]), HTTPError>) {
        switch result {
        case .success(let success):
            updateDataSource(with: success.nowPlaying, section: .nowPlaying)
            updateDataSource(with: success.upcoming, section: .upcoming)
            updateDataSource(with: success.topRated, section: .topRated)
            updateDataSource(with: success.popular, section: .popular)
        case .failure(let failure):
            // handle error here, show alert
            print(failure.localizedDescription)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = dataSource.itemIdentifier(for: indexPath) else {
            print("No Movie")
            return
        }
        viewModel.showMovieDetail(with: movie)
    }
}
