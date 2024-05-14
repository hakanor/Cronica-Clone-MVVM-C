//
//  CreditsResponse.swift
//  CronicaClone
//
//  Created by Hakan Or on 13.05.2024.
//

import Foundation

struct CreditsResponse: Decodable, Hashable {
    var id: Int
    var cast: [Person]
    var crew: [Person]
    
    struct Person: Decodable, Hashable {
        let uuid = UUID()
        
        let adult: Bool
        let gender: Int
        let id: Int
        let knownForDepartment: String
        let name: String
        let originalName: String
        let popularity: Double
        let profilePath: String?
        let castId: Int?
        let character: String?
        let creditId: String
        let order: Int?
        let department: String?
        let job: String?
        
        private enum CodingKeys: String, CodingKey {
            case adult, gender, id, name, popularity, character, order, department, job
            case knownForDepartment = "known_for_department"
            case originalName = "original_name"
            case profilePath = "profile_path"
            case castId = "cast_id"
            case creditId = "credit_id"
        }
    }
}
