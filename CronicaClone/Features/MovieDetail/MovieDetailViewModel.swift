//
//  MovieDetailViewModel.swift
//  CronicaClone
//
//  Created by Hakan Or on 11.05.2024.
//

import Foundation

protocol MovieDetailViewModelDelegate: AnyObject {
    func fetchCreditsDidFinish(result: Result<([CreditsResponse.Person]),HTTPError>)
    func fetchImageDataDidFinish(result: Result<(Data),HTTPError>)
}

protocol MovieDetailViewModelInterface {
    var movie: MovieResponse.Movie? { get set }
    func fetchCredits() async
    func fetchImageData() async
    var delegate: MovieDetailViewModelDelegate? {get set}
}

final class MovieDetailViewModel: MovieDetailViewModelInterface {
 
    var coordinator: MovieDetailCoordinating?
    weak var delegate: MovieDetailViewModelDelegate?
    
    var movie: MovieResponse.Movie?
    var cast: [CreditsResponse.Person]?
    
    private var movieService: MovieService!
    
    init(coordinator: MovieDetailCoordinating, movieService: MovieService = MovieServiceImpl()) {
        self.coordinator = coordinator
        self.movieService = movieService
    }
    
    deinit {
        coordinator?.didFinish()
        print(#fileID + " deinit")
    }
    
    func fetchCredits() async {
        do {
            cast = try await movieService.fetchCredits(id: movie?.id ?? 1)?.cast
            delegate?.fetchCreditsDidFinish(result: .success(cast!))
        } catch {
            delegate?.fetchCreditsDidFinish(result: .failure(error as? HTTPError ?? .noData))
        }
        
    }
    
    func fetchImageData() async {
        do {
            let imageUrl = URLBuilder.buildImageUrl(path: movie?.posterPath)
            let data = try await HTTPClientImpl().performRequest(URLRequest(url: imageUrl!))
            delegate?.fetchImageDataDidFinish(result: .success(data.data))
        } catch {
            delegate?.fetchImageDataDidFinish(result: .failure(error as? HTTPError ?? .unknown))
        }
    }
}
