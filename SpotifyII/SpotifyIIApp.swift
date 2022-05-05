//
//  SpotifyIIApp.swift
//  SpotifyII
//
//  Created by BKS-GGS on 20/04/22.
//

import SwiftUI

@main
struct SpotifyIIApp: SwiftUI.App {
    @StateObject var authenticationModel: AuthViewModel = AuthViewModel(loginFetcher: AuthFetcher())

    var body: some Scene {
        WindowGroup {
            Group {
                switch authenticationModel.authenticationState {
                case .unauthenticated:
                    AuthView(viewModel: authenticationModel)
                case .authenticated:
                    ContentView(loadingIndicatorViewModel: LoadingIndicatorViewModel(displayedText: "Loading...",
                                                          isLoading: true,
                                                          color: Color.teal))
                        .modifier(AppPhaseModifier())
                }
            }
            .environmentObject(authenticationModel)
        }
    }
}
