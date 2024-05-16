//
//  urlBuilder.swift
//  CronicaClone
//
//  Created by Hakan Or on 12.05.2024.
//

import Foundation

// TODO: hide apiKey
struct Key {
    static let API_KEY = "90dd77ae7bc044d30ee6276dfd33a131"
}

enum URLBuilder {
    static func build(endpoint: Endpoint, page: Int? = nil, id: Int? = nil, stringAfterId: String? = nil) -> URL? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "api.themoviedb.org"
        component.path = "/3/\(endpoint.path)"
        component.queryItems = [
            .init(name: "api_key", value: Key.API_KEY),
            .init(name: "include_adult", value: "false"),
            .init(name: "include_video", value: "false"),
        ]
        if let page = page {
            component.queryItems?.append(.init(name: "page", value: "\(page)"))
        }
        if let id = id {
            component.path = "/3/\(endpoint.path)/\(id)"
        }
        if let stringAfterId = stringAfterId {
            component.path += "/\(stringAfterId)"
        }
        return component.url
    }

    static func buildImageUrl(path: String? = nil) -> URL? {
        if let path {
            var component = URLComponents()
            component.scheme = "https"
            component.host = "image.tmdb.org"
            component.path = "/t/p/w500\(path)"
            return component.url
        }
        return nil
    }
}

