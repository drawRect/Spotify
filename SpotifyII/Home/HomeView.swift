//
//  HomeView.swift
//  SpotifyII
//
//  Created by BKS-GGS on 22/04/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    @State private var selectedSection: HomeSectionType = .newReleases(viewModels: [])
    
    var body: some View {
        VStack {
            Picker(
                "", selection: $selectedSection
            ) {
                ForEach(viewModel.sections, id: \.title) {
                    Text($0.title)
                        .font(.system(size: 22, weight: .thin))
                }
            }
            .pickerStyle(.segmented)
            
            getSelectedSectionView()
            
            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.requestNewReleases { response in
                guard let response = response else {
                    return
                }
                let newAlbums = response.albums.items
                
                selectedSection = .newReleases(viewModels: newAlbums.compactMap { NewReleasesCellViewModel(name: $0.name, artworkURL: URL(string: $0.images.first?.url ?? ""), numberOfTracks: $0.total_tracks, artistName: $0.artists.first?.name ?? "")})
                viewModel.sections.append(selectedSection)
            }
            
            viewModel.requestFeaturedPlaylists { response in
                guard let response = response else {
                    return
                }
                let playlists = response.playlists.items
                
                selectedSection = .featuredPlaylists(viewModels: playlists.compactMap({FeaturedPlaylistCellViewModel(name: $0.name, artworkURL:URL(string: $0.images.first?.url ?? "") , creatorName: $0.owner.display_name)
                }))

                viewModel.sections.append(selectedSection)
            }
        }
    }
    
    @ViewBuilder private func getSelectedSectionView() -> some View {
        switch selectedSection {
        case .newReleases(let vm):
            if vm.isEmpty {
                LoadingIndicatorView(viewModel: LoadingIndicatorViewModel(displayedText: "Loading...", isLoading: true, color: Color.teal))
            } else {
                NewReleasesView(newReleaseVM:  vm)
            }
        case .featuredPlaylists(let vm):
            if vm.isEmpty {
                LoadingIndicatorView(viewModel: LoadingIndicatorViewModel(displayedText: "Loading...", isLoading: true, color: Color.teal))
            } else {
                FeaturedPlaylistsView(vm: vm)
            }
        case .recommendedTracks:
            RecommededPlaylistView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(homeFetcher: HomeFetcher()))
    }
}
