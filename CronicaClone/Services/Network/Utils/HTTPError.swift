//
//  HTTPError.swift
//  CronicaClone
//
//  Created by Hakan Or on 13.05.2024.
//


enum HTTPError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid Response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        case .unknown: return "Unknown error occured"
        }
    }
}
