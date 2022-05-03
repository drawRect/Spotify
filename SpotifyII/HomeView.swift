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

struct NewReleaseCellView: View {
    let num: Int
    var body: some View {
        HStack {
            VStack {
                Image("photo")
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .background(Color.blue)
            }
            VStack {
                Text("Hello")
                Text("Tracks: 16")
                Text("Adele")
            }
        }
        .padding()
        .background(Color.red)
    }
}

struct HomeView: View {
    private var columns: [GridItem] = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                alignment: .leading,
                spacing: 16,
                pinnedViews: [.sectionHeaders]
            ) {
                Section(header: Text("New Release Albums")) {
                    ForEach(0...10, id: \.self) { index in
                        NewReleaseCellView(num: index)
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


