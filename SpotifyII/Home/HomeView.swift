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
    
    var body: some View {
        VStack {
            Picker("", selection: $viewModel.selectedSection) {
                ForEach(viewModel.sections, id: \.self) { value in
                    Text(value.title)
                        .tag(value)
                }
            }
            .onChange(of: viewModel.selectedSection) { selected in
                switch selected {
                case .newReleases:
                    viewModel.requestNewReleases()
                    break
                case .featuredPlaylists:
                    viewModel.requestFeaturedPlaylists()
                    break
                case .recommendedTracks: break
                }
            }
            .pickerStyle(.automatic)
            
            getSelectedSectionView()
            
            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.requestNewReleases()
            viewModel.requestFeaturedPlaylists()
            viewModel.requestRecommendataionsGenres()
        }
    }
    
    @ViewBuilder private func getSelectedSectionView() -> some View {
        switch viewModel.selectedSection {
        case .newReleases:
            if ((viewModel.newData[.newReleases]?.isEmpty) == nil) {
                lodingIndicatorView
            } else {
                NewReleasesView(newReleaseVM:  viewModel.newData[.newReleases] as! [NewReleasesCellViewModel])
            }
        case .featuredPlaylists:
            if ((viewModel.newData[.featuredPlaylists]?.isEmpty) == nil) {
                lodingIndicatorView
            } else {
                FeaturedPlaylistsView(vm: viewModel.newData[.featuredPlaylists] as! [FeaturedPlaylistCellViewModel])
            }
        case .recommendedTracks:
            if ((viewModel.newData[.recommendedTracks]?.isEmpty) == nil) {
                lodingIndicatorView
            } else {
                RecommededPlaylistView(vm: viewModel.newData[.recommendedTracks] as! [RecommendedTrackCellViewModel])
            }
            
        }
    }
    
    private var lodingIndicatorView: LoadingIndicatorView {
        LoadingIndicatorView(viewModel: LoadingIndicatorViewModel(displayedText: "Loading...", isLoading: true, color: Color.teal))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(homeFetcher: HomeFetcher()))
    }
}
