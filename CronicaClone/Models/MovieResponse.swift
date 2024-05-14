//
//  MovieDetail.swift
//  CronicaClone
//
//  Created by Hakan Or on 11.05.2024.
//

import Foundation

struct MovieResponse: Decodable, Hashable {
    
    let uuid = UUID()
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    private enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    struct Movie: Decodable, Hashable {
        let uuid = UUID()
        
        let adult: Bool
        let backdropPath: String?
        let genreIds: [Int]
        let id: Int
        let originalLanguage: String
        let originalTitle: String
        let overview: String
        let popularity: Double
        let posterPath: String?
        let releaseDate: String
        let title: String
        let video: Bool
        let voteAverage: Double
        let voteCount: Int

        private enum CodingKeys: String, CodingKey {
            case adult, id, overview, popularity, title, video
            case backdropPath = "backdrop_path"
            case genreIds = "genre_ids"
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }
}

