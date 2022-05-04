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
        GeometryReader { geo in
            HStack {
                VStack {
                    Image(systemName: "music.quarternote.3")
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width*0.40, height: geo.size.width*0.40)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(8)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("I NEVER LIKED YOU")
                        .font(.system(size: 20, weight: .semibold))
                    Text("Future")
                        .font(.system(size: 18, weight: .light))
                    Text("Tracks: 16")
                        .font(.system(size: 18, weight: .thin))
                }
                .fixedSize(horizontal: false, vertical: true)
            }
        }
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
    }
}

struct HomeView: View {
    private var columns: [GridItem] = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                LazyVGrid(
                    columns: columns,
                    alignment: .leading,
                    spacing: 16,
                    pinnedViews: [.sectionHeaders]
                ) {
                    Section(
                        header:
                            VStack {
                                Text("New Release Albums")
                                    .font(.system(size: 22, weight: .thin))
                                    .foregroundColor(.black)
                            }
                            .padding()
                    ) {
                        ForEach(0...3, id: \.self) { index in
                            NewReleaseCellView(num: index)
                                .padding()
                                .frame(width: geo.size.width, height: geo.size.height*0.25)
                        }
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


