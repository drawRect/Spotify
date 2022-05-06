//
//  LoginFetcher.swift
//  SpotifyII
//
//  Created by BKS-GGS on 20/04/22.
//

import Foundation
import Combine

protocol AuthFetchable {
   func exchangeCodeForToken(code: String) -> AnyPublisher<AuthResponse, MyError>
}

class AuthFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

private extension AuthFetcher {
    
    func makeExchangeCodeRequest(code: String) -> URLRequest? {
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return nil
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI)
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded ", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)

        let basicToken = Constants.clientId + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get base64")
            return nil
        }

        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        return request
    }
}


extension AuthFetcher: AuthFetchable {
    func exchangeCodeForToken(code: String) -> AnyPublisher<AuthResponse, MyError> {
        exchange(with: makeExchangeCodeRequest(code: code))
    }
    
    private func exchange<T>(with request: URLRequest?) -> AnyPublisher<T, MyError> where T: Decodable {
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
}
