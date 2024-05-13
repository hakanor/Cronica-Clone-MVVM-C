//
//  JSONDecoderWrapper.swift
//  CronicaClone
//
//  Created by Hakan Or on 12.05.2024.
//

import Foundation

protocol Decoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

struct JSONDecoderWrapper: Decoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch {
            throw HTTPError.serializationError
        }
    }
}
