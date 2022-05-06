//
//  HomeFetcher.swift
//  SpotifyII
//
//  Created by BKS-GGS on 03/05/22.
//

import Foundation
import Combine

protocol HomeFetchable {
    func getNewReleases() -> AnyPublisher<NewReleasesResponse, MyError>
}

class HomeFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension HomeFetcher: HomeFetchable {
    
    var request: URLRequest? {
        guard let url = URL(string: "https://api.spotify.com/v1" + "/browse/new-releases?limit=50"),
              let token = token else {
            return nil
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        return request
    }
    
    func getNewReleases() -> AnyPublisher<NewReleasesResponse, MyError> {
        requestNewReleases(with: request)
    }
    
    private func requestNewReleases<T>(with request: URLRequest?) -> AnyPublisher<T, MyError> where T: Decodable {
        guard let urlRequest = request else {
            let error = MyError.network(description: "Couldn't create URL")
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { error in
                MyError.network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
    
    var token: String? {
        UserDefaultsHelper.getData(type: String.self, forKey: .accessToken)
    }
    
}
