//
//  MovieDetailViewController.swift
//  CronicaClone
//
//  Created by Hakan Or on 11.05.2024.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    // MARK: - Properties
    var viewModel: MovieDetailViewModelInterface
    
    var dataSource: CreditsDiffableDataSource!
    var snapshot: NSDiffableDataSourceSnapshot<Section, CreditsResponse.Person>!
    
    // MARK: - Subviews
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aboutView: CustomInfoView = {
        let view = CustomInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var infoView: CustomInfoView = {
        let view = CustomInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Subviews
    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: CustomCompositionalLayouts.castSection())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Life Cycle
    init(viewModel: MovieDetailViewModelInterface) {
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
        updateUI()
        setupDataSource()
        configureCollectionView()
        setupDataSourceHeader()
        Task {
            await viewModel.fetchCredits()
        }
    }
    
    // MARK: - Methods
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(verticalStackView)
        
        [imageView, titleLabel, subtitleLabel, aboutView, collectionView, infoView].forEach(verticalStackView.addArrangedSubview(_:))
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 500),
            imageView.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            verticalStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            verticalStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            collectionView.heightAnchor.constraint(equalToConstant: 250),
            collectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            aboutView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            infoView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func updateUI() {
        self.title = viewModel.movie?.title
        titleLabel.text = viewModel.movie?.title
        subtitleLabel.text = viewModel.movie?.originalTitle
        aboutView.configure(withTitle: "About", description: viewModel.movie?.overview ?? "nil")
        infoView.configure(withTitle: "Info", description: viewModel.movie?.releaseDate ?? "nil")
        Task {
            await viewModel.fetchImageData()
        }
    }
    
    private func configureCollectionView() {
        collectionView.register(PersonCell.self, forCellWithReuseIdentifier: PersonCell.reuseIdentifier)
        collectionView.register(SimpleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SimpleHeaderView.reuseIdentifier)
    }
    
    private func setupDataSource() {
        dataSource = CreditsDiffableDataSource(collectionView: collectionView)
        // Apply initial snapshot
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, CreditsResponse.Person>()
        initialSnapshot.appendSections([.cast])
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    private func setupDataSourceHeader() {
        dataSource.supplementaryViewProvider = { [unowned self] (collectionView, kind, indexPath) in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SimpleHeaderView.reuseIdentifier, for: indexPath) as? SimpleHeaderView else {
                fatalError("Cannot create header view")
            }
            
            header.configure(with: Section.cast.rawValue)
            
            return header
        }
    }
    
    private func updateDataSource(with newData: [CreditsResponse.Person], section: Section) {
        DispatchQueue.main.async {
            // Get current snapshot
            var snapshot = self.dataSource.snapshot(for: section)
            snapshot.append(newData)
            self.dataSource.apply(snapshot, to: section, animatingDifferences: true, completion: nil)
        }
    }
}

extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func fetchImageDataDidFinish(result: Result<(Data), HTTPError>) {
        switch result {
        case .success(let success):
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: success)
            }
        case .failure(let failure):
            // handle error here, show alert
            print(failure.localizedDescription)
        }
    }
    
    func fetchCreditsDidFinish(result: Result<([CreditsResponse.Person]), HTTPError>) {
        switch result {
        case .success(let success):
            updateDataSource(with: success, section: .cast)
        case .failure(let failure):
            // handle error here, show alert
            print(failure.localizedDescription)
        }
    }
}
