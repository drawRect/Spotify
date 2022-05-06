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
    func getFeaturedPlaylists() -> AnyPublisher<FeaturedPlaylistsResponse, MyError>
}

class HomeFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension HomeFetcher: HomeFetchable {
    
    private func request(with endpoint: String) -> URLRequest? {
        guard let url = URL(string: endpoint),
              let token = token else {
            return nil
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        return request
    }
    
    private var newReleasesEndPoint: String {
        "https://api.spotify.com/v1" + "/browse/new-releases?limit=50"
    }
    
    private var featuredPlaylistsEndPoint: String {
        "https://api.spotify.com/v1" + "/browse/featured-playlists?limit=20"
    }
    
    func getNewReleases() -> AnyPublisher<NewReleasesResponse, MyError> {
        requestNewReleases(with: request(with: newReleasesEndPoint))
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
    
    func getFeaturedPlaylists() -> AnyPublisher<FeaturedPlaylistsResponse, MyError> {
        requestNewReleases(with: request(with: featuredPlaylistsEndPoint))
    }
    
    var token: String? {
        UserDefaultsHelper.getData(type: String.self, forKey: .accessToken)
    }
    
}
