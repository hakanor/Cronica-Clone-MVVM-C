//
//  DiscoverViewModel.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import Foundation

protocol DiscoverViewModelDelegate: AnyObject {
    func fetchMoviesDidFinish(result: Result<([MovieResponse.Movie]),HTTPError>)
}

protocol DiscoverViewModelInterface {
    var delegate: DiscoverViewModelDelegate? { get set }
    func fetchMovies() async
    func showMovieDetail(with movie: MovieResponse.Movie)
}

final class DiscoverViewModel: DiscoverViewModelInterface {

    var coordinator: DiscoverCoordinating?
    weak var delegate: DiscoverViewModelDelegate?
    
    private var discover = [MovieResponse.Movie]()
    
    private var movieService: MovieService!

    init(coordinator: DiscoverCoordinating, movieService: MovieService = MovieServiceImpl()) {
        self.coordinator = coordinator
        self.movieService = movieService
    }
    
    func showMovieDetail(with movie: MovieResponse.Movie) {
        coordinator?.showMovieDetailView(with: movie)
    }
    
    func fetchMovies() async {
        do {
            discover = try await movieService.fetchMovies(path: .discoverMovies).results
            delegate?.fetchMoviesDidFinish(result: .success(discover))
        } catch {
            delegate?.fetchMoviesDidFinish(result: .failure(error as? HTTPError ?? .unknown))
        }
        
    }
}
