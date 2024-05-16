//
//  MovieService.swift
//  CronicaClone
//
//  Created by Hakan Or on 12.05.2024.
//

import Foundation


protocol MovieService {
    func fetchMovies(path: MovieListEndpoint) async throws -> MovieResponse
    func fetchMovieDetails(id: Int) async throws -> MovieResponse
    func fetchCredits(id: Int) async throws -> CreditsResponse?
}

final class MovieServiceImpl: MovieService {
    
    let client: HTTPClient
    let decoder: Decoder
    
    init(client: HTTPClient = HTTPClientImpl(), decoder: Decoder = JSONDecoderWrapper()) {
        self.client = client
        self.decoder = decoder
    }
    
    func fetchMovies(path: MovieListEndpoint) async throws -> MovieResponse {
        do {
            let url = URLBuilder.build(endpoint: path, page: 1)
            let movieData = try await client.performRequest(URLRequest(url: url!))
            let decodedObject: MovieResponse = try decoder.decode(MovieResponse.self, from: movieData.data)
            return decodedObject
        } catch {
            throw error as! HTTPError
        }
    }
    
    func fetchMovieDetails(id: Int) async throws -> MovieResponse {
        do {
            let url = URLBuilder.build(endpoint: MovieListEndpoint.movie, id: id)
            let movieData = try await client.performRequest(URLRequest(url: url!))
            let decodedObject: MovieResponse = try decoder.decode(MovieResponse.self, from: movieData.data)
            return decodedObject
        } catch {
            throw error as! HTTPError
        }
    }
    
    func fetchCredits(id: Int) async throws -> CreditsResponse? {
        do {
            let url = URLBuilder.build(endpoint: MovieListEndpoint.movie, id: id, stringAfterId: "credits")
            let creditsData = try await client.performRequest(URLRequest(url: url!))
            let decodedObject: CreditsResponse = try decoder.decode(CreditsResponse.self, from: creditsData.data)
            return decodedObject
        } catch {
            throw error as! HTTPError
        }
    }
}
