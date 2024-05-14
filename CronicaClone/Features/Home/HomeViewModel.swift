//
//  HomeViewModel.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func fetchMoviesDidFinish(result: 
                              Result<(nowPlaying: [MovieResponse.Movie],
                                      upcoming: [MovieResponse.Movie],
                                      topRated: [MovieResponse.Movie],
                                      popular: [MovieResponse.Movie]),
                              HTTPError>)
}

protocol HomeViewModelInterface {
    func showMovieDetail(with movie: MovieResponse.Movie)
    func fetchMovies() async
    var delegate: HomeViewModelDelegate? {get set}
}

final class HomeViewModel: HomeViewModelInterface {
    
    private var nowPlaying = [MovieResponse.Movie]()
    private var upcoming = [MovieResponse.Movie]()
    private var topRated = [MovieResponse.Movie]()
    private var popular = [MovieResponse.Movie]()
    
    var coordinator: HomeCoordinating?
    weak var delegate: HomeViewModelDelegate?
    
    private var movieService: MovieService!
    
    init(coordinator: HomeCoordinating, movieService: MovieService = MovieServiceImpl()) {
        self.coordinator = coordinator
        self.movieService = movieService
    }
    
    func showMovieDetail(with movie: MovieResponse.Movie) {
        coordinator?.showMovieDetailView(with: movie)
    }
    
    func fetchMovies() async {
        do {
            nowPlaying = try await movieService.fetchMovies(path: .nowPlaying).results
            upcoming = try await movieService.fetchMovies(path: .upcoming).results
            topRated = try await movieService.fetchMovies(path: .topRated).results
            popular = try await movieService.fetchMovies(path: .popular).results
            delegate?.fetchMoviesDidFinish(result: .success((nowPlaying: nowPlaying,
                                                             upcoming: upcoming,
                                                             topRated: topRated,
                                                             popular: popular)))
        } catch {
            delegate?.fetchMoviesDidFinish(result: .failure(error as? HTTPError ?? .unknown))
        }
        
    }
}
