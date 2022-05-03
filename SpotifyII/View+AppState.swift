//
//  View+AppState.swift
//  SpotifyII
//
//  Created by BKS-GGS on 22/04/22.
//

import SwiftUI

extension View {
    func changeAppState(_ value: AppState) -> some View {
        self.environment(\.appState, value)
    }
}

struct AppStateKey: EnvironmentKey {
    static var defaultValue: AppState = .active
}

enum AppState: Comparable {
    case active
    case inactive
    case background
}

extension EnvironmentValues {
    var appState: AppState {
        get { self[AppStateKey.self] }
        set { self[AppStateKey.self] = newValue }
    }
}

struct AppPhaseModifier: ViewModifier {
    @State private var appState: AppState = .active

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                self.appState = .active
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                self.appState = .background
            }
            .changeAppState($appState.wrappedValue)
    }
}

