//
//  MockBuilder.swift
//  CronicaCloneTests
//
//  Created by Hakan Or on 13.05.2024.
//

import Foundation
@testable import CronicaClone

enum MockBuilder {
    
    static let movieResponse: MovieResponse = {
        let movie = MovieResponse.Movie(
            adult: false,
            backdropPath: "/fY3lD0jM5AoHJMunjGWqJ0hRteI.jpg",
            genreIds: [878, 27, 28],
            id: 940721,
            originalLanguage: "ja",
            originalTitle: "ゴジラ-1.0",
            overview: "Postwar Japan is at its lowest point when a new crisis emerges in the form of a giant monster, baptized in the horrific power of the atomic bomb.",
            popularity: 3701.194,
            posterPath: "/hkxxMIGaiCTmrEArK7J56JTKUlB.jpg",
            releaseDate: "2023-11-03",
            title: "Godzilla Minus One",
            video: false,
            voteAverage: 7.688,
            voteCount: 942
        )
        return MovieResponse(page: 1, results: [movie], totalPages: 1, totalResults: 1)
    }()
    
    static let creditsResponse: CreditsResponse = {
        let person = CreditsResponse.Person(adult: false, gender: 2, id: 31, knownForDepartment: "Acting", name: "Tom Hanks", originalName: "Tom Hanks", popularity: 1.96, profilePath: "/xndWFsBlClOJFRdhSt4NBwiPq2o.jpg", castId: 7, character: "Forrest Gump", creditId: "52fe420ec3a36847f800074f", order: 0, department: nil, job: nil)
        return CreditsResponse(id: 1, cast: [person], crew: [person])
    }()
    
    static let movieData = """
        {
           "page":1,
           "results":[
              {
                 "adult":false,
                 "backdrop_path":"/fY3lD0jM5AoHJMunjGWqJ0hRteI.jpg",
                 "genre_ids":[
                    878,
                    27,
                    28
                 ],
                 "id":940721,
                 "original_language":"ja",
                 "original_title":"ゴジラ-1.0",
                 "overview":"Postwar Japan is at its lowest point when a new crisis emerges in the form of a giant monster, baptized in the horrific power of the atomic bomb.",
                 "popularity":3701.194,
                 "poster_path":"/hkxxMIGaiCTmrEArK7J56JTKUlB.jpg",
                 "release_date":"2023-11-03",
                 "title":"Godzilla Minus One",
                 "video":false,
                 "vote_average":7.688,
                 "vote_count":942
              }
           ],
           "total_pages":44129,
           "total_results":882580
        }
        """.data(using: .utf8)!
    
    
    
    static let creditsData = """
        {
            "id":13,"cast":[{"adult":false,"gender":2,"id":31,"known_for_department":"Acting","name":"Tom Hanks","original_name":"Tom Hanks","popularity":1.96,"profile_path":"/xndWFsBlClOJFRdhSt4NBwiPq2o.jpg","cast_id":7,"character":"Forrest Gump","credit_id":"52fe420ec3a36847f800074f","order":0}],
            "crew":[{"adult":false,"gender":2,"id":31,"known_for_department":"Acting","name":"Tom Hanks","original_name":"Tom Hanks","popularity":1.96,"profile_path":"/xndWFsBlClOJFRdhSt4NBwiPq2o.jpg","cast_id":7,"character":"Forrest Gump","credit_id":"52fe420ec3a36847f800074f","order":0}]
        }
        """.data(using: .utf8)!
}


