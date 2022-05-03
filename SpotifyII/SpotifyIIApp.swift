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
//                    AuthView(viewModel: authenticationModel)
                    HomeView()
                case .authenticated:
                    ContentView()
                        .modifier(AppPhaseModifier())
                }
            }
            .environmentObject(authenticationModel)
        }
    }
}
