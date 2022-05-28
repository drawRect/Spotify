//
//  TabView.swift
//  SpotifyII
//
//  Created by BKS-GGS on 22/04/22.
//

import SwiftUI

enum TabBarItem {
    case home
    case search
    case library
}

struct ContentView: View {
    @EnvironmentObject private var authentication: AuthViewModel
    @Environment(\.appState) private var appState
    @ObservedObject private var loadingIndicatorViewModel: LoadingIndicatorViewModel
    
    init(loadingIndicatorViewModel: LoadingIndicatorViewModel) {
        self.loadingIndicatorViewModel = loadingIndicatorViewModel
    }
    
    var body: some View {
        tabBarView()
    }
    
    @ViewBuilder private func tabBarView() -> some View {
        TabView(selection: $authentication.selectedTab) {
            HomeView(viewModel: HomeViewModel(homeFetcher: HomeFetcher()))
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(TabBarItem.home)
            
            SearchView()
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
                .tag(TabBarItem.search)
            
            LibraryView()
                .tabItem { Label("Library", systemImage: "building.columns") }
                .tag(TabBarItem.library)
        }
        .accentColor(Color(hex: "#1ED760"))
        .onAppear {
            let appearance = UITabBarAppearance()
            
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.secondarySystemBackground
            
            UITabBar.appearance().standardAppearance = appearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
        .onChange(of: appState) { newValue in
            switch newValue {
            case .active:
                performSync()
            case .background, .inactive:
                break
            }
        }
        .onReceive(authentication.$authResponse) { _ in
            performSync()
        }
    }
    
    private func performSync() {
        //        syncManager.services = authentication.configureServices()
        //        syncManager.initializeSyncTimer()
        //        syncManager.execute()
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(loadingIndicatorViewModel: LoadingIndicatorViewModel(displayedText: "Loading...", isLoading: true, color: Color.red))
    }
}
