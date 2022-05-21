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
    func getRecommendataions() -> AnyPublisher<RecommendationsResponse, MyError>
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
    
    private var recomendedGenreEndPoint: String {
        "https://api.spotify.com/v1" + "/recommendations/available-genre-seeds"
    }
    
    func getNewReleases() -> AnyPublisher<NewReleasesResponse, MyError> {
        requestData(with: request(with: newReleasesEndPoint))
    }
    
    func getFeaturedPlaylists() -> AnyPublisher<FeaturedPlaylistsResponse, MyError> {
        requestData(with: request(with: featuredPlaylistsEndPoint))
    }
    
    func getRecommendataions() -> AnyPublisher<RecommendationsResponse, MyError> {
        requestData(with: request(with: recomendedGenreEndPoint))
    }
    
    private func requestData<T>(with request: URLRequest?) -> AnyPublisher<T, MyError> where T: Decodable {
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
