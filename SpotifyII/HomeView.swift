//
//  HomeView.swift
//  SpotifyII
//
//  Created by BKS-GGS on 22/04/22.
//

import SwiftUI

enum HomeSectionType {
    case newReleases
    case featuredPlaylists
    case recommendedTracks
    
    var title: String {
        switch self {
        case .newReleases: return "New Release Albums"
        case .featuredPlaylists: return "Featured Playlists"
        case .recommendedTracks: return "Recommended"
        }
    }
}


struct HomeView: View {
    private let sections: [HomeSectionType] = [
        .newReleases,
        .featuredPlaylists,
        .recommendedTracks
    ]
    @State private var selectedSection: HomeSectionType = .newReleases
    
    var body: some View {
        VStack {
            Picker("", selection: $selectedSection) {
                ForEach(sections, id: \.self) {
                    Text($0.title)
                        .font(.system(size: 22, weight: .thin))
                }
            }
            .pickerStyle(.segmented)
            
            getSelectedSectionView()
            
            Spacer()
        }
        .padding()
    }
    
    @ViewBuilder private func getSelectedSectionView() -> some View {
        switch selectedSection {
        case .newReleases:
            NewReleasesView()
        case .featuredPlaylists:
            FeaturedPlaylistsView()
        case .recommendedTracks:
            RecommededPlaylistView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
