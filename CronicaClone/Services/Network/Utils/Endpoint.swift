//
//  Endpoint.swift
//  CronicaClone
//
//  Created by Hakan Or on 12.05.2024.
//

import Foundation

protocol Endpoint {
    var path: String { get }
}

enum MovieListEndpoint: String, Endpoint {
    case nowPlaying = "movie/now_playing"
    case upcoming = "movie/upcoming"
    case topRated = "movie/top_rated"
    case popular = "movie/popular"
    case discoverMovies = "discover/movie"
    case movie = "movie"
    
    var path: String {
        return self.rawValue
    }
}
