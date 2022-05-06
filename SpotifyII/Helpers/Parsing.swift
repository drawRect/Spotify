//
//  Parsing.swift
//  SpotifyII
//
//  Created by BKS-GGS on 20/04/22.
//

import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, MyError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            MyError.parsing(description: error.localizedDescription)
        }
        .eraseToAnyPublisher()
}
