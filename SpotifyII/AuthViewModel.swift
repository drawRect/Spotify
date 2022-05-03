//
//  AuthViewModel.swift
//  SpotifyII
//
//  Created by BKS-GGS on 20/04/22.
//

import Foundation
import Combine

enum AuthenticationState: String, Equatable {
    case authenticated
    case unauthenticated
}

class AuthViewModel: ObservableObject {
    
    private let loginFetcher: AuthFetchable
    private var disposables = Set<AnyCancellable>()
    
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var selectedTab: TabBarItem = .home
    @Published var authResponse: AuthResponse?
    
    init(loginFetcher: AuthFetcher) {
        self.loginFetcher = loginFetcher
    }
    
    var signInUrlRequest: URLRequest {
        guard let url = AuthManager.shared.signInURL else {
            fatalError()
        }
        return URLRequest(url: url)
    }
    
    func fetchAuthResponse(using code: String) {
        fetchToken(forCode: code) { authResponse in
            self.cacheToken(authInfo: authResponse)
        }
    }
    
    private func fetchToken(forCode code: String, completion: @escaping ((AuthResponse) ->Void)) {
        loginFetcher.exchangeCodeForToken(code: code)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.authResponse = nil
                case .finished: break
                }
            }, receiveValue: {[weak self] auth in
                guard let self = self else { return}
                self.authResponse = auth
                self.authenticationState = .authenticated
                completion(auth)
            })
            .store(in: &disposables)
    }
    
    private func cacheToken(authInfo: AuthResponse) {
        UserDefaultsHelper.setData(value: authInfo.accessToken, key: .accessToken)
        if let refreshToken = authInfo.refreshToken {
            UserDefaultsHelper.setData(value: refreshToken, key: .refreshToken)
        }
        let expiresIn = Date().addingTimeInterval(TimeInterval(authInfo.expiresIn))
        UserDefaultsHelper.setData(value: expiresIn, key: .expiresIn)
    }
}
